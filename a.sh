#Linux From Scratch - Version 10.1
#!/bin/bash
# Simple script to list version numbers of critical development tools
export LC_ALL=C
bash --version | head -n1 | cut -d" " -f2-4
MYSH=$(readlink -f /bin/sh)
echo "/bin/sh -> $MYSH"
echo $MYSH | grep -q bash || echo "ERROR: /bin/sh does not point to bash"
unset MYSH

ls /usr/share/kbd/keymaps/**/*us*.map.gz
# loadkeys de-latin1

#Verify the boot mode
# ls /sys/firmware/efi/efivars

#Ensure your network interface is listed and enabled, for example with ip-link(8): 
# ip link

#update system clock
# timedatectl set-ntp true


