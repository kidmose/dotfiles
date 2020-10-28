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
