#!/bin/bash

# customize these
WGET=/usr/bin/wget
ICS2ORG="$HOME"/bin/ical2org.awk
ICSFILE="$HOME"/git/org/google-calendar.ics
ORGFILE="$HOME"/git/org/googlecal.org
URL=""

# no customization needed below

$WGET -O $ICSFILE $URL
$ICS2ORG < $ICSFILE > $ORGFILE
