# RetroArch
my digital things and content in support of retrogaming / [retrocomputing](https://robert.hurst-ri.us/rob/retrocomputing) from 1976

Individual digital content available out of my [Drive folder](https://drive.google.com/drive/folders/1DspvB89066kRyLET83xgrOT3VGT6IpBz?usp=drive_link), which also holds a 256gb boot image into a Debian Bullseye console or desktop with a full RetroArch library set running on a Raspberry Pi 4/400.

```bash
$ lsblk -S  # find your target device NAME (SD card, USB stick)
$ xzcat RA-playlists-pi4.img.xz | sudo dd of=/dev/[SD card] bs=131072 status=progress
```
