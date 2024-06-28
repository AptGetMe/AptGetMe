#!/bin/bash

# get current date with "date" cmd and store as array
_fullDate=($(date))

# extract date info
_weekDay=${_fullDate[0]}
_month=${_fullDate[1]}
_day=${_fullDate[2]}
_year=${_fullDate[6]}

# convert to long week day
case $_weekDay in
  "Mon")
    _weekDay="Monday"
    ;;
  "Tue")
    _weekDay="Tuesday"
    ;;
  "Wed")
    _weekDay="Wednesday"
    ;;
  "Thu")
    _weekDay="Thursday"
    ;;
  "Fri")
    _weekDay="Friday"
    ;;
  "Sat")
    _weekDay="Saturday"
    ;;
  "Sun")
    _weekDay="Sunday"
    ;;
  *)
    ;;
esac

# print date
echo -n "Here's todays weather report "
echo "$_weekDay $_month $_day, $_year:"

# create tmp file and setup clean up on exit
_tmpFile=$(mktemp)
trap "rm -f $_tmpFile" EXIT

# start "inxi" cmd in background to get weather
# and redirect output to tmp file
inxi -xxxw &>$_tmpFile &

# save PID and setup kill signal handling
_inxiPID=$!
trap "kill $_inxiPID" SIGINT
echo "Starting inxi weather process $_inxiPID"

wait $_inxiPID

# read and output inxi weather results from tmpFile
_inxiResults=$(<$_tmpFile)
echo "$_inxiResults"