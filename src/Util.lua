--[[
    Memories of Valor

    -- Util --

    Author: Adam Silkey

    Helper functions

    Adapted from Colton Ogden's GD50 code
]]

--[[
    Given an "atlas" (a texture with multiple sprites), as well as a
    width and a height for the tiles therein, split the texture into
    all of the quads by simply dividing it evenly.
]]
---@param atlas love.Image Loaded love image, typically sourced from gFrames
---@param tilewidth iPixels Tile width in pixels (0-based, row)
---@param tileheight iPixels Tile height in pixels (0-based, row)
---@return love.Quad[] spritesheet Array of Quads for spritesheet
function GenerateQuads(atlas, tilewidth, tileheight)
    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight

    local sheetCounter = 1
    local spritesheet = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            spritesheet[sheetCounter] =
                love.graphics.newQuad(x * tilewidth, y * tileheight, tilewidth,
                tileheight, atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end

    return spritesheet
end