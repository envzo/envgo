#!/bin/bash

if [[ "$BASH_SOURCE[0]" == "" ]]; then
	export ZOHOME=$(cd $(dirname $0) 2>&1 >/dev/null; pwd)
else
	export ZOHOME=$(cd $(dirname $BASH_SOURCE[0]) 2>&1 >/dev/null; pwd)
fi

export __zo_goenv__=0
export __zo_slogan__=0

zoinitenv() {
	# set GOPATH
	# for company uses, it's strongly recommand to have only one GOPATH

	if [[ $__zo_goenv__ == 1 ]]; then
		return
	fi

	export GOPATH=$ZOHOME
	export GOBIN=$GOPATH/bin
	export PATH=$GOPATH:$PATH

	export __zo_goenv__=1
}

zohome() {
	zoinitenv
	welcome

	if [[ $1 == "/" ]]; then
		jumpdir $ZOHOME
	else
		jumpdir $GOPATH/src/github.com/zodash/$1
	fi
}

welcome() {
	if [[ $__zo_slogan__ == 1 ]]; then
		return
	fi

	echo
	echo "    .-''-.  ,---.   .--.,---.  ,---. ____..--'    ,-----.     ";
	echo "  .'_ _   \ |    \  |  ||   /  |   ||        |  .'  .-,  '.   ";
	echo " / ( \` )   '|  ,  \ |  ||  |   |  .'|   .-'  ' / ,-.|  \ _ \  ";
	echo ". (_ o _)  ||  |\_ \|  ||  | _ |  | |.-'.'   /;  \  '_ /  | : ";
	echo "|  (_,_)___||  _( )_\  ||  _( )_  |    /   _/ |  _\`,/ \ _/  | ";
	echo "'  \   .---.| (_ o _)  |\ (_ o._) /  .'._( )_ : (  '\_/ \   ; ";
	echo " \  \`-'    /|  (_,_)\  | \ (_,_) / .'  (_'o._) \ \`\"/  \  ) /  ";
	echo "  \       / |  |    |  |  \     /  |    (_,_)|  '. \_/\`\`\".'   ";
	echo "   \`'-..-'  '--'    '--'   \`---\`   |_________|    '-----'     ";
	echo

	export __zo_slogan__=1
}

jumpdir() {
	if [ -d $1 ]; then
		cd $1
	fi
}
