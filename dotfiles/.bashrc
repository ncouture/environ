# default command arguments
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls='ls --color=auto'

# shortcuts
alias pur='rm -v *~ \#*\# 2> /dev/null'
alias purge='find . -type f -name "*~" -or -name "\#*\#" -or -name "*.pyc" | xargs -I "{}" rm -v "{}" 2> /dev/null'
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
alias -- -list-packages='dpkg -l'
alias -- -list-files='dpkg -L'

function -find-file() {
    [[ $# -eq 1 ]] && { 
	apt-file search "$1" | grep --color=auto "/$1\$"
    } || { 
	echo 'Usage: -find-file <filename>'
    }
}

function wordfrequency() {
    # http://tomayko.com/writings/awkward-ruby
    awk '
        BEGIN { FS="[^a-zA-Z]+" } {
            for (i=1; i<=NF; i++) {
                word = tolower($i)
                words[word]++
            }
        }
        END {
            for (w in words)
                printf("%3d %s\n", words[w], w)
        }' | sort -n
}

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

# history timestamps (bash 4.3), ignoredups, size, etc.
#HISTCONTROL=ignoredups
HISTSIZE=-1
HISTFILESIZE=-1
HISTTIMEFORMAT='[%Y-%m-%d - %H:%M:%S] '
shopt -s checkwinsize # wrap lines
shopt -s extglob # more pathname expansion methods
shopt -s nocaseglob # case-insensitive pathname expansion

# env
export EDITOR=emacs
export PAGER=less
export PYTHONSTARTUP=~/.pythonrc.py
export PATH=~/bin:~/.cask/bin:~/.local/bin/:"$PATH"

# virtualenv
export WORKON_HOME=~/virtualenvs
export VIRTUALENV_PYTHON=/usr/bin/python3
export PROJECT_HOME=~/dev  # for mkproject
export GNUPGHOME="$HOME"/.gnupg

if [ -f "${HOME}/.gnupg/gpg-agent.env" ]; then
    source "${HOME}/.gnupg/gpg-agent.env"
    export GPG_AGENT_INFO
    export SSH_AUTH_SOCK
fi

GPG_TTY=$(tty)
export GPG_TTY

# set up SSH agent socket symlink
export SSH_AUTH_SOCK_LINK="/tmp/ssh-$USER/agent"
if ! [ -r $(readlink -m $SSH_AUTH_SOCK_LINK) ] && [ -r $SSH_AUTH_SOCK ]; then
	mkdir -p "$(dirname $SSH_AUTH_SOCK_LINK)" &&
	chmod go= "$(dirname $SSH_AUTH_SOCK_LINK)" &&
	ln -sfn $SSH_AUTH_SOCK $SSH_AUTH_SOCK_LINK
fi

# only run initkb if caps lock is still active
modmap="$(xmodmap -pm | grep ^lock)"
modmap=${modmap##+([[:space:]])}; modmap=${modmap%%+([[:space:]])}
if [[ "$modmap" != "lock" ]]; then
    echo "initkbd"
    initkbd &> /dev/null
fi

function update_banned_domains() {
    if [[ ! -f "domains.txt" ]]; then
	echo "Could not find domains.txt"
    fi

    while read domain; do
	echo -n "$domain" | md5sum -t | awk '{ print $1 }'
    done < domains.txt | curl -n -X PUT -F 'f:1=<-' ix.io/mXf
}

if [[ -x $(which npm) ]]; then
    npm config set prefix="$HOME/.node_modules_global"
    export PATH="$PATH:$HOME/.node_modules_global/bin"
fi
