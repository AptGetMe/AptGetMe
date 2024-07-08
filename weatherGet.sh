#!/bin/bash

# define global colors
_yellow_BOLD_FG="\033[1;38;5;226m"
_orange_BOLD_FG="\033[1;38;5;214m"
_grey_BOLD_FG="\033[1;38;5;248m"
_white_BOLD_FG="\033[1;38;5;255m"

_sky1_BG="\033[48;5;105m"
_sky2_BG="\033[48;5;69m"
_sky3_BG="\033[48;5;33m"
_sky4_BG="\033[48;5;21m"

_colorEnd="\033[m"


function sunny()
{                                                        
  echo -e "$_yellow_BOLD_FG               ++               $_colorEnd"
  echo -e "$_yellow_BOLD_FG       ++     ++++     ++       $_colorEnd"
  echo -e "$_yellow_BOLD_FG       +++++ ++++++ +++++       $_colorEnd"
  echo -e "$_yellow_BOLD_FG        +++++      +++++        $_colorEnd"
  echo -e "$_yellow_BOLD_FG        ++$_orange_BOLD_FG  ;;;;;;;;$_yellow_BOLD_FG  ++        $_colorEnd"
  echo -e "$_yellow_BOLD_FG  +++++++$_orange_BOLD_FG ;;;;;;;;;;;;$_yellow_BOLD_FG +++++++  $_colorEnd"
  echo -e "$_yellow_BOLD_FG    ++++$_orange_BOLD_FG ;;;;;;;;;;;;;;$_yellow_BOLD_FG ++++    $_colorEnd"
  echo -e "$_yellow_BOLD_FG      ++$_orange_BOLD_FG ;;;;;;;;;;;;;;$_yellow_BOLD_FG ++      $_colorEnd"
  echo -e "$_yellow_BOLD_FG    ++++$_orange_BOLD_FG ;;;;;;;;;;;;;;$_yellow_BOLD_FG ++++    $_colorEnd"
  echo -e "$_yellow_BOLD_FG  +++++++$_orange_BOLD_FG ;;;;;;;;;;;;$_yellow_BOLD_FG +++++++  $_colorEnd"
  echo -e "$_yellow_BOLD_FG        ++$_orange_BOLD_FG  ;;;;;;;;$_yellow_BOLD_FG  ++        $_colorEnd"
  echo -e "$_yellow_BOLD_FG        +++++      +++++        $_colorEnd"
  echo -e "$_yellow_BOLD_FG       +++++ ++++++ +++++       $_colorEnd"
  echo -e "$_yellow_BOLD_FG       ++     ++++     ++       $_colorEnd"
  echo -e "$_yellow_BOLD_FG               ++               $_colorEnd"
}
function partly_sunny
{                            
  echo -e "$_yellow_BOLD_FG               ++               $_colorEnd"
  echo -e "$_yellow_BOLD_FG       ++     ++++     ++       $_colorEnd"
  echo -e "$_yellow_BOLD_FG       +++++ ++++++ +++++       $_colorEnd"
  echo -e "$_yellow_BOLD_FG        +++++      ++++++       $_colorEnd"
  echo -e "$_yellow_BOLD_FG        ++$_orange_BOLD_FG  ;;;;;;;;;$_yellow_BOLD_FG ++        $_colorEnd"
  echo -e "$_yellow_BOLD_FG  +++++++$_orange_BOLD_FG ;;;;;;;;;;;;$_yellow_BOLD_FG +++++++  $_colorEnd"
  echo -e "$_yellow_BOLD_FG    ++++$_orange_BOLD_FG ;;;;;;;;;;;;;;$_yellow_BOLD_FG ++++    $_colorEnd"
  echo -e "$_yellow_BOLD_FG      ++$_orange_BOLD_FG ;;;;;;;;;;;;;;$_yellow_BOLD_FG ++      $_colorEnd"
  echo -e "$_yellow_BOLD_FG    ++++$_orange_BOLD_FG ;;;;;;;;;;;;;;$_yellow_BOLD_FG ++++    $_colorEnd"
  echo -e "$_yellow_BOLD_FG  +++++++$_orange_BOLD_FG ;;;;;;;;;;;;$_yellow_BOLD_FG +++++++  $_colorEnd"
  echo -e "$_grey_BOLD_FG     ++$_white_BOLD_FG....$_grey_BOLD_FG++$_orange_BOLD_FG;;;;;;;$_yellow_BOLD_FG  ++        $_colorEnd"
  echo -e "$_grey_BOLD_FG   ++$_white_BOLD_FG........$_grey_BOLD_FG+;++$_yellow_BOLD_FG+ ++++++       $_colorEnd"
  echo -e "$_grey_BOLD_FG +++;$_white_BOLD_FG............$_grey_BOLD_FG++$_yellow_BOLD_FG +++++       $_colorEnd"
  echo -e "$_grey_BOLD_FG +$_white_BOLD_FG...............$_grey_BOLD_FG:+$_yellow_BOLD_FG    ++       $_colorEnd"
  echo -e "$_grey_BOLD_FG +;$_white_BOLD_FG.............$_grey_BOLD_FG:+              $_colorEnd"
  echo -e "$_grey_BOLD_FG   +++++++++++++                $_colorEnd"
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

# turn cursor shape to steady underline
echo -ne "\e[4 q"

# while waiting for inxi cmd to exit, play ASCII animation
while ps -p $_inxiPID >/dev/null;
do
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
    sleep 0.1
    echo -en "/\b"
    sleep 0.1
    echo -en "-\b"
    sleep 0.1
    echo -n "*"
done
echo -e "\nFinished"

# restore cursor shape back to default
echo -ne "\e[0 q"

# read and output inxi weather results from tmpFile
_inxiResults=$(<"$_tmpFile")
echo "$_inxiResults"                              

# test out ASCII art for weather results
sunny
partly_sunny