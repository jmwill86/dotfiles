parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1=" \[\e[32m\]\w \[\e[90m\]\$(parse_git_branch)\[\e[00m\]❯ "

#export PS1=" \[\e[37;40m\]➜\[\e[m\] \[\e[32m\]\w \[\e[91m\]\$(parse_git_branch)\[\e[00m\]: "
