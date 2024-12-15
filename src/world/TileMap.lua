--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

	Code adapted from Colton Ogden's GD50 code
]]

---@class TileMap
TileMap = Class{}

---@enum TileMap.CLASSES
TileMap.CLASSES = {
    MAP = 'Map',
    COLLISION = 'Collision',
}


---@param layerdef TileMapLayerDef
function TileMap:init(layerdef)
    self.layerdef = layerdef

    self.name = layerdef.name
    self.class = layerdef.class

    ---@type Tile[][] Array of all the tiles
    self.tiles = {}

    ---@type integer[][] Raw Grid of ints
    self.rawgrid = {}

    ---@type Coordinates A Dictionary that allows us to look up if a tile is in a specific layer
    self.coordinates = Coordinates()

    ---@type integer Width of TileMap in number of tiles
    self.width = self.layerdef.width

    ---@type integer Height of TileMap in number of tiles
    self.height = self.layerdef.height

    ---@type boolean Determines if a map layer is visible or not
    self.visible = self.layerdef.visible

    local currentTileIndex
    local currentTile           ---@type frame
    for y = 1, self.height do
        table.insert(self.tiles, {})
        table.insert(self.rawgrid, {})
        for x = 1, self.width do
            -- Tiled Layer data is sequential, so we need to ensure that we are accounting
            -- for the width by offsetting by the width by the number of layers
            currentTileIndex = x + (y - 1) * self.width
            currentTile = self.layerdef.data[currentTileIndex]
            table.insert(self.tiles[y], Tile(x, y, currentTile))
            table.insert(self.rawgrid[y], currentTile)

            --- Add collisions
            if self.class == TileMap.CLASSES.COLLISION then
                if currentTile == TILE_IDS.BLOCKED then
                    self.coordinates:add(x, y)
                end
            end
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