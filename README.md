# ODROID-STAMPER

**ODROID-STAMPER** is a tool to build a minimal Ubuntu image to run on Hardkernel's ODROID SBCs.

## Supported boards:
 - ODROID-N2
 - ODROID-XU4
 - ODROID-C2
 - ODROID-C4
 - ODROID-GO2
 ## Supported Ubuntu Distro version
 - Ubuntu Bionic Beaver (18.04)
 - Ubuntu Disco Dingo (19.04)
 - Ubuntu Focal Fossa (20.04)

# Installing from a git source tree
> $ sudo apt install git wget dialog pv lynx qemu-user-static dialog rsync squashfs-tools uuid-runtime \
$ git clone https://github.com/tobetter/odroid-stamper.git \
$ cd odroid-stamper \
$ export ODROID_STAMPER_CHECKOUT=$PWD \
$ sudo ./odroid-stamper

# Installing a package on Ubuntu.
> $ sudo add-apt-repository ppa:tobetter/ppa \
$ sudo apt-get update \
$ sudo apt install odroid-stamper \
$ mkdir work \
$ cd work \
$ sudo odroid-stamper
