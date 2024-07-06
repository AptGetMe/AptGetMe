#!/bin/bash

function sunny()
{                                                        
  echo "               ++               "
  echo "       ++     ++++     ++       "
  echo "       +++++ ++++++ +++++       "
  echo "        +++++      +++++        "
  echo "        ++  ;;;;;;;;  ++        "
  echo "  +++++++ ;;;;;;;;;;;; +++++++  "
  echo "    ++++ ;;;;;;;;;;;;;; ++++    "
  echo "      ++ ;;;;;;;;;;;;;; ++      "
  echo "    ++++ ;;;;;;;;;;;;;; ++++    "
  echo "  +++++++ ;;;;;;;;;;;; +++++++  "
  echo "        ++  ;;;;;;;;  ++        "
  echo "        +++++      +++++        "
  echo "       +++++ ++++++ +++++       "
  echo "       ++     ++++     ++       "
  echo "               ++               "
}
function partly_sunny
{                            
  echo "               ++               "
  echo "       ++     ++++     ++       "
  echo "       +++++ ++++++ +++++       "
  echo "        +++++      ++++++       "
  echo "        ++  ;;;;;;;;; ++        "
  echo "  +++++++ ;;;;;;;;;;;; +++++++  "
  echo "    ++++ ;;;;;;;;;;;;;; ++++    "
  echo "      ++ ;;;;;;;;;;;;;; ++      "
  echo "    ++++ ;;;;;;;;;;;;;; ++++    "
  echo "  +++++++ ;;;;;;;;;;;; +++++++  "
  echo "     ++....++;;;;;;;  ++        "
  echo "   ++........+;+++ ++++++       "
  echo " +++;............++ +++++       "
  echo " +...............:+    ++       "
  echo " +;.............:+              "
  echo "   +++++++++++++                "
}

# get current date with "date" cmd and store as array
read -ra _fullDate < <(date)

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

#convert to long month
case $_month in
  "Jan")
    _month="January"
    ;;
  "Feb")
    _month="February"
    ;;
  "Mar")
    _month="March"
    ;;
  "Apr")
    _month="April"
    ;;
  "Jun")
    _month="June"
    ;;
  "Jul")
    _month="July"
    ;;
  "Aug")
    _month="August"
    ;;
  "Sep")
    _month="September"
    ;;
  "Oct")
    _month="October"
    ;;
  "Nov")
    _month="November"
    ;;
  "Dec")
    _month="December"
    ;;
  *)
    ;;
esac

# print date
echo "Here's todays weather report $_weekDay $_month $_day, $_year:"

# create tmp file and setup clean up on exit
_tmpFile=$(mktemp)
trap 'rm -f $_tmpFile' EXIT

# start "inxi" cmd in background to get weather
# pipe output to tee command to write to tmp file
# remove stdout 
inxi -xxxw --force colors | tee "$_tmpFile" >/dev/null &

# save PID and setup kill signal handling
_inxiPID=$!
trap 'kill $_inxiPID' SIGINT
echo "Starting inxi weather process $_inxiPID"

# while waiting for inxi cmd to exit, play ascii animation
while ps -p $_inxiPID >/dev/null;
do
    sleep 0.1
    echo -en "|\b"
    sleep 0.1
    echo -en "/\b"
    sleep 0.1
    echo -en "-\b"
    sleep 0.1
    echo -en "\\\\\b"
    sleep 0.1
    echo -en "|\b"
    sleep 0.1
    echo -en "/\b"
    sleep 0.1
    echo -en "-\b"
    sleep 0.1
    echo -en "\\\\\b"
    sleep 0.1
    echo -en "|\b"
    echo -n "*"
done
echo -e "\nFinished"

# read and output inxi weather results from tmpFile
_inxiResults=$(<"$_tmpFile")
echo "$_inxiResults"                              

# test out ascii art for weather results
sunny
partly_sunny