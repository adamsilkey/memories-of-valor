--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

	Code adapted from Colton Ogden's GD50 code
]]

---@class TileMap
TileMap = Class{}

---@param layerdef TileMapLayerDef
function TileMap:init(layerdef)
    self.layerdef = layerdef

    ---@type Tile[][] Array of all the tiles
    self.tiles = {}

    ---@type integer Width of TileMap in number of tiles
    self.width = self.layerdef.width

    ---@type integer Height of TileMap in number of tiles
    self.height = self.layerdef.height

    local currentTile
    for y = 1, self.height do
        table.insert(self.tiles, {})
        for x = 1, self.width do
            -- Tiled Layer data is sequential, so we need to ensure that we are accounting
            -- for the width by offsetting by the width by the number of layers
            currentTile = x + (y - 1) * self.width
            table.insert(self.tiles[y], Tile(x, y, self.layerdef.data[currentTile]))
        end
    end
end

function TileMap:render()
    for y = 1, self.height do
        for x = 1, self.width do
            self.tiles[y][x]:render()
        end
    end
end