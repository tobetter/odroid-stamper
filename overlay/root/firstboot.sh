#!/bin/bash

PATH=/sbin:/usr/sbin:/bin:/usr/bin

. /lib/init/vars.sh
. /lib/lsb/init-functions

rootdev=`blkid -U @@UUID_ROOTFS@@`

case ${rootdev} in
	/dev/mmcblk* | /dev/nvme*)
		dev=${rootdev%??} ;;
	*) dev=${rootdev%?} ;;
esac

lba_start=`fdisk -l ${dev} | grep p2 | awk '{print $2}'`
lba_finish=$((`fdisk -l ${dev} | grep Disk | grep sectors | awk '{printf $7}'` - 2048))

echo -e "p\nd\n2\nn\np\n2\n${lba_start}\n${lba_finish}\np\nw\n" | \
	fdisk ${dev} >/dev/null
partprobe
resize2fs ${rootdev}

rm -f /etc/ssh/ssh_host* && ssh-keygen -A

service ssh restart

exit 0
