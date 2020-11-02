# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


export EDITOR="emacs -nw"
alias "emacsnw"="emacs -nw"

# Alt-Enter to run in a new detached tmux session
bind '"\e\C-M":"\C-a\C-ktmux new-session -d \ntmux send-keys '"'"'\C-y'"'"' enter\n'

# <copy> source="http://stackoverflow.com/questions/9457233/unlimited-bash-history">
# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
# </copy>

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Git
alias gitcam="git commit -am "

# Findpdfs - recursive grep for string in pdfs
function findpdf {
    find . -iname '*.pdf' -exec echo ===== {} =====  \; -exec pdfgrep --color=always -in $1 {} \;
}

# Snort log line to csv
function snort2csv() {
    sed -e 's/^\(.*\)  \[\*\*] \([^ ]*\) \(.*\) \[Priority: \([0-9]\)] {\([A-Z]*\)} \([^ ]*\) -> \([^ ]*\)/\1;\2;\3;\4;\5;\6;\7/'
}

# Handling that kinit for some reason fails to get AFS token on recent linux mint (17-18)
# alias kinit="kinit && aklog"

# Shorthand for timestamps
alias mydate="date +%Y%m%d"
alias mymin="date +%Y%m%d-%H%M"
alias mysec="date +%Y%m%d-%H%M%S"

# # pyenv
# if [ -d "$HOME/.pyenv" ] ; then
#     export PATH="$HOME/.pyenv/bin:$PATH"
#     eval "$(pyenv init -)"
#     eval "$(pyenv virtualenv-init -)"
# fi

alias ll="ls -la"

function smbprint() {
    [[ -z "$SMB_PRINT_SERVER" ]] && echo "\$SMB_PRINT_SERVER not set" && return 1
    [[ -z "$SMB_PRINT_USER" ]] && echo "\$SMB_PRINT_USER not set" && return 2
    smbclient -U $SMB_PRINT_USER $SMB_PRINT_SERVER -c "print $1"
}


