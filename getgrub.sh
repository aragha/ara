mkdir grubfolder
cd grubfolder
wget https://www.gnu.org/software/grub/manual/grub/grub.txt
#wget https://ftp.gnu.org/gnu/grub/grub-2.04.tar.gz
#tar -xvf grub-2.04.tar.gz
ls
pwd
sudo dnf --releasever=33 --installroot=/mnt --assumeyes install grub2 efibootmgr shim grub2-efi grub2-efi-modules grub2-tools-extra grub2-tools-efi grub2-pc-modules grub2-pc
sudo dnf reinstall grub2-efi grub2-pc grub2-pc-modules grub2-tools-efi grub2-tools-extra shim
efibootmgr --create --disk /dev/sda  --loader /EFI/fedora/grubx64.efi --label "Fedora Grub"
sudo grub2-install --efi-directory=/mnt/boot/efi --target=x86_64-efi /dev/sda1
