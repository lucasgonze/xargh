#!/bin/bash

DIR=`dirname $0`
F="$DIR/xargh"
STATUS=0

echo "test no arguments gives return status 0"
$F > /dev/null
if [[ $? != 0 ]]; then
  echo fail
  STATUS=1
fi

echo "test no arguments gives short help"
$F | grep -q Usage:
if [[ $? != 0 ]]; then
  echo fail
  STATUS=1
fi

echo "test -h gives long help"
LINES=`$F -h | wc -l | awk '{print $1}'`
if [[ $LINES -lt 50 ]]; then
  #statements
  echo fail
  STATUS=1
fi

echo "test -r with no further arguments gives exit status 1"
$F -r 2>/dev/null
if [[ $? != 1 ]]; then
  echo fail
  STATUS=1
fi

echo "test -r with no further arguments gives help message"
LINES=`$F -r 2>&1 | wc -l | awk '{print $1}'`
if [[ $LINES -lt 1 ]]; then
  echo fail
  STATUS=1
fi

# test -r with a value but no template-command gives exit status 1 and non-empty message in STDERR
# test that a single argument gives exit status 0
# test that `echo "Hello" | xargh "echo -n {} World"` is "Hello World"
# test that missing {} in template-command puts the replacement at end

exit $STATUS
