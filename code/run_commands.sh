#!/bin/bash

ROOT=/home/aholaant/torni/code

function run_cmds {
  for file in $(ls -tr1 ${ROOT}/work/*.sh 2>/dev/null); do
    echo "Runnig: ${file}"
    nohup ${file} >/dev/null 2>&1 &
  done
}

while [[ true ]]; do
  run_cmds
  sleep 1
done
