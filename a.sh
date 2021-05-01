#Linux From Scratch - Version 10.1#!/bin/bash
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
#extract lines 24 to 82 from a file, and quit at line 83
sed -n '24,82p;83q' filename > newfile
#-----------------------------
#sec1
#Create fstab file at /etc/fstab
cat > /etc/fstab << "EOF"
# Begin /etc/fstab
# file system  mount-point  type     options             dump  fsck
#                                                              order
#delete partitions
echo "d
1
d
2
d
wq" | fdisk /dev/sda

#create my partitions
echo "n
p
1
+550M
n
p
2
 
+4G
n
p
3
 
 
w" | fdisk /dev/sda
#partition them
mkfs.vfat -F 32 /dev/sda1
mkswap          /dev/sda2
mkfs.ext4       /dev/sda3
#mount them
sudo mount  /dev/sda3 /mnt
sudo swapon /dev/sda2
sudo mkdir /mnt/boot
sudo mkdir /mnt/boot/efi
sudo mkdir /mnt/boot/efi
sudo mount /dev/sda1 /mnt/boot/efi

#Mount critical virtual filesystems:
 for i in /dev /dev/pts /proc /sys /run; do sudo mount -B $i /mnt$i; done
sudo mount -t sysfs none /mnt/sys
sudo mount -t efivarfs none /mnt/sys/firmware/efi/efivars

lsblk
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
#sec4
#generated using the command "#findmnt >> mounttree"
#secend
#sec5
#Fedora from scratch
sudo dnf --releasever=33 --installroot=/mnt/local groupinstall core
sudo cp /etc/resolv.conf /mnt/etc/
sudo mount -t sysfs none /mnt/sys
sudo mount -t proc none /mnt/proc
sudo mount -t efivarfs none /mnt/sys/firmware/efi/efivars
sudo mount -o bind /dev /mnt/dev
sudo chroot /mnt/local /bin/bash
#secend
sudo dd if=/dev/sda of=mbr.bin bs=512 count=1
sudo od -xa mbr.bin
sudo dnf --releasever=33 --installroot=/mnt --assumeyes groupinstall core
sudo dnf --releasever=33 --installroot=/mnt --assumeyes install kernel
sudo cp /etc/resolv.conf /mnt/etc #network

