Hypseus Singe (v2.11.2)
=======================

Windows 64bit version v2.11.2_x64

https://github.com/DirtBagXon/hypseus-singe


Hypseus is a fork of Matt Ownby's Daphne.

A program to play laserdisc arcade games on a PC or Raspberry Pi.

This version includes Singe support for Fan Made and American Laser Games.

Features:

Updated MPEG2 decoder
Integrated bezel support
Daphne VLDP 32bit upgrade
Daphne and Singe 4k M2V support
SDL_GameController configuration
Sinden borders in Singe
Singe Joystick/Lightgun [mouse] support
Singe 2 full 32bit overlay support
Respect video aspect ratios
Alternate overlay choice
Advanced multi joystick configuration
PNG screenshots


Joystick
========

Includes hypjsch.exe config helper to aide configuration of hypinput.ini


Singe
=====

For Singe, provide the following arguments to hypseus:

hypseus.exe singe vldp -blend_sprites -framefile singe\timegal\timegal.txt -script singe\timegal\timegal.singe 


Singe joystick [mouse] support
==============================

Singe now automatically interprets joystick axis change as mouse movement (Gun Games).

Adjust sensitivity via -js_range <1-20> in Singe arguments.

Configure joystick buttons in hypinput.ini

Software Scoreboard
===================

Enable the original style external scoreboard panel in lair/ace: -scorepanel

Works in conjunction with -fullscreen_window or normal windowed mode.

Extended arguments and keys
===========================

The following additional arguments have been added to Hypseus Singe:

-bezel <lair.png>          [ Specify a png bezel in 'bezels' sub-folder    ]
-keymapfile                [ Specify an alternate hypinput.ini file        ]
-alt_osd                   [ Use alternate lair/ace font overlay           ]
-blend_osd                 [ Use TTF blending on alternate font overlay    ]
-scanlines                 [ Simulate scanlines [adjust: -x -y]            ]
-linear_scale              [ Enable bilinear scaling [fullscreen]          ]
-novsync                   [ Disable VSYNC presentation on Renderer [crt]  ]
-gamepad                   [ Enable SDL_GameController in config (hotplug) ]
-grabmouse                 [ Capture mouse in SDL window                   ]
-original_overlay          [ Enable daphne style overlays (lair,ace,lair2) ]
-scorepanel                [ Enable software scoreboard in lair/ace        ]
-scorepanel_position <x y> [ Adjust position of software_scorepanel        ]
-blank_blue                [ VLDP blank using YUV#1DEB6B not YUV#108080    ]
-blank_searches            [ VLDP blanking [adjust: -min_seek_delay]       ]
-blank_skips               [ VLDP blanking [adjust: -min_seek_delay]       ]
-scalefactor               [ Scale video image [50-100%]                   ]
-scanlines                 [ Simulate scanlines [adjust: -scanline_shunt]  ]
-scanline_alpha <1-255>    [ Adjust scanline alpha blending                ]
-scanline_shunt <2-10>     [ Shunt scanline spacing [adjust: -x -y]        ]
-force_aspect_ratio        [ Force 4:3 aspect ratio                        ]
-tiphat                    [ Invert joystick SDL_HAT_UP and SDL_HAT_DOWN   ]
-vertical_stretch <1-24>   [ Overlay stretch implemented for (cliff) only  ]

-opengl                    [ Enable OpenGL SDL Window context              ]
-vulkan                    [ Enable Vulkan SDL Window instance             ]

-8bit_overlay              [ Restore original 8bit Singe overlay           ]
-blend_sprites             [ Restore BLENDMODE outline on Singe sprites    ]
-bootsilent                [ Attempt to mute sound on initVLDP() boot      ]
-js_range <1-20>           [ Adjust Singe joystick sensitivity: [def:5]    ]
-manymouse                 [ Enable absolute mouse input [lightguns]       ]
-nocrosshair               [ Request game does not display crosshairs      ]
-silentboot                [ Mute sound on initVLDP() boot sequence        ]

-sinden <1-10> <color>     [ Enable software border for lightguns          ]
                           [ Color: (w)hite, (r)ed, (g)reen, (b)lue or (x) ]

Alt-Backspace              [ Toggle scanlines                              ]
Alt-Enter                  [ Toggle fullscreen                             ]
[KEY_BUTTON3]              [ Toggle scoreboard display in lair/ace         ]
[KEY_COIN1]=|[KEY_START1]  [ Joystick hotkey combination for [KEY_QUIT]    ]

Support
=======

This software intended for educational purposes only. Please submit issues or pull requests directly to the project.

DO NOT submit issues or request support from the official Daphne forums!

About
=====

Open development by the original author, Matt Ownby, ceased years ago.

Singe was created by Scott Duensing as a plugin to Daphne to allow the playing of American Laser Games.

This repository was created to build upon the Hypseus project created by Jeffrey Clark. Many overlays were still unimplemented in the original repository. Singe had also been removed.

The name was changed to Hypseus so the original authors of Daphne would not be burdened with requests for support.

A big thanks goes out to Matt Ownby, Scott Duensing, Jeffrey Clark, Manuel Alfayate, David Griffith and the many other developers who made their work available for me to build upon. Without them this project would not be possible.

License
=======

Hypseus Singe, Being Retro Orientated This Humble Emulator Regenerates
Copyright (C) 2021-2024 DirtBagXon

Hypseus, Multiple Arcade Laserdisc Emulator
Copyright (C) 2016 Jeffrey Clark

Daphne, the First Ever Multiple Arcade Laserdisc Emulator
Copyright (C) 1999-2013 Matt Ownby

GNU General Public License version 3

This program is free software: you can redistribute it and/or modify
it under the terms of the [GNU General Public License] as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
[GNU General Public License] for more details.

Trademark
=========

The "Hypseus Singe" mark is used to uniquely identify this project as an Arcade Laserdisc Emulator. Any direct or indirect commercial use of the mark "Hypseus" is strictly prohibited without express permission.
