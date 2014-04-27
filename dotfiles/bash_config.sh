# source from ~/.bashrc 

# default command arguments
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls='ls --color=auto'

# shortcuts
alias pur='rm -v *~ \#*\# 2> /dev/null'
alias initkbd="setxkbmap us; xmodmap ~/.Xmodmap; xrdb -merge ~/.Xresources"
alias -- -search='apt-cache search'
alias -- -show='apt-cache show'
alias -- -stats='apt-cache stats'
alias -- -depends='apt-cache depends'
alias -- -install='apt-get install'
alias -- -remove='apt-get remove'
alias -- -check='apt-get check'
alias -- -clean='apt-get clean'
alias -- -purge='apt-get purge'
alias -- -update='apt-get update'
alias -- -upgrade='apt-get upgrade'
alias -- -up='apt-get update && apt-get upgrade'
alias -- -remove='apt-get remove'
alias -- -source='apt-get source'
alias -- -list="dpkg -l"
alias -- -files="dpkg -L"

function purge {
    rm -v /tmp/purge-*.log 2> /dev/null

    rand_num="$RANDOM"
    error_log="/tmp/purge-$rand_num.log"
    find . -type f -name "*~" -or -name "\#*\#" \
	                      -or -name "*.pyc" \
	                      -or -name "*.elc" 2>> "$error_log" | xargs -I "{}" rm -v "{}" 2>> "$error_log"
    echo "see \`$error_log' for errors."
}

function -find-files {
    [[ $# -eq 1 ]] && { 
	apt-file search "$1" | grep --color=auto "/$1\$"
    } || { 
	echo 'Usage: -find-file <filename>'
    }
}

function realpath {
    # prints an absolute path 
    echo "$(eval echo $@)"
}

function prepend_to_path {
    # prepends a directory to PATH if it exists
    # and is not already included in PATH
    if [[ "$#" -ne 1 ]]; then
	echo "Usage: prepend_to_path <path>"
	return 1
    fi

    dir="$(realpath $1)"
    if [[ ! -d "$dir" ]]; then
	echo 1>&2 "error: $dir is not a directory"
	return 1
    fi

    IFS=":"
    path=($PATH)
    for d in "${path[@]}"; do
	d="$(realpath $d)"
	if [[ "$d" == "$dir" ]]; then
	    echo 1>&2 "error: $dir is already in PATH ($PATH)"
	    return 1
	fi

	export PATH="$dir:$PATH"
    done
}

# I see fortunes in all my shells
if [[ "$PS1" ]]; then
    if [[ -x /usr/games/cowsay ]] && 
	[[ -d /usr/share/cowsay/cows/ ]] &&
	[[ -x /usr/games/fortune ]]
    then
	cows=(`ls /usr/share/cowsay/cows/`)
	rand_index=$[  ( $RANDOM % ${#cows[@]} ) ]
	#rand_index=`shuf --head-count=1 --input-range=0-$(( ${#cows[*]} - 1 ))`
	rand_cow=${cows[$rand_index]}
	echo && /usr/games/cowsay -f "$rand_cow" `/usr/games/fortune ` && echo
    elif [[ -x "/usr/games/fortune -o" ]]; then
	/usr/games/fortune
    fi
fi

# prompt
PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'

# history timestamps (bash 3.0), ignoredups, size, etc.
HISTCONTROL=ignoredups
HISTSIZE=20000
HISTFILESIZE=20000
HISTTIMEFORMAT='[%Y-%m-%d - %H:%M:%S] '
shopt -s checkwinsize # wrap lines
shopt -s extglob # more pathname expansion methods
shopt -s nocaseglob # case-insensitive pathname expansion

# env
export EDITOR=emacs
export PAGER=less
export PYTHONSTARTUP="~/.pythonrc.py"

prepend_to_path "~/bin" 2> /dev/null
prepend_to_path "~/.local/bin" 2> /dev/null
