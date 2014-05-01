#!/bin/bash

# Mac-only aliases
alias edit='open -a TextWrangler'
alias ls='ls -alGh'
alias vmrun='/Applications/VMware\ Fusion.app/Contents/Library/vmrun -T fusion'
alias fab-cli='fab --set=use_ssh_config'
alias diffgui='/Applications/DiffMerge.app/Contents/MacOS/DiffMerge --nosplash'
alias du-sort="du -kd 1 | sort -nr | cut -f2 | xargs -I '{}' du -sh '{}'"

# Rsync Options
alias rsync-git='rsync -rlptOvz --exclude .git --exclude .idea --exclude .workspace --exclude .project --exclude .DS_Store --exclude .settings'
#-H = hard links
#-O = leave dir time
#-v = list files as transfer
#-z = compress
#-a = rlptgoD
#	r = recurse
#	l = links
#	p = perms
#	#t = timestamp
#	#g = group
#	#o = owner
#	#D = devices

sync() {
	local dest="$2"
	if [ ! "$dest" ]; then
		dest=vm
	fi
	if [ ! "$1" ]; then
		echo -e "  Usage: $0 <site> <dest_hoste(default=vm)\n  Effect:  rsync -rlptOvz --exclude <project/vcs_dirs> ~/Code/<site>/ vm:/opt/src/<site>/"
	fi
	case "$1" in
	# List all sites that should be synced to vm
	#dmv.org)
	*)
		rsync-git ~/Code/"$1/" "$dest:/opt/src/$1/"
	;;
	esac
}

vm () {
	local FILE="${*:2}"
	if [ "$1" == "start" ]; then
		vmrun start "$FILE" nogui
	else
		vmrun $1 "$FILE"
	fi
}

export PATH=~/bin:$PATH

#export PS1="\`LAST=\$?; [[ \$LAST -ne 0 && \$LAST -ne \"0\" ]] && echo -e \"\\n\"'\033[0;34m'\"-[ \"'\033[1;37m''\033[41m'\" Failed with \$LAST \"'\033[00m''\033[0;34m'\" ]\"\`\n\[$Blue\]-[ \[$Cyan\]\u\[$Blue\]@\[$Cyan\]\h \[$Yellow\]\w \[$Blue\](\[$BWhite\]\j\[$Blue\]) \[$Red\]\@ \[$Blue\]]\n\[$Blue\]-[ \[$Red\]!\! \[$Blue\]] \[$Red\]$\[$Color_Off\] "

. ~/.rvm/scripts/rvm
