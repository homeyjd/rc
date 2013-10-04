# Mac-only aliases
alias edit='open -a TextWrangler'
alias ls='ls -alG'
alias vmrun='/Applications/VMware\ Fusion.app/Contents/Library/vmrun -T fusion'

vm () {
	local FILE="${*:2}"
	if [ "$1" == "start" ]; then
		vmrun start "$FILE" nogui
	else
		vmrun $1 "$FILE"
	fi
}

#export PS1="\`LAST=\$?; [[ \$LAST -ne 0 && \$LAST -ne \"0\" ]] && echo -e \"\\n\"'\033[0;34m'\"-[ \"'\033[1;37m''\033[41m'\" Failed with \$LAST \"'\033[00m''\033[0;34m'\" ]\"\`\n\[$Blue\]-[ \[$Cyan\]\u\[$Blue\]@\[$Cyan\]\h \[$Yellow\]\w \[$Blue\](\[$BWhite\]\j\[$Blue\]) \[$Red\]\@ \[$Blue\]]\n\[$Blue\]-[ \[$Red\]!\! \[$Blue\]] \[$Red\]$\[$Color_Off\] "
