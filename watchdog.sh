#!/bin/bash

card=$1
ok="${2}00"
bad="${3}00"

[ "$bad" = 00 ] && echo "Usage: $0 cardnum oktemp badtemp" && exit

echo "[`date`] sleeping for 15 seconds"
sleep 15
pid=`pgrep -f DEVICE=$card`

[ -z "$pid" ] && echo "Process not found" && exit

temp() {
  cat /tmp/bc-temp$card.txt | tail -n 1 | cut -d- -f2 | cut -d' ' -f2 | tr -d .
}

echo "[`date`] starting loop - miner pid=$pid"
kill -CONT $pid

while true; do
  while true; do
    if [ `temp` -ge $bad ]; then
      op=suspend
      break
    fi
    if tail -n 1 /tmp/bc-miner$card.txt | grep -q '^\[0 Khash'; then
      op=kill
      break
    fi
    sleep 10
  done

  case $op in
    suspend)
      echo "[`date`] suspending process $pid - temp >= ${bad%00}"
      kill -STOP $pid
      while [ `temp` -gt $ok ]; do sleep 10; done
      echo "[`date`] resuming   process $pid - temp <= ${ok%00}"
      kill -CONT $pid
      ;;

    kill)
      echo "[`date`] restarting stopped process $pid"
      kill $pid
      sleep 2
      screen -x bitcoin -p miner$card -X stuff 'OA'
      sleep 2
      pid=`pgrep -f DEVICE=$card`
      echo "[`date`] new miner pid=$pid, sleeping for 15 seconds"
      sleep 15
      echo "[`date`] resuming loop"
      ;;
  esac
  op=
done
