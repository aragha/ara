sudo dd if=/dev/sda of=mbr.bin bs=512 count=1
sudo od -xa mbr.bin
