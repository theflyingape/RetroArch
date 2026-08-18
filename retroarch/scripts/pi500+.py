#!/bin/python

import sys
from typing import Tuple
from RPiKeyboardConfig import RPiKeyboardConfig

kb = RPiKeyboardConfig()
# print(f"Model: {kb.model} {kb.variant}")

if kb.model != "PI500PLUS":
    sys.exit(1)

def color(pick: str) -> Tuple[int, int, int]:
    pick = pick.strip().lower()
    palette = {
        'red': (0, 255, 255),
        'green': (85, 255, 255),
        'blue': (170, 255, 255),
        'white': (0, 0, 255),
        'black': (0, 0, 0),
        'yellow': (43, 255, 255),
        'cyan': (128, 255, 255),
        'magenta': (213, 255, 255),
        'orange': (21, 255, 255),
        'purple': (213, 127, 128),
        'pink': (234, 76, 255)
    }
    if pick in palette:
        return palette[pick]

def rgb(r: int, g: int, b: int) -> Tuple[int, int, int]:
    """Convert RGB values (0-255) to HSV values (0-255).
    
    Args:
        r: Red component (0-255)
        g: Green component (0-255) 
        b: Blue component (0-255)
        
    Returns:
        Tuple of (hue, saturation, value) where each is 0-255
    """
    r, g, b = r / 255.0, g / 255.0, b / 255.0
    mx = max(r, g, b)
    mn = min(r, g, b)
    diff = mx - mn
    if diff == 0:
        h = 0
    elif mx == r:
        h = (60 * ((g - b) / diff) + 360) % 360
    elif mx == g:
        h = (60 * ((b - r) / diff) + 120) % 360
    elif mx == b:
        h = (60 * ((r - g) / diff) + 240) % 360
    if mx == 0:
        s = 0
    else:
        s = diff / mx
    v = mx
    return int(h * 255 / 360), int(s * 255), int(v * 255)

n = len(sys.argv)
i = 1
if n > i:
    kb.get_preset(0)
    kb.revert_to_saved_preset()
    if sys.argv[i] == "clear":
        kb.rgb_clear()
        if i + 1 < n:
            i += 1
    if sys.argv[i] == "reset":
        #kb.load_direct_leds()
        leds = kb.get_saved_direct_leds()
        for led in leds:
            kb.set_led_by_matrix(matrix=led.matrix, colour=led.colour)
        if i + 1 < n:
            i += 1
    match sys.argv[i]:
        case "comp":
            kb.set_led_by_matrix(matrix=[0,0], colour=rgb(255,0,0))
            kb.set_led_by_matrix(matrix=[0,13], colour=rgb(255,128,0))
            kb.set_led_by_matrix(matrix=[0,14], colour=rgb(255,0,0))
            kb.set_led_by_matrix(matrix=[2,12], colour=rgb(255,128,0))
            kb.set_led_by_matrix(matrix=[2,13], colour=rgb(255,128,0))
            kb.set_led_by_matrix(matrix=[2,14], colour=rgb(255,128,0))
            # Caps Lock toggles game / computer keyboard focus
            kb.set_led_by_matrix(matrix=[3,0], colour=rgb(255,128,0))
            kb.set_led_by_matrix(matrix=[4,14], colour=rgb(255,208,255))
            kb.set_led_by_matrix(matrix=[5,1], colour=rgb(255,128,0))
            kb.set_led_by_matrix(matrix=[5,12], colour=rgb(255,128,0))
            kb.set_led_by_matrix(matrix=[5,13], colour=rgb(144,208,255))
            kb.set_led_by_matrix(matrix=[5,14], colour=rgb(255,208,255))
            kb.set_led_by_matrix(matrix=[5,15], colour=rgb(255,208,255))
            if i + 1 < n:
                i += 1
        case "game":
            kb.set_led_by_matrix(matrix=[0,0], colour=rgb(255,0,0))
            kb.set_led_by_matrix(matrix=[0,10], colour=rgb(255,0,0))
            kb.set_led_by_matrix(matrix=[0,13], colour=rgb(255,128,0))
            kb.set_led_by_matrix(matrix=[0,14], colour=rgb(255,0,0))
            kb.set_led_by_matrix(matrix=[1,10], colour=rgb(255,128,0))
            kb.set_led_by_matrix(matrix=[1,11], colour=rgb(255,128,0))
            kb.set_led_by_matrix(matrix=[1,12], colour=rgb(255,128,0))
            kb.set_led_by_matrix(matrix=[1,14], colour=rgb(255,128,0))
            kb.set_led_by_matrix(matrix=[2,2], colour=rgb(16,255,255))
            kb.set_led_by_matrix(matrix=[2,3], colour=rgb(16,255,255))
            kb.set_led_by_matrix(matrix=[3,2], colour=rgb(16,255,16))
            kb.set_led_by_matrix(matrix=[3,3], colour=rgb(16,16,255))
            kb.set_led_by_matrix(matrix=[3,13], colour=rgb(255,128,0))
            kb.set_led_by_matrix(matrix=[4,2], colour=rgb(255,16,16))
            kb.set_led_by_matrix(matrix=[4,3], colour=rgb(255,255,16))
            kb.set_led_by_matrix(matrix=[4,9], colour=rgb(255,128,0))
            kb.set_led_by_matrix(matrix=[4,10], colour=rgb(255,128,0))
            kb.set_led_by_matrix(matrix=[4,11], colour=rgb(255,128,0))
            kb.set_led_by_matrix(matrix=[4,13], colour=rgb(255,128,0))
            kb.set_led_by_matrix(matrix=[4,14], colour=rgb(144,208,255))
            kb.set_led_by_matrix(matrix=[5,13], colour=rgb(144,208,255))
            kb.set_led_by_matrix(matrix=[5,14], colour=rgb(144,208,255))
            kb.set_led_by_matrix(matrix=[5,15], colour=rgb(144,208,255))
            if i + 1 < n:
                i += 1
        case "mame":
            kb.set_led_by_matrix(matrix=[0,0], colour=rgb(255,0,0))
            kb.set_led_by_matrix(matrix=[0,10], colour=rgb(255,0,0))
            kb.set_led_by_matrix(matrix=[0,13], colour=rgb(255,128,0))
            kb.set_led_by_matrix(matrix=[0,14], colour=rgb(255,0,0))
            kb.set_led_by_matrix(matrix=[1,1], colour=rgb(255,255,255))
            kb.set_led_by_matrix(matrix=[1,2], colour=rgb(255,255,255))
            kb.set_led_by_matrix(matrix=[1,3], colour=rgb(208,208,0))
            kb.set_led_by_matrix(matrix=[1,4], colour=rgb(208,208,0))
            kb.set_led_by_matrix(matrix=[1,5], colour=rgb(64,255,64))
            kb.set_led_by_matrix(matrix=[1,6], colour=rgb(64,255,64))
            kb.set_led_by_matrix(matrix=[1,7], colour=rgb(0,208,0))
            kb.set_led_by_matrix(matrix=[1,8], colour=rgb(0,208,0))
            kb.set_led_by_matrix(matrix=[1,10], colour=rgb(255,128,0))
            kb.set_led_by_matrix(matrix=[1,11], colour=rgb(255,128,0))
            kb.set_led_by_matrix(matrix=[1,12], colour=rgb(255,128,0))
            kb.set_led_by_matrix(matrix=[1,14], colour=rgb(255,128,0))
            # Tab for MAME menu
            kb.set_led_by_matrix(matrix=[2,0], colour=rgb(255,128,0))
            kb.set_led_by_matrix(matrix=[2,2], colour=rgb(16,255,255))
            kb.set_led_by_matrix(matrix=[2,3], colour=rgb(16,255,255))
            kb.set_led_by_matrix(matrix=[3,2], colour=rgb(16,255,16))
            kb.set_led_by_matrix(matrix=[3,3], colour=rgb(16,16,255))
            kb.set_led_by_matrix(matrix=[3,13], colour=rgb(255,128,0))
            kb.set_led_by_matrix(matrix=[4,2], colour=rgb(255,16,16))
            kb.set_led_by_matrix(matrix=[4,3], colour=rgb(255,255,16))
            kb.set_led_by_matrix(matrix=[4,9], colour=rgb(255,128,0))
            kb.set_led_by_matrix(matrix=[4,10], colour=rgb(255,128,0))
            kb.set_led_by_matrix(matrix=[4,11], colour=rgb(255,128,0))
            kb.set_led_by_matrix(matrix=[4,13], colour=rgb(255,128,0))
            kb.set_led_by_matrix(matrix=[4,14], colour=rgb(144,208,255))
            kb.set_led_by_matrix(matrix=[5,13], colour=rgb(144,208,255))
            kb.set_led_by_matrix(matrix=[5,14], colour=rgb(144,208,255))
            kb.set_led_by_matrix(matrix=[5,15], colour=rgb(144,208,255))
            if i + 1 < n:
                i += 1
    kb.send_leds()

if n > i:
    if sys.argv[i] == "es":
        kb.set_led_by_matrix(matrix=[0,4], colour=rgb(255,132,144))
        # Caps Lock toggles game / computer keyboard focus
        kb.set_led_by_matrix(matrix=[3,0], colour=rgb(255,128,0))
        kb.set_led_by_matrix(matrix=[5,6], colour=rgb(255,255,255))
        if i + 1 < n:
            i += 1
    if sys.argv[i] == "lr":
        kb.set_led_by_matrix(matrix=[4, 14], colour=color("black"))
        kb.set_led_by_matrix(matrix=[5, 14], colour=color("black"))
        if i + 1 < n:
            i += 1
    if sys.argv[i] == "ud":
        kb.set_led_by_matrix(matrix=[5, 13], colour=color("black"))
        kb.set_led_by_matrix(matrix=[5, 15], colour=color("black"))
        if i + 1 < n:
            i += 1
    if sys.argv[i] == "4way":
        kb.set_led_by_matrix(matrix=[4, 2], colour=color("black"))

if n > i:
    match sys.argv[i]:
        case "fire"|"4way":
            kb.set_led_by_matrix(matrix=[4, 3], colour=color("black"))
            kb.set_led_by_matrix(matrix=[3, 3], colour=color("black"))
            kb.set_led_by_matrix(matrix=[3, 2], colour=color("black"))
            kb.set_led_by_matrix(matrix=[2, 2], colour=color("black"))
            kb.set_led_by_matrix(matrix=[2, 3], colour=color("black"))
        case "fire2":
            kb.set_led_by_matrix(matrix=[3, 3], colour=color("black"))
            kb.set_led_by_matrix(matrix=[3, 2], colour=color("black"))
            kb.set_led_by_matrix(matrix=[2, 2], colour=color("black"))
            kb.set_led_by_matrix(matrix=[2, 3], colour=color("black"))
        case "fire3":
            kb.set_led_by_matrix(matrix=[3, 3], colour=color("black"))
            kb.set_led_by_matrix(matrix=[2, 2], colour=color("black"))
            kb.set_led_by_matrix(matrix=[2, 3], colour=color("black"))
        case "fire4":
            kb.set_led_by_matrix(matrix=[2, 2], colour=color("black"))
            kb.set_led_by_matrix(matrix=[2, 3], colour=color("black"))
    kb.send_leds()

sys.exit(0)

""" my default leds layout:
$ rpi-keyboard-config leds get-saved
LED  0: matrix=[0,  0], HSV=(  0, 255, 144)
LED  1: matrix=[0,  1], HSV=(127, 153, 160)
LED  2: matrix=[0,  2], HSV=(127, 153, 160)
LED  3: matrix=[0,  3], HSV=(127, 153, 160)
LED  4: matrix=[0,  4], HSV=(132, 255, 144)
LED  5: matrix=[0,  5], HSV=(132, 255, 144)
LED  6: matrix=[0,  6], HSV=(132, 255, 144)
LED  7: matrix=[0,  7], HSV=(153, 255, 160)
LED  8: matrix=[0,  8], HSV=(153, 255, 160)
LED  9: matrix=[0,  9], HSV=(153, 255, 160)
LED 10: matrix=[0, 10], HSV=(163, 242, 160)
LED 11: matrix=[0, 11], HSV=(163, 242, 160)
LED 12: matrix=[0, 12], HSV=(163, 242, 160)
LED 13: matrix=[0, 13], HSV=( 23, 255, 144)
LED 14: matrix=[0, 14], HSV=(  0, 255, 112)
LED 15: matrix=[0, 15], HSV=(  0,   0,   0)
LED 16: matrix=[1,  0], HSV=( 21,  56, 144)
LED 17: matrix=[1,  1], HSV=( 85, 255,  80)
LED 18: matrix=[1,  2], HSV=( 85, 255,  80)
LED 19: matrix=[1,  3], HSV=( 85, 255,  80)
LED 20: matrix=[1,  4], HSV=( 85, 255,  80)
LED 21: matrix=[1,  5], HSV=( 85, 255,  80)
LED 22: matrix=[1,  6], HSV=( 85, 255,  80)
LED 23: matrix=[1,  7], HSV=( 85, 255,  80)
LED 24: matrix=[1,  8], HSV=( 85, 255,  80)
LED 25: matrix=[1,  9], HSV=( 85, 255,  80)
LED 26: matrix=[1, 10], HSV=( 85, 255,  80)
LED 27: matrix=[1, 11], HSV=( 21,  56, 144)
LED 28: matrix=[1, 12], HSV=( 21,  56, 144)
LED 29: matrix=[1, 14], HSV=( 42, 221, 240)
LED 30: matrix=[1, 15], HSV=(  0,   0, 160)
LED 31: matrix=[2,  0], HSV=( 42, 255, 144)
LED 32: matrix=[2,  2], HSV=(  0,   0, 160)
LED 33: matrix=[2,  3], HSV=(  0,   0, 160)
LED 34: matrix=[2,  4], HSV=(  0,   0, 160)
LED 35: matrix=[2,  5], HSV=(  0,   0, 160)
LED 36: matrix=[2,  6], HSV=(  0,   0, 160)
LED 37: matrix=[2,  7], HSV=(  0,   0, 160)
LED 38: matrix=[2,  8], HSV=(  0,   0, 160)
LED 39: matrix=[2,  9], HSV=(  0,   0, 160)
LED 40: matrix=[2, 10], HSV=(  0,   0, 160)
LED 41: matrix=[2, 11], HSV=(  0,   0, 160)
LED 42: matrix=[2, 12], HSV=( 21,  56, 144)
LED 43: matrix=[2, 13], HSV=( 21,  56, 144)
LED 44: matrix=[2, 14], HSV=( 21,  56, 144)
LED 45: matrix=[2, 15], HSV=(  0,   0, 160)
LED 46: matrix=[3,  0], HSV=( 21,  63, 128)
LED 47: matrix=[3,  2], HSV=(  0,   0, 160)
LED 48: matrix=[3,  3], HSV=(  0,   0, 160)
LED 49: matrix=[3,  4], HSV=(  0,   0, 160)
LED 50: matrix=[3,  5], HSV=(  0,   0, 160)
LED 51: matrix=[3,  6], HSV=(  0,   0, 160)
LED 52: matrix=[3,  7], HSV=(  0,   0, 160)
LED 53: matrix=[3,  8], HSV=(  0,   0, 160)
LED 54: matrix=[3,  9], HSV=(  0,   0, 160)
LED 55: matrix=[3, 10], HSV=(  0,   0, 160)
LED 56: matrix=[3, 11], HSV=( 21,  56, 144)
LED 57: matrix=[3, 12], HSV=( 21,  56, 144)
LED 58: matrix=[3, 13], HSV=( 42, 221, 240)
LED 59: matrix=[3, 15], HSV=(  0,   0, 160)
LED 60: matrix=[4,  0], HSV=(127, 102, 160)
LED 61: matrix=[4,  2], HSV=(  0,   0, 160)
LED 62: matrix=[4,  3], HSV=(  0,   0, 160)
LED 63: matrix=[4,  4], HSV=(  0,   0, 160)
LED 64: matrix=[4,  5], HSV=(  0,   0, 160)
LED 65: matrix=[4,  6], HSV=(  0,   0, 160)
LED 66: matrix=[4,  7], HSV=(  0,   0, 160)
LED 67: matrix=[4,  8], HSV=(  0,   0, 160)
LED 68: matrix=[4,  9], HSV=( 21,  56, 144)
LED 69: matrix=[4, 10], HSV=( 21,  56, 144)
LED 70: matrix=[4, 11], HSV=( 21,  56, 144)
LED 71: matrix=[4, 13], HSV=(127, 102, 160)
LED 72: matrix=[4, 14], HSV=( 42, 255, 176)
LED 73: matrix=[4, 15], HSV=(  0,   0, 160)
LED 74: matrix=[5,  0], HSV=(127, 102, 160)
LED 75: matrix=[5,  1], HSV=(  0, 244, 192)
LED 76: matrix=[5,  2], HSV=(127, 102, 160)
LED 77: matrix=[5,  6], HSV=( 42, 221, 240)
LED 78: matrix=[5, 10], HSV=(127, 102, 160)
LED 79: matrix=[5, 11], HSV=(187, 255, 160)
LED 80: matrix=[5, 12], HSV=(127, 102, 160)
LED 81: matrix=[5, 13], HSV=( 42, 255, 176)
LED 82: matrix=[5, 14], HSV=( 42, 255, 176)
LED 83: matrix=[5, 15], HSV=( 42, 255, 176)
"""
