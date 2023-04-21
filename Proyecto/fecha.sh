#!/bin/bash
timedatectl set-local-rtc 1

echo "La fecha de hoy es:"
cat /proc/driver/rtc |grep 'rtc_date' |grep '[0-9]*-[0-9]*-[0-9]*' -o

echo "La hora actual es:"
cat /proc/driver/rtc |grep 'rtc_time' |grep '[0-9]*:[0-9]*:[0-9]*' -o
