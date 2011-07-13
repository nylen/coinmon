#!/bin/sh

export DISPLAY=:0

while true; do
  echo updating adapters list
  aticonfig --lsa > /tmp/bc-adapters.txt.tmp
  mv /tmp/bc-adapters.txt.tmp /tmp/bc-adapters.txt

  echo updating adapter 0 miner log
  screen -x bitcoin -p miner0 -X hardcopy /tmp/bc-miner0-raw.txt
  sed ':a; /^\n*$/{$d;N;ba;}' /tmp/bc-miner0-raw.txt \
    | tail -n 10 > /tmp/bc-miner0.txt.tmp
  mv /tmp/bc-miner0.txt.tmp /tmp/bc-miner0.txt

  echo updating adapter 1 miner log
  screen -x bitcoin -p miner1 -X hardcopy /tmp/bc-miner1-raw.txt
  sed ':a; /^\n*$/{$d;N;ba;}' /tmp/bc-miner1-raw.txt \
    | tail -n 10 > /tmp/bc-miner1.txt.tmp
  mv /tmp/bc-miner1.txt.tmp /tmp/bc-miner1.txt

  echo updating adapter 0 watchdog log
  screen -x bitcoin -p watchdog0 -X hardcopy /tmp/bc-watchdog0-raw.txt
  sed ':a; /^\n*$/{$d;N;ba;}' /tmp/bc-watchdog0-raw.txt \
    | tail -n 10 > /tmp/bc-watchdog0.txt.tmp
  mv /tmp/bc-watchdog0.txt.tmp /tmp/bc-watchdog0.txt

  echo updating adapter 1 watchdog log
  screen -x bitcoin -p watchdog1 -X hardcopy /tmp/bc-watchdog1-raw.txt
  sed ':a; /^\n*$/{$d;N;ba;}' /tmp/bc-watchdog1-raw.txt \
    | tail -n 10 > /tmp/bc-watchdog1.txt.tmp
  mv /tmp/bc-watchdog1.txt.tmp /tmp/bc-watchdog1.txt

  echo updating adapter 0 temperature
  aticonfig --odgt --adapter=0 > /tmp/bc-temp0.txt.tmp
  mv /tmp/bc-temp0.txt.tmp /tmp/bc-temp0.txt

  echo updating adapter 1 temperature
  aticonfig --odgt --adapter=1 > /tmp/bc-temp1.txt.tmp
  mv /tmp/bc-temp1.txt.tmp /tmp/bc-temp1.txt

  echo updating adapter 0 clock
  aticonfig --odgc --adapter=0 > /tmp/bc-clock0.txt.tmp
  mv /tmp/bc-clock0.txt.tmp /tmp/bc-clock0.txt

  echo updating adapter 1 clock
  aticonfig --odgc --adapter=1 > /tmp/bc-clock1.txt.tmp
  mv /tmp/bc-clock1.txt.tmp /tmp/bc-clock1.txt

  echo updating adapter 0 fan
  DISPLAY=:0.0 aticonfig --pplib-cmd 'get fanspeed 0' > /tmp/bc-fan0.txt.tmp
  mv /tmp/bc-fan0.txt.tmp /tmp/bc-fan0.txt

  echo updating adapter 1 fan
  DISPLAY=:0.1 aticonfig --pplib-cmd 'get fanspeed 0' > /tmp/bc-fan1.txt.tmp
  mv /tmp/bc-fan1.txt.tmp /tmp/bc-fan1.txt

  echo updating processes
  top -b -n 1 | head -n 30 > /tmp/bc-processes.txt.tmp
  mv /tmp/bc-processes.txt.tmp /tmp/bc-processes.txt

  echo sleeping for 10 seconds
  sleep 10
done

