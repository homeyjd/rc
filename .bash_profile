#!/bin/bash

alias edit='vi'
alias ls='ls -laG --colors'
alias mt='multitail -CS php'
alias grep='grep --color'

function tree () {
	find "${1:-.}" -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
}


function fix_web_perms () {
	find . -type d -exec chmod 755 {} \;
	find . -type f -exec chmod 644 {} \;
}

# CLI Colors
export CLICOLOR=1
#export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

source ~/.bash_colors
# -[ Failed with 1 ]
# -[ user@host ~/dir (0) 5:36 pm ]
# -[ !33 ] $
export PS1="\`LAST=\$?; [[ \$LAST -ne 0 && \$LAST -ne \"0\" ]] && echo -e \"\\n\"'\033[0;34m'\"-[ \"'\033[1;37m''\033[41m'\" Failed with \$LAST \"'\033[00m''\033[0;34m'\" ]\"\`\n\[$Blue\]-[ \[$Cyan\]\u\[$Blue\]@\[$Cyan\]\h \[$Yellow\]\w \[$Blue\](\[$BWhite\]\j\[$Blue\]) \[$Red\]\@ \[$Blue\]]\n\[$Blue\]-[ \[$Red\]!\! \[$Blue\]] \[$Red\]$\[$Color_Off\] "

# [0] -[ user@host ~/dir 5:36 pm ] $
# export PS1="\n\`LAST=\$?; [[ \$LAST -ne 0 && \$LAST -ne \"0\" ]] && echo -e '\033[1;37m''\033[41m'\"[\$LAST]\"'\033[00m''\033[0;34m'\" \"\`\[$Blue\]-[ \[$Cyan\]\u\[$Blue\]@\[$Cyan\]\h \[$Yellow\]\w \[$Red\]\@ \[$Blue\]] $\[$Color_Off\] "

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
