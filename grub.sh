sudo dnf --releasever=33 --installroot=/mnt --assumeyes install grub2-efi shim
sudo dnf --releasever=33 --installroot=/mnt --assumeyes groupinstall grub2-efi shim
sudo dnf install grub2-efi shim
#make sure that /boot/efi is mounted when above command is run
grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
