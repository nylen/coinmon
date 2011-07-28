#!/bin/bash

(

while ! pgrep -fl '/usr/bin/X vt'; do
  sleep 2
done

sleep 5

cd /home/nioctib/coinmon

other/set-oc.sh
./start-miners.sh

) 2>&1 | tee /home/nioctib/coinmon/start.log
