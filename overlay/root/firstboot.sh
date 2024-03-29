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
lba_finish=$((`fdisk -l ${dev} | grep Disk | grep sectors | awk '{printf $7}'` - 1))

echo -e "p\nd\n2\nn\np\n2\n${lba_start}\n${lba_finish}\np\nw\n" | \
	fdisk ${dev} >/dev/null
partprobe
resize2fs ${rootdev}

rm -f /etc/ssh/ssh_host* && ssh-keygen -A

sed -i "s/^PasswordAuthentication.*/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sed -i "s/^KbdInteractiveAuthentication.*/KbdInteractiveAuthentication yes/g" /etc/ssh/sshd_config

systemctl enable ssh
systemctl restart ssh

exit 0
