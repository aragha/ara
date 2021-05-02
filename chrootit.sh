#make a dir named /mnt/work
sudo mkdir /mnt/work

#find and mount the root partition on /mnt/work
sudo mount /dev/sda3	/mnt/work
#find and mount the boot partition on /mnt/work/boot
sudo mkdir /mnt/work/boot
sudo mount /dev/sda2	/mnt/work/boot
#find and mount the EFI system partition on /mnt/work/boot/efi
sudo mkdir /mnt/work/boot/efi
sudo mount /dev/sda1	/mnt/work/boot/efi
#mount all required virtual file systems
for dir in /dev /proc /sys; do sudo mkdir /mnt/work$dir; done
for dir in /dev /proc /sys; do sudo mount --bind $dir /mnt/work$dir; done
#chroot into /mnt/work
sudo chroot /mnt/work
