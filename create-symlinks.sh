#!/usr/bin/env bash

# Some fancy unicode
V="\xE2\x9C\x85" # Checkmark
X="\xE2\x9D\x8C" # Red cross
W="\xe2\x9a\xa0\xef\xb8\x8f" # Warning

if [ -z "$HOME" ]; then
    echo "HOME (~) is undefined, cannot sync"
    exit 1
fi

# remove suffix slash if exist
HOME=${HOME%"/"}

make_link () {
    # TODO: Accept one and two args; One is name of folder here that
    # should also be in home, two is desired TARGET and LINK
    # 
    # TODO: Handle that e.g. ./.config hold various folders that
    # should be symlinked individually (and parent folders should be
    # created as needed)
    TARGET="$(pwd)/$1"
    LINK="$HOME/$1"

    if [[ ! -e "$LINK" && ! -L "$LINK" ]]; then # can be a broken link (which doesn't -e but is -L)
        ln -s "$TARGET" "$LINK"
        echo -e "$V Created link for $1"
        
    elif [[ ! -L "$LINK" ]]; then
         >&2 echo -e "$W $LINK already exists and is not a symlink"

    elif [[ -L "$LINK" ]]; then
        if [[ "$(readlink -f $TARGET)" == "$(readlink -f $LINK)" ]]; then
            echo -e "$V $1 already exists"
        else
            >&2 echo -e "$W $1 already exists, but points to $(readlink -f $LINK) rather than $TARGET"
        fi
    else
        >&2 echo -e "$X I don't know how to handle $TARGET"
        exit 1
    fi
}

    
# Do the linking;
make_link .emacs.d
make_link .bashrc
make_link .gitignore
make_link .gnupg
make_link .tmux.conf
# See TODOs above on how these entries should be supported
# make_link .nixos /etc/nixos
# make_link .config/autorandr
# make_link .config/i3
# make_link .config/i3status
# make_link .config/mimeapps.list
