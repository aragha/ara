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
START=sec1s
END="secend"
sed -n "/^~$START~$/,/$END/p"
#-----------------------------
#sec1s
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
