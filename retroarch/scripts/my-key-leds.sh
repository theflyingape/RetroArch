#!/bin/sh

ls -l "rpi-keyboard commands.txt"
rpi-keyboard-config info --ascii
sudo rpi-keyboard-fw-update 
rpi-keyboard-config get-version
# rpi-keyboard-config reset-presets
rpi-keyboard-config leds clear
rpi-keyboard-config leds load
# rpi-keyboard-config list-effects
rpi-keyboard-config preset index 1
rpi-keyboard-config preset set 1 direct --hue 120 --sat 128
rpi-keyboard-config info
#
rpi-keyboard-config led set "0,0" --colour "rgb(144,0,0)"
rpi-keyboard-config led set "0,1" --colour "rgb(64,160,160)"
rpi-keyboard-config led set "0,2" --colour "rgb(64,160,160)"
rpi-keyboard-config led set "0,3" --colour "rgb(64,160,160)"
rpi-keyboard-config led set "0,4" --colour "rgb(0,128,144)"
rpi-keyboard-config led set "0,5" --colour "rgb(0,128,144)"
rpi-keyboard-config led set "0,6" --colour "rgb(0,128,144)"
rpi-keyboard-config led set "0,7" --colour "rgb(0,64,160)"
rpi-keyboard-config led set "0,8" --colour "rgb(0,64,160)"
rpi-keyboard-config led set "0,9" --colour "rgb(0,64,160)"
rpi-keyboard-config led set "0,10" --colour "rgb(8,32,160)"
rpi-keyboard-config led set "0,11" --colour "rgb(8,32,160)"
rpi-keyboard-config led set "0,12" --colour "rgb(8,32,160)"
rpi-keyboard-config led set "0,13" --colour "rgb(144,80,0)"
rpi-keyboard-config led set "0,14" --colour "rgb(112,0,0)"
#
rpi-keyboard-config led set "1,0" --colour "rgb(144,128,112)"
rpi-keyboard-config led set "1,1" --colour "rgb(0,80,0)"
rpi-keyboard-config led set "1,2" --colour "rgb(0,80,0)"
rpi-keyboard-config led set "1,3" --colour "rgb(0,80,0)"
rpi-keyboard-config led set "1,4" --colour "rgb(0,80,0)"
rpi-keyboard-config led set "1,5" --colour "rgb(0,80,0)"
rpi-keyboard-config led set "1,6" --colour "rgb(0,80,0)"
rpi-keyboard-config led set "1,7" --colour "rgb(0,80,0)"
rpi-keyboard-config led set "1,8" --colour "rgb(0,80,0)"
rpi-keyboard-config led set "1,9" --colour "rgb(0,80,0)"
rpi-keyboard-config led set "1,10" --colour "rgb(0,80,0)"
rpi-keyboard-config led set "1,11" --colour "rgb(144,128,112)"
rpi-keyboard-config led set "1,12" --colour "rgb(144,128,112)"
rpi-keyboard-config led set "1,14" --colour "rgb(240,240,32)"
rpi-keyboard-config led set "1,15" --colour "rgb(160,160,160)"
#
rpi-keyboard-config led set "2,0" --colour "rgb(144,144,0)"
rpi-keyboard-config led set "2,2" --colour "rgb(160,160,160)"
rpi-keyboard-config led set "2,3" --colour "rgb(160,160,160)"
rpi-keyboard-config led set "2,4" --colour "rgb(160,160,160)"
rpi-keyboard-config led set "2,5" --colour "rgb(160,160,160)"
rpi-keyboard-config led set "2,6" --colour "rgb(160,160,160)"
rpi-keyboard-config led set "2,7" --colour "rgb(160,160,160)"
rpi-keyboard-config led set "2,8" --colour "rgb(160,160,160)"
rpi-keyboard-config led set "2,9" --colour "rgb(160,160,160)"
rpi-keyboard-config led set "2,10" --colour "rgb(160,160,160)"
rpi-keyboard-config led set "2,11" --colour "rgb(160,160,160)"
rpi-keyboard-config led set "2,12" --colour "rgb(144,128,112)"
rpi-keyboard-config led set "2,13" --colour "rgb(144,128,112)"
rpi-keyboard-config led set "2,14" --colour "rgb(144,128,112)"
rpi-keyboard-config led set "2,15" --colour "rgb(160,160,160)"
#
rpi-keyboard-config led set "3,0" --colour "rgb(128,112,96)"
rpi-keyboard-config led set "3,2" --colour "rgb(160,160,160)"
rpi-keyboard-config led set "3,3" --colour "rgb(160,160,160)"
rpi-keyboard-config led set "3,4" --colour "rgb(160,160,160)"
rpi-keyboard-config led set "3,5" --colour "rgb(160,160,160)"
rpi-keyboard-config led set "3,6" --colour "rgb(160,160,160)"
rpi-keyboard-config led set "3,7" --colour "rgb(160,160,160)"
rpi-keyboard-config led set "3,8" --colour "rgb(160,160,160)"
rpi-keyboard-config led set "3,9" --colour "rgb(160,160,160)"
rpi-keyboard-config led set "3,10" --colour "rgb(160,160,160)"
rpi-keyboard-config led set "3,11" --colour "rgb(144,128,112)"
rpi-keyboard-config led set "3,12" --colour "rgb(144,128,112)"
rpi-keyboard-config led set "3,13" --colour "rgb(240,240,32)"
rpi-keyboard-config led set "3,15" --colour "rgb(160,160,160)"
#
rpi-keyboard-config led set "4,0" --colour "rgb(96,160,160)"
rpi-keyboard-config led set "4,2" --colour "rgb(160,160,160)"
rpi-keyboard-config led set "4,3" --colour "rgb(160,160,160)"
rpi-keyboard-config led set "4,4" --colour "rgb(160,160,160)"
rpi-keyboard-config led set "4,5" --colour "rgb(160,160,160)"
rpi-keyboard-config led set "4,6" --colour "rgb(160,160,160)"
rpi-keyboard-config led set "4,7" --colour "rgb(160,160,160)"
rpi-keyboard-config led set "4,8" --colour "rgb(160,160,160)"
rpi-keyboard-config led set "4,9" --colour "rgb(144,128,112)"
rpi-keyboard-config led set "4,10" --colour "rgb(144,128,112)"
rpi-keyboard-config led set "4,11" --colour "rgb(144,128,112)"
rpi-keyboard-config led set "4,13" --colour "rgb(96,160,160)"
rpi-keyboard-config led set "4,14" --colour "rgb(176,176,0)"
rpi-keyboard-config led set "4,15" --colour "rgb(160,160,160)"
#
rpi-keyboard-config led set "5,0" --colour "rgb(96,160,160)"
rpi-keyboard-config led set "5,1" --colour "rgb(192,8,8)"
rpi-keyboard-config led set "5,2" --colour "rgb(96,160,160)"
rpi-keyboard-config led set "5,6" --colour "rgb(240,240,32)"
rpi-keyboard-config led set "5,10" --colour "rgb(96,160,160)"
rpi-keyboard-config led set "5,11" --colour "rgb(64,0,160)"
rpi-keyboard-config led set "5,12" --colour "rgb(96,160,160)"
rpi-keyboard-config led set "5,13" --colour "rgb(176,176,0)"
rpi-keyboard-config led set "5,14" --colour "rgb(176,176,0)"
rpi-keyboard-config led set "5,15" --colour "rgb(176,176,0)"
#
rpi-keyboard-config leds save
