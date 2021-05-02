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
sudo mkfs.vfat -F 32 /dev/sda1    #formatitefi
sudo mkswap          /dev/sda2    #formatitefi
sudo mkfs.ext4       /dev/sda3    #formatitefi
#mount them
sudo mkdir /mnt/boot               #mountitefi
sudo mkdir /mnt/boot/efi           #mountitefi
sudo mount /dev/sda1 /mnt/boot/efi #mountitefi
sudo swapon /dev/sda2              #mountitefi
sudo mount  /dev/sda3 /mnt         #mountitefi

#Mount critical virtual filesystems:
for i in /dev/pts /run; do sudo mount -B $i /mnt$i; done #mountitchroot
sudo mount -t sysfs sysfs /mnt/sys #mountitchroot
sudo mount -t efivarfs efivarfs /mnt/sys/firmware/efi/efivars #mountitchroot
#sudo mount -t efivarfs efivarfs /sys/firmware/efi/efivars #mountitchroot - after chroot and before grub
mount -t proc /proc proc/  #mountitchroot
mount --rbind /sys sys/ #mountitchroot
mount --rbind /dev dev/ #mountitchroot
#refresh mounts #mountitchroot
systemctl daemon-reload #mountitchroot
sudo mount -t proc proc /proc #mountitchroot - after chroot and before grub
sudo mount -t devfs devfs /dev #mountitchroot - after chroot adn before grub



/dev/<xxx>     /            <fff>    defaults            1     1
/dev/<yyy>     swap         swap     pri=1               0     0
proc           /proc        proc     nosuid,noexec,nodev 0     0
sysfs          /sys         sysfs    nosuid,noexec,nodev 0     0
devpts         /dev/pts     devpts   gid=5,mode=620      0     0
tmpfs          /run         tmpfs    defaults            0     0
devtmpfs       /dev         devtmpfs mode=0755,nosuid    0     0
#/etc/fstab
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
sudo mount -o bind /dev /mnt/dev #mountitchroot
sudo chroot /mnt /bin/bash #mountitchroot
#secend
sudo dd if=/dev/sda of=mbr.bin bs=512 count=1
sudo od -xa mbr.bin
sudo dnf --releasever=33 --installroot=/mnt --assumeyes groupinstall core #installit
sudo dnf --releasever=33 --installroot=/mnt --assumeyes install kernel #installit
sudo cp /etc/resolv.conf /mnt/etc #network #networkit

/dev/sda1      /boot/efi    vfat     umask=0077,shortname=winnt 0  2	#fstabit
/dev/sda2      swap         swap     pri=1               0     0	#fstabit
/dev/sda3      /home        ext4     subvol=home         0     0	#fstabit
/dev/sda3      /            ext4     subvol=root         0     0	#fstabit
proc           /proc        proc     nosuid,noexec,nodev 0     0	#fstabit
sysfs          /sys         sysfs    nosuid,noexec,nodev 0     0	#fstabit
devpts         /dev/pts     devpts   gid=5,mode=620      0     0	#fstabit
tmpfs          /run         tmpfs    defaults            0     0	#fstabit
devtmpfs       /dev         devtmpfs mode=0755,nosuid    0     0	#fstabit
sudo find /mnt -print |  grep -i vmlin #findit
sudo find /mnt -print |  grep -i initramf #findit
sudo find /mnt -print |  grep -i efibootm #findit
dd if=/dev/rdsk/device-name of=/dev/rdsk/device-name bs=blocksize status=progress #cloneit
fsck /dev/rdsk/device-name #cloneit

root #efibootmgr --create --disk /dev/sda --part 2 --label "Gentoo" --loader "\efi\boot\bootx64.efi" #efibootmgrit
root #efibootmgr -c -d /dev/sda -p 2 -L "Gentoo" -l "\efi\boot\bootx64.efi" initrd='\initramfs-genkernel-amd64-4.9.16-gentoo' #efibootmgrit
sudo dnf  --installroot=/mnt --assumeyes install man-db man-pages texinfo vim bash wget git sudo dosfstools efibootmgr libisoburn os-prober mtools coreutils e2fsprogs util-linux sysstat lvm2 iputils connman NetworkManager systemd procps #installit

sudo cp /etc/resolv.conf /mnt/etc	#configit
sudo cp /etc/localtime /mnt/etc		#configit
sudo cp /etc/locale.conf /mnt/etc	#configit
sudo cp /etc/vconsole.conf /mnt/etc	#configit
sudo echo "fedhost" > ./hostname	#configit
sudo cp hostname /mnt/etc		#configit
#sudo rm hostname			#configit

mkdir grubfolder #grubit
cd grubfolder #grubit
wget https://www.gnu.org/software/grub/manual/grub/grub.txt #grubit
#wget https://ftp.gnu.org/gnu/grub/grub-2.04.tar.gz #grubit
#tar -xvf grub-2.04.tar.gz #grubit
sudo dnf --releasever=33 --installroot=/mnt --assumeyes install grub2 efibootmgr shim grub2-efi grub2-efi-modules grub2-tools-extra grub2-tools-efi grub2-pc-modules grub2-pc #grubit
sudo dnf --assumeyes reinstall grub2-efi grub2-pc grub2-pc-modules grub2-tools-efi grub2-tools-extra shim grub2-efi-x64-modules #grubit
efibootmgr --create --disk /dev/sda  --loader /EFI/fedora/grubx64.efi --label "Fedora Grub" #grubit
sudo grub2-install --efi-directory=/mnt/boot/efi --target=x86_64-efi /dev/sda1 #grubit
