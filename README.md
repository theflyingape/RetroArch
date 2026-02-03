# ⛔ 🪙 → 🖱️ ⌨️ 🎮 → RetroArch → 🕹️ 🛸 👾 📺

> _My harvesting and personal contributions of digital content in support of retrogaming / [retrocomputing](https://robert.hurst-ri.us/rob/retrocomputing) from **1976**_

Digital content is accessible out of my ☁️ Drive [📚 Bookshelf](https://drive.google.com/drive/folders/1IzpFmpW07yRvnkVU7aJVFchlY1OpmDS2?usp=drive_link) and [💿💾 Retro](https://drive.google.com/drive/folders/1DspvB89066kRyLET83xgrOT3VGT6IpBz?usp=drive_link) folders.

## Boot image

Since November 2021, select digital content pulled off of my Drive folder to make this into a plug & play **RetroArch** configuration that loads from a Debian 13 [Trixie boot image](https://www.raspberrypi.com/software/operating-systems/#raspberry-pi-os-64-bit) for a user & developer friendly 🍓 Raspberry Pi 4/400 or Pi 5/500/500+ desktop (or console).

In addition to my custom themes alongside the command-line Playlists frontend to launch an exhaustive list of content out of RetroArch, a more targeted, comprehensive list of top games using **Emulation Station** is efficiently integrated for its multiple gaming console themes and modern kiosk look & feel experiences.

```bash
$ lsblk -S  # find your target device NAME (NVME drive, SD card, USB stick)
$ xzcat RA-playlists-rpi-trixie.img.xz | sudo dd of=/dev/[NAME] bs=4k status=progress
$ sync
```

Its first boot may take a little longer – _be patient_. Once that has settled, configure your **network**, **sound**, and connect any **bluetooth** devices using the system panel controls.

Both desktop and console auto login as user `pi` with password `Freedom`

### Technical Layout

This RetroArch configuration is designed to be ‘plug & play’. And while it allows for some flexibility to make some runtime modifications, it returns back to its original state after reboot. This is intentional, not to annoy you, but to protect from changes that lead to incidental havoc to gameplay.

That said, feel free to drop to a terminal shell prompt by using `left Alt` then `2` off the console menu to check out the differences between a default and its startup template configuration:
```
$ ll *.cfg
$ diff default.cfg template.cfg | less
$ micro template.cfg
```
Thus, `template.cfg` gets copied over to `retroarch.cfg` → which points to the pi temporary runtime memory space. It is the “base” configuration that gets loaded first. Subsequently, the other configuration files listed – _aptly named to follow the console playlist menu_ – are “appended” in the order received to override base values.

There is a convenience script that can fetch and build RetroArch and some key emulation cores:

```bash
$ make-retroarch.sh
```

### Cores

This table represents the emulation cores installed and referenced within the various playlists. It is useful to know the name of the core for **Netplay** connections to another host – as both the core and the content should be (_optimally_) identical:

1) **Arcade** :: `1976 - 2004`
   - FinalBurn Neo
   - MAME
   - MAME 2003-Plus
2) **Computers** :: `1977 - 1999`
   - Caprice32 - **Amstrad CPC**
   - MAME 
     - **Apple II / IIgs / Macintosh**
     - **Tandy Color Computer**
     - **Texas Instruments 99/4A**
     - **TRS-80 Model I**
   - Atari800 - **Atari 800**
   - **Commodore**
     - PUAE - **Amiga**
     - VICE x64sc - **64**
     - VICE x128 - **128**
     - VICE xpet - **PET**
     - VICE xplus4 - **16 / Plus4**
     - VICE xvic - **VIC 20**
   - DOSBox-Pure - **PC DOS / Win98**
   - px68k - **Sharp X68000**
3) **Consoles** :: `1977 - 2013`
   - **Atari**
     - Stella - **2600**
     - ProSystem - **7800**
   - blueMSX - **ColecoVision**
   - FreeIntv - **Mattel Intellivision**
   - Beetle PCE FAST - **NEC PC Engine / CD**
   - NeoCD - **Neo Geo CD**
   - **Nintendo**
     - Citra - **3DS**
     - Dolphin - **GameCube**
     - Mesen - **NES / Famicom**
     - Mupen64Plus-Next - **N64**
     - Snes9x or bsnes-jg - **SNES / SFC**
   - **Sega**
     - Flycast - **Dreamcast / Naomi**
     - Genesis Plus GX - **MS/GG/MD/CD**
     - PicoDrive - **32X**
     - Yabause - **Saturn**
   - **Sony**
     - PCSX ReARMed - **PlayStation**
     - LRPS2 - **PlayStation 2**
   - vecx - **Vectrex**
4) **Handhelds** :: `1989 - 2014`
   - Beetle Handy - **Atari Lynx**
   - Beetle NeoPop - **Neo Geo Pocket / Color**
   - **Nintendo**
     - gpSP - **Game Boy Advance**
     - Gambatte - **Game Boy / Color**
     - PokeMini - **Pokemon Mini**
     - Beetle VB - **Virtual Boy**
   - PPSSPP - **Sony PlayStation Portable**

### Overclocking

These are relatively safe values to bump the CPU + GPU clock up in `/boot/firmware/config.txt`

```ini
[pi4]
# enables highest gpu settings at the expense of dual displays
hdmi_enable_4kp60=1
# overclock +10%
over_voltage=4
arm_freq=1980
gpu_freq=550
```

```ini
[pi5]
dtparam=nvme
dtparam=pciex1_gen=3
kernel=kernel8.img
# overclock +15%
over_voltage=3
arm_freq=2760
gpu_freq=920
```

If using an NVME drive on Pi 5, enable it to boot:

```bash
$ sudo rpi-eeprom-config --edit
```

```ini
[all]
BOOT_UART=0
POWER_OFF_ON_HALT=1
BOOT_ORDER=0xf461
PCIE_PROBE=1
WAKE_ON_GPIO=0
```
