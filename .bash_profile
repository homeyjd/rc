#!/bin/bash

alias edit='open -a TextWrangler'
alias ls='ls -laG'
alias mt='multitail -CS php'
alias grep='grep --color'

alias centos-start='/Applications/VMware\ Fusion.app/Contents/Library/vmrun -T fusion start ~/Documents/Virtual\ Machines.localized/CentOS_64_server.vmwarevm nogui'
alias centos-stop='/Applications/VMware\ Fusion.app/Contents/Library/vmrun -T fusion stop ~/Documents/Virtual\ Machines.localized/CentOS_64_server.vmwarevm'
#alias centos='centos-start && ssh ip'

source ~/.bash_colors

# -[ Failed with 1 ]
# -[ jdecker@festus7 ~/Remote (0) 5:36 pm ]
# -[ !33 ] $

export PS1="\`LAST=\$?; [[ \$LAST -ne 0 && \$LAST -ne \"0\" ]] && echo -e \"\\n\"'\\033[0;34m'\"-[ \"'\\033[1;37m''\033[41m'\" Failed with \$LAST \"'\\033[00m''\\033[0;34m'\" ]\"\`\n\[$Blue\]-[ \[$Cyan\]\u\[$Blue\]@\[$Cyan\]\h \[$Yellow\]\w \[$Blue\](\[$BWhite\]\j\[$Blue\]) \[$Red\]\@ \[$Blue\]]\n-[ \[$Red\]!\! \[$Blue\]] \[$Red\]$\[$Color_Off\] "

