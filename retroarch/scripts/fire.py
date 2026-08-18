import random
import time
from RPiKeyboardConfig import RPiKeyboardConfig

keyboard = RPiKeyboardConfig()
keyboard.set_led_direct_effect()

# Fire palette in HSV (black -> red -> orange -> yellow -> white)
palette = [
    (0, 0, 0),          # black
    (0, 255, 80),       # dark red
    (0, 255, 180),      # red
    (16, 255, 255),     # orange
    (20, 220, 255),     # yellow
    (20, 100, 255)        # white-ish
]

# Keyboard positions
all_leds = keyboard.get_leds()
positions = [tuple(led.matrix) for led in all_leds]
pos_to_idx = {tuple(led.matrix): led.idx for led in all_leds}

min_row = min(r for r, c in positions)
max_row = max(r for r, c in positions)
min_col = min(c for r, c in positions)
max_col = max(c for r, c in positions)

kb_width = max_col - min_col + 1
virtual_width = kb_width * 2  # double-width virtual grid
center_offset = (virtual_width - kb_width) // 2

# Initialize virtual heat grid
heat = {}
for r in range(min_row, max_row+1):
    for c in range(virtual_width):
        heat[(r, c)] = 0

def seed_bottom():
    """Seed the virtual bottom row with embers"""
    for c in range(virtual_width):
        heat[(max_row, c)] = random.randint(120, 255)

def propagate_fire():
    new_heat = heat.copy()
    for r in range(min_row, max_row):
        for c in range(virtual_width):
            below = [heat.get((r+1, c-1), 0), heat.get((r+1, c), 0), heat.get((r+1, c+1), 0)]
            avg = sum(below) // len(below)
            new_heat[(r, c)] = max(0, avg - random.randint(0, 50))
    return new_heat

def draw_fire():
    for (r, c) in positions:
        idx = pos_to_idx[(r, c)]
        virtual_c = c - min_col + center_offset  # map keyboard to virtual grid
        val = heat.get((r, virtual_c), 0)
        pal_idx = min(val * (len(palette)-1) // 255, len(palette)-1)
        keyboard.set_led_by_idx(idx=idx, colour=palette[pal_idx])
    keyboard.send_leds()

# Main loop
fps =5

try:
    while True:
        seed_bottom()
        draw_fire()
        heat = propagate_fire()
        time.sleep(1/fps)
        
except KeyboardInterrupt:
    keyboard.rgb_clear()
    keyboard.send_leds()
