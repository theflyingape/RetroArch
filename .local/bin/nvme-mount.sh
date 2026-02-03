#!/bin/sh

mkdir /run/user/1000/nvme
sudo mount /dev/nvme0n1p2 /run/user/1000/nvme
sudo mount /dev/nvme0n1p1 /run/user/1000/nvme/boot/firmware
sudo mount -o bind /dev /run/user/1000/nvme/dev
sudo mount -o bind /proc /run/user/1000/nvme/proc
sudo mount -o bind /run /run/user/1000/nvme/run
sudo mount -o bind /sys /run/user/1000/nvme/sys
sudo chroot /run/user/1000/nvme
