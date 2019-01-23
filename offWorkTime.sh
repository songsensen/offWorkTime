#!/bin/bash

offWorkTime="19:00:00"
offWorkHour=${offWorkTime:0:2}
offWorkMinute=${offWorkTime:3:2}
offWorkSecond=${offWorkTime:6:2}

totalSecondsOffWork=$((offWorkHour * 3600 + offWorkMinute * 60 + offWorkSecond))

currentTime=`TZ='Asia/Hong_Kong' date +%H:%M:%S`
currentHour=${currentTime:0:2}
currentMinute=${currentTime:3:2}
currentSecond=${currentTime:6:2}

totalSecondsCurrent=$((currentHour * 3600 + currentMinute * 60 + currentSecond))

minusSeconds=$((totalSecondsOffWork - totalSecondsCurrent))

while true
do
  if [[ $minusSeconds -eq 0 ]]
  then
    echo "It's time to quit" | mail -s "offWork" your@mail.com
    exit
  else
    remainder=$((minusSeconds % 3600))
    if [[ $remainder -eq 0 ]]
    then
      remindHour=$((minusSeconds / 3600))
      echo "There also needs $remindHour hour to quit" | mail -s "offWork" your@mail.com
    fi
  fi
  ((minusSeconds--))
  sleep 1s
done
