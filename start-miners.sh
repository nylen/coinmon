#!/bin/sh

cd "$(dirname "$0")"

if screen -ls | grep -q '\.bitcoin'; then
  cat <<MSG

Bitcoin programs are already running.  To stop them, run this command:

  screen -dr bitcoin

Then, close all programs using Ctrl+C and close all shells using Ctrl+D
until you see a message that screen has terminated.

MSG
  exit
fi

if [ -f ./private.sh ]; then
  . ./private.sh
else
  cat <<MSG

Please create a file named private.sh with the following contents:

export USER=pool_username
export PASSWORD=pool_password
export HOST=pool_host
export PORT=pool_port

MSG
  exit
fi

screen -dmS bitcoin -c screenrc
