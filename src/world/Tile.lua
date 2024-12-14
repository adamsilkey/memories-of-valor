--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

	Code adapted from Colton Ogden's GD50 code
]]

---@class Tile
Tile = Class{}

---comment
---@param x tileX The X coordinate of a Tile in the Map (not pixels)
---@param y tileY The Y coordinate of a Tile in the Map (not pixels)
---@param id frameID
function Tile:init(x, y, id)
    -- The X coordinate of a Tile in the Map (not pixels)
    self.x = x
    -- The Y coordinate of a Tile in the Map (not pixels)
    self.y = y
    -- Quad FrameID of the Tile
    self.id = id
end

function Tile:update(dt)

end

-- Renders a tile, converting TileMap Coordinates to Pixel Value
-- This is hardcoded for right now to go to the default World Tileset,
-- but we should be dynamically loading this in the future
function Tile:render()
    love.graphics.draw(
        Textures[GFX.TILES.WORLD],
        Frames[GFX.TILES.WORLD][self.id],
        (self.x - 1) * TILE_SIZE,
        (self.y - 1) * TILE_SIZE
    )
end