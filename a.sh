#Linux From Scratch - Version 10.1
#!/bin/bash
ls /usr/share/kbd/keymaps/**/*us*.map.gz
# loadkeys de-latin1

#Verify the boot mode
# ls /sys/firmware/efi/efivars

#Ensure your network interface is listed and enabled, for example with ip-link(8): 
# ip link

#update system clock
# timedatectl set-ntp true
#-----------------------------
#extract portions of script
START=sec1
END="secend"
sed -n "/^~$START~$/,/$END/p"
#-----------------------------
#sec1
#Create fstab file at /etc/fstab
cat > /etc/fstab << "EOF"
# Begin /etc/fstab

# file system  mount-point  type     options             dump  fsck
#                                                              order

/dev/<xxx>     /            <fff>    defaults            1     1
/dev/<yyy>     swap         swap     pri=1               0     0
proc           /proc        proc     nosuid,noexec,nodev 0     0
sysfs          /sys         sysfs    nosuid,noexec,nodev 0     0
devpts         /dev/pts     devpts   gid=5,mode=620      0     0
tmpfs          /run         tmpfs    defaults            0     0
devtmpfs       /dev         devtmpfs mode=0755,nosuid    0     0

# End /etc/fstab
EOF
#secend

#sec2
#Minimal package set to define a basic Arch Linux installation
    bash
    bzip2
    coreutils
    file
    filesystem
    findutils
    gawk
    gcc-libs
    gettext
    glibc
    grep
    gzip
    iproute2
    iputils
    licenses
    pacman
    pciutils
    procps-ng
    psmisc
    sed
    shadow
    systemd
    systemd-sysvcompat
    tar
    util-linux
    xz
    linux (optional) - bare metal support
#secend
#sec3
#
# /etc/fstab
# Created by anaconda on Mon Apr 26 22:45:55 2021
#
# Accessible filesystems, by reference, are maintained under '/dev/disk/'.
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info.
#
# After editing this file, run 'systemctl daemon-reload' to update systemd
# units generated from this file.
#
/dev/sda3               /                       btrfs   subvol=root     0 0
UUID=1ce49085-eefd-4851-aba4-74fffa68e1d6 /boot                   ext4    defaults        1 2
UUID=8ABB-8E7B          /boot/efi               vfat    umask=0077,shortname=winnt 0 2
/dev/sda3               /home                   btrfs   subvol=home     0 0
#secend
