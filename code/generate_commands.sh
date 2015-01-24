#!/bin/bash

ROOT=/home/aholaant/torni/code
EXTS=(mp4 avi)
EXTS_OUT=(_hi.mp4 _lo.mp4)
BITRATES=(500k 300k)
QUALITIES=(640x320 320x180)


function gen_cmds {
  local infile=${1##*/}
  echo "Found ${infile}"

  for i in {0..1}; do
    local workfile=${ROOT}/work/${i}-${infile}
    local jobfile=${ROOT}/work/job-${RANDOM}.sh
    local outfile=${ROOT}/out/${infile%.*}${EXTS_OUT[i]}
    ln $1 ${workfile}
    sed -e "s?IN?${workfile}?g"\
      -e "s?OUT?${outfile}?g"\
      -e "s/BITRATE/${BITRATES[i]}/g"\
      -e "s/QUALITY/${QUALITIES[i]}/g" ${ROOT}/job_template.sh > ${jobfile}
    chmod u+x ${jobfile}
  done
  rm $1
}

function find_files {
  for ext in ${EXTS[@]}; do
    for file in $(find "${ROOT}/in/" -type f -iname "*.${ext}"); do
      gen_cmds ${file}
    done
  done
}

while [[ true ]]; do
  find_files
  sleep 1
done
