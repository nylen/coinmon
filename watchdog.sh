#!/bin/bash

card=$1
ok="${2}00"
bad="${3}00"

[ "$bad" = 00 ] && echo "Usage: $0 cardnum oktemp badtemp" && exit

sleep 1
pid=`pgrep -f DEVICE=$card`

[ -z "$pid" ] && echo "Process not found" && exit

temp() {
  cat /tmp/bc-temp$card.txt | tail -n 1 | cut -d- -f2 | cut -d' ' -f2 | tr -d .
}

echo "[`date`] starting loop - miner pid=$pid"
kill -CONT $pid

while true; do
  while [ `temp` -lt $bad ]; do sleep 10; done
  echo "[`date`] suspending process $pid - temp >= ${bad%00}"
  kill -STOP $pid
  while [ `temp` -gt $ok ]; do sleep 10; done
  echo "[`date`] resuming   process $pid - temp <= ${ok%00}"
  kill -CONT $pid
done
