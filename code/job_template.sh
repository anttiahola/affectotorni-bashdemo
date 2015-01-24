#!/bin/bash

function try_lock {
  LOCK=JOB-$(uname -n)-$1
  lockfile-create --retry 0 --use-pid ${LOCK} 2>/dev/null
}

try_lock 1 || try_lock 2 || exit
lockfile-create --retry 0 $0 2>/dev/null || exit
lockfile-touch $0 &
LPID="$!"

ffmpeg -i IN -b BITRATE -s QUALITY -strict experimental OUT

rm $0
rm IN

kill ${LPID}
lockfile-remove $0

