#!/bin/bash

DIR=`dirname $0`
F="$DIR/xargh"
STATUS=0

echo "check no arguments gives return status 0"
$F > /dev/null
if [[ $? != 0 ]]; then
  echo fail
  STATUS=1
fi

echo "check no arguments gives short help"
$F | grep -q Usage:
if [[ $? != 0 ]]; then
  echo fail
  STATUS=1
fi

echo "check -h gives long help"
LINES=`$F -h | wc -l | awk '{print $1}'`
if [[ $LINES -lt 50 ]]; then
  #statements
  echo fail
  STATUS=1
fi

echo "check -r with no further arguments gives exit status 1"
$F -r 2>/dev/null
if [[ $? != 1 ]]; then
  echo fail
  STATUS=1
fi

echo "check -r with no further arguments gives help message"
LINES=`$F -r 2>&1 | wc -l | awk '{print $1}'`
if [[ $LINES -lt 1 ]]; then
  echo fail
  STATUS=1
fi

echo "check that a single argument gives exit status 0"
echo | $F nop 2>/dev/null
if [[ $? != 0 ]]; then
  echo fail
  STATUS=1
fi


echo 'check "Hello World"'
echo "Hello" | $F "echo -n {} World" | grep '^Hello World$' > /dev/null
if [[ $? != 0 ]]; then
  echo fail
  STATUS=1
fi

echo "check that missing {} in template-command puts the replacement at end"
echo "Hello" | $F "echo -n World" | grep '^World Hello$' > /dev/null
if [[ $? != 0 ]]; then
  echo fail
  STATUS=1
fi


exit $STATUS
