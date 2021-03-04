#!/bin/bash

[ -f "${1}" ] || exit 0
. ${1}

do_fdisk_commands() {

	TOTAL=0
	for (( p = 0 ; p < ${#PART[@]} ; p++ )); do
		TOTAL=$((${TOTAL} + ${PART[p]} * 1024 * 1024 / 512))
	done
	EXT_START=$((${TOTAL_SECTORS} - ${TOTAL}))

	CMD="n\ne\n3\n${EXT_START}\n\n"
	for (( p = 0 ; p < ${#PART[@]} - 1 ; p++ )); do
		CMD="${CMD}n\nl\n\n+${PART[p]}M\n"
	done
	CMD="${CMD}n\nl\n\n\nw\n"

	echo ${CMD}
}

cmd=$(do_fdisk_commands ${1})
echo ${cmd}
