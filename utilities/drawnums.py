#! /usr/bin/env python3
'''
Adds numbers to a sprite sheet for easy reference.

Original Code: Colton Ogden

Updates: Adam Silkey
'''
from PIL import Image, ImageDraw, ImageFont


# size of tile sheet on Y and X axis in tiles; replace these with something positive
########## CHECK TO MAKE SURE THESE ARE ALL RIGHT!!!!!!!!!!!!!
# TILES_HIGH = 14
# TILES_WIDE = 8
# TILE_SIZE = 32

if __name__ == '__main__':

    # replace 'tiles.png' with your sprite sheet
    img = Image.open('FullTileset.png')
    draw = ImageDraw.Draw(img)

    # custom small font, good for small tile sets
    font = ImageFont.truetype('04B_03__.TTF', 8)

    # keep track of which tile we're adding text to
    counter = 1

    for y in range(TILES_HIGH):
        for x in range(TILES_WIDE):
            draw.text((x * TILE_SIZE + 1, y * TILE_SIZE), str(counter), (0, 0, 0), font=font)
            draw.text((x * TILE_SIZE, y * TILE_SIZE + 1), str(counter), (0, 0, 0), font=font)
            draw.text((x * TILE_SIZE, y * TILE_SIZE), str(counter), (255, 0, 255), font=font)
            counter += 1

    # save as renamed tile sheet
    img.save('tiles_numbered.png')
