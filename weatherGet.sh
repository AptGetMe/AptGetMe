#!/bin/bash

# get current date with "data" cmd and store as array
_fullDate=($(date))

# extract date info
_weekDay=${_fullDate[0]}
_month=${_fullDate[1]}
_day=${_fullDate[2]}
_time=${_fullDate[3]}
_ampm=${_fullDate[4]}
_zone=${_fullDate[5]}
_year=${_fullDate[6]}

# print date
echo -n "Here's the weather report for today "
echo $_month $_day, $_year

# get weather using "inxi" cmd
inxi -xxxw