#!/bin/sh
set -e

sleep_time=5

while getopts "t:" option
do
  case $option in
    t)
      sleep_time=$OPTARG
      ;;
    :)
      echo "Option $OPTARG needs a value"
      exit 1
      ;;
    \?)
      echo "$OPTARG: unknown option. Valid option : -t <sleep_time_in_seconds>"
      exit 1
    ;;
  esac
done

exec dbus-run-session -- sh -c \
"signal-cli -a ${SIGNAL_ACCOUNT} daemon&
echo 'Waiting ${sleep_time}s for signal-cli to start' && sleep ${sleep_time} && npm run start"
