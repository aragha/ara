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
#extract lines 24 to 82 from a file, and quit at line 83
sed -n '24,82p;83q' filename > newfile
#-----------------------------
#sec1
#Create fstab file at /etc/fstab
cat > /etc/fstab << "EOF"
# Begin /etc/fstab
# file system  mount-point  type     options             dump  fsck
#                                                              order
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
#sec4
TARGET                        SOURCE           FSTYPE          OPTIONS
/                             /dev/sda3[/root] btrfs           rw,relatime,seclabel,space_cache,subvolid=258,subvol=/root
├─/sys                        sysfs            sysfs           rw,nosuid,nodev,noexec,relatime,seclabel
│ ├─/sys/kernel/security      securityfs       securityfs      rw,nosuid,nodev,noexec,relatime
│ ├─/sys/fs/cgroup            cgroup2          cgroup2         rw,nosuid,nodev,noexec,relatime,seclabel,nsdelegate
│ ├─/sys/fs/pstore            pstore           pstore          rw,nosuid,nodev,noexec,relatime,seclabel
│ ├─/sys/firmware/efi/efivars efivarfs         efivarfs        rw,nosuid,nodev,noexec,relatime
│ ├─/sys/fs/bpf               none             bpf             rw,nosuid,nodev,noexec,relatime,mode=700
│ ├─/sys/kernel/tracing       none             tracefs         rw,relatime,seclabel
│ ├─/sys/fs/selinux           selinuxfs        selinuxfs       rw,nosuid,noexec,relatime
│ ├─/sys/kernel/debug         debugfs          debugfs         rw,nosuid,nodev,noexec,relatime,seclabel
│ ├─/sys/fs/fuse/connections  fusectl          fusectl         rw,nosuid,nodev,noexec,relatime
│ └─/sys/kernel/config        configfs         configfs        rw,nosuid,nodev,noexec,relatime
├─/proc                       proc             proc            rw,nosuid,nodev,noexec,relatime
│ └─/proc/sys/fs/binfmt_misc  systemd-1        autofs          rw,relatime,fd=30,pgrp=1,timeout=0,minproto=5,maxproto=5,direct,pipe_ino=16134
├─/dev                        devtmpfs         devtmpfs        rw,nosuid,noexec,seclabel,size=1665832k,nr_inodes=416458,mode=755
│ ├─/dev/shm                  tmpfs            tmpfs           rw,nosuid,nodev,seclabel
│ ├─/dev/pts                  devpts           devpts          rw,nosuid,noexec,relatime,seclabel,gid=5,mode=620,ptmxmode=000
│ ├─/dev/mqueue               mqueue           mqueue          rw,nosuid,nodev,noexec,relatime,seclabel
│ └─/dev/hugepages            hugetlbfs        hugetlbfs       rw,relatime,seclabel,pagesize=2M
├─/run                        tmpfs            tmpfs           rw,nosuid,nodev,seclabel,size=674640k,nr_inodes=819200,mode=755
│ └─/run/user/1000            tmpfs            tmpfs           rw,nosuid,nodev,relatime,seclabel,size=337316k,nr_inodes=84329,mode=700,uid=1000,gid=1000
│   └─/run/user/1000/gvfs     gvfsd-fuse       fuse.gvfsd-fuse rw,nosuid,nodev,relatime,user_id=1000,group_id=1000
├─/tmp                        tmpfs            tmpfs           rw,nosuid,nodev,seclabel,size=1686600k,nr_inodes=409600
├─/boot                       /dev/sda2        ext4            rw,relatime,seclabel
│ └─/boot/efi                 /dev/sda1        vfat            rw,relatime,fmask=0077,dmask=0077,codepage=437,iocharset=ascii,shortname=winnt,errors=remount-ro
├─/home                       /dev/sda3[/home] btrfs           rw,relatime,seclabel,space_cache,subvolid=256,subvol=/home
└─/var/lib/nfs/rpc_pipefs     sunrpc           rpc_pipefs      rw,relatime
generated using the command "#findmnt >> mounttree"
#secend
#sec5
#Fedora from scratch
sudo mkdir /mnt/local
sudo mount /dev/sda3 /mnt/local
sudo mkdir /mnt/local/boot
sudo mount /dev/sda1 /mnt/local/boot
sudo dnf --releasever=33 --installroot=/mnt/local groupinstall core
sudo cp /etc/resolv.conf /mnt/local/etc/
sudo mount -t sysfs none /mnt/local/sys
sudo mount -t proc none /mnt/local/proc
sudo mount -t efivarfs none /mnt/local/sys/firmware/efi/efivars
sudo mount -o bind /dev /mnt/local/dev
sudo chroot /mnt/local /bin/bash
#set up networking in the chrooted session
sudo cp /etc/resolv.conf /mnt/local/etc/resolv.conf
#secend
sudo dd if=/dev/sda of=mbr.bin bs=512 count=1
sudo od -xa mbr.bin
