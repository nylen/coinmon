#!/bin/sh

aticonfig --od-setclocks=950,1050 --adapter=1
DISPLAY=:0.0 aticonfig --pplib-cmd 'set fanspeed 0 100'
DISPLAY=:0.1 aticonfig --pplib-cmd 'set fanspeed 0 100'
