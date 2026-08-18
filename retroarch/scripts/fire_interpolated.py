import random
import time
from RPiKeyboardConfig import RPiKeyboardConfig

keyboard = RPiKeyboardConfig()
keyboard.set_led_direct_effect()

palette = [
    (0, 0, 0),
    (0, 255, 80),
    (0, 255, 180),
    (16, 255, 255),
    (20, 220, 255),
    (20, 100, 255)
]

all_leds = keyboard.get_leds()
positions = [tuple(led.matrix) for led in all_leds]
pos_to_idx = {tuple(led.matrix): led.idx for led in all_leds}

min_row = min(r for r, c in positions)
max_row = max(r for r, c in positions)
min_col = min(c for r, c in positions)
max_col = max(c for r, c in positions)

kb_width = max_col - min_col + 1
virtual_width = kb_width * 2
center_offset = (virtual_width - kb_width) // 2

def blank_heat():
    return { (r, c): 0 for r in range(min_row, max_row+1) for c in range(virtual_width) }

heat = blank_heat()
prev_heat = blank_heat()

def seed_bottom(hmap):
    for c in range(virtual_width):
        hmap[(max_row, c)] = random.randint(120, 255)

def propagate_fire(hmap):
    new_heat = hmap.copy()
    for r in range(min_row, max_row):
        for c in range(virtual_width):
            below = [hmap.get((r+1, c-1), 0), hmap.get((r+1, c), 0), hmap.get((r+1, c+1), 0)]
            avg = sum(below) // len(below)
            new_heat[(r, c)] = max(0, avg - random.randint(0, 50))
    return new_heat

def lerp_colour(c1, c2, t):
    return tuple(int(a + (b - a) * t) for a, b in zip(c1, c2))

def value_to_palette(val):
    pal_idx = val * (len(palette)-1) / 255.0
    lower = int(pal_idx)
    upper = min(lower+1, len(palette)-1)
    frac = pal_idx - lower
    return lerp_colour(palette[lower], palette[upper], frac)

def draw_fire(alpha):
    """alpha = 0..1 interpolation between prev_heat and heat"""
    for (r, c) in positions:
        idx = pos_to_idx[(r, c)]
        virtual_c = c - min_col + center_offset

        v1 = prev_heat.get((r, virtual_c), 0)
        v2 = heat.get((r, virtual_c), 0)
        val = (1 - alpha) * v1 + alpha * v2

        colour = value_to_palette(val)
        keyboard.set_led_by_idx(idx=idx, colour=colour)
    keyboard.send_leds()

# --- Main loop ---
fps = 310           # smooth refresh
sim_fps = 5        # fire motion speed
sim_interval = 1.0 / sim_fps
last_sim = time.time()

# keep two distinct frames
prev_heat = heat.copy()
next_heat = heat.copy()

try:
    while True:
        now = time.time()
        elapsed = now - last_sim

        if elapsed >= sim_interval:
            # advance simulation
            last_sim = now
            prev_heat = next_heat.copy()
            seed_bottom(next_heat)
            next_heat = propagate_fire(next_heat)
            elapsed = 0  # reset elapsed for interpolation

        # interpolation factor 0..1
        alpha = elapsed / sim_interval

        # blend between prev and next frame
        for (r, c) in positions:
            idx = pos_to_idx[(r, c)]
            virtual_c = c - min_col + center_offset

            v1 = prev_heat.get((r, virtual_c), 0)
            v2 = next_heat.get((r, virtual_c), 0)
            val = (1 - alpha) * v1 + alpha * v2

            colour = value_to_palette(val)
            keyboard.set_led_by_idx(idx=idx, colour=colour)

        keyboard.send_leds()
        time.sleep(1/fps)
except KeyboardInterrupt:
    keyboard.rgb_clear()
    keyboard.send_leds()
