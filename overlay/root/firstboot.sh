#!/bin/bash

PATH=/sbin:/usr/sbin:/bin:/usr/bin

. /lib/init/vars.sh
. /lib/lsb/init-functions

rootdev=`blkid -U @@UUID_ROOTFS@@`

case ${rootdev} in
	/dev/mmcblk*) dev=${rootdev%??} ;;
	*) dev=${rootdev%?} ;;
esac

lba_start=`fdisk -l ${dev} | grep p2 | awk '{print $2}'`
lba_finish=$((`fdisk -l ${dev} | grep Disk | grep sectors | awk '{printf $7}'` - 2048))

echo -e "p\nd\n2\nn\np\n2\n${lba_start}\n${lba_finish}\np\nw\n" | \
	fdisk ${dev} >/dev/null
partprobe
resize2fs ${rootdev}

rm -f /etc/ssh/ssh_host* && ssh-keygen -A

case $(cat /sys/firmware/devicetree/base/model) in
        "Hardkernel Odroid XU4")
                need_tweak="true"
                ;;
        *)
                need_tweak="false"
                ;;
esac

if [ "x${need_tweak}" = "xtrue" ]; then
	service ssh restart
fi

apt-get --reinstall install libgdk-pixbuf2.0-0
update-mime-database /usr/share/mime

exit 0
