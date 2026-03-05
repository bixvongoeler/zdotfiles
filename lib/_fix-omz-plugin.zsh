setopt RE_MATCH_PCRE # _fix-omz-plugin function uses this regex style
# Workaround for zinit issue#504: remove subversion dependency. Function clones all files in plugin
# directory (on github) that might be useful to zinit snippet directory. Should only be invoked
# via zinit atclone"_fix-omz-plugin"
_fix-omz-plugin() {
    if [[ ! -f ._zinit/teleid ]]; then return 0; fi
    if [[ ! $(cat ._zinit/teleid) =~ "^OMZP::.*" ]]; then return 0; fi
    local OMZP_NAME=$(cat ._zinit/teleid | sed -n 's/OMZP:://p')
    git clone --quiet --no-checkout --depth=1 --filter=tree:0 https://github.com/ohmyzsh/ohmyzsh
    cd ohmyzsh
    git sparse-checkout set --no-cone plugins/$OMZP_NAME
    git checkout --quiet
    cd ..
    local OMZP_PATH="ohmyzsh/plugins/$OMZP_NAME"
    local file
    for file in $(ls -a ohmyzsh/plugins/$OMZP_NAME); do
        if [[ $file == '.' ]]; then continue; fi
        if [[ $file == '..' ]]; then continue; fi
        if [[ $file == '.gitignore' ]]; then continue; fi
        if [[ $file == 'README.md' ]]; then continue; fi
        if [[ $file == "$OMZP_NAME.plugin.zsh" ]]; then continue; fi
        cp $OMZP_PATH/$file $file
    done
    rm -rf ohmyzsh
}
