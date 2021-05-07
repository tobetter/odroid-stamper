#!/bin/bash

STAMP=/overlay/vendor/.stamp_sshkey

PATH=/sbin:/usr/sbin:/bin:/usr/bin

. /lib/init/vars.sh
. /lib/lsb/init-functions

if [ ! -f $STAMP ]; then
	ssh-keygen -A

	/usr/sbin/overlay-backup vendor

	mount -o remount,rw /overlay/vendor
	touch $STAMP
	mount -o remount,ro /overlay/vendor
fi

exit 0
