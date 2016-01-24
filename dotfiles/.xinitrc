pkill -9 -u "$USER" -x gpg-agent
pkill -9 -u "$USER" -x ssh-agent
pkill -9 -u "$USER" -x xss-lock
pkill -9 -u "$USER" -x xscreensaver
set -x
#eval "$(gpg-agent --daemon --enable-ssh-support --write-env-file "$HOME/.gnupg/gpg-agent.env")"
eval "$(gpg-agent --daemon --write-env-file "$HOME/.gnupg/gpg-agent.env")"

xscreensaver -nosplash &> /dev/null &
xss-lock -- xscreensaver-command -lock  &> /dev/null &
exec ssh-agent notion 
