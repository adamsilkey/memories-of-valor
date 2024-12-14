--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

	Code adapted from Colton Ogden's GD50 code
]]

---@class Level
Level = Class{}

---@param tilemapDef TileMapDef
function Level:init(tilemapDef)

    self.tilemapDef = tilemapDef

    self.tilemapWidth = self.tilemapDef.width      ---@type integer Number of tiles by width
    self.tilemapHeight = self.tilemapDef.height    ---@type integer Number of tiles by height

    ---@type TileMap[]
    self.layers = {}
    for index, layerdef in ipairs(self.tilemapDef.layers) do
        table.insert(self.layers, TileMap(layerdef))
    end


    -- ---@type PlayerDef
    -- local playerDef = {
    --     animations = ENTITY_DEFS['player'].animations,
    --     mapX = 10,
    --     mapY = 10,
    --     width = 16,
    --     height = 16,
    -- }
    -- ---@type Player
    -- self.player = Player(playerDef)

    -- self.player.stateMachine = StateMachine {
    --     [Entity.STATES.WALK] = function() return PlayerWalkState(self.player, self) end,
    --     [Entity.STATES.IDLE] = function() return PlayerIdleState(self.player) end
    -- }
    -- self.player.stateMachine:change(Entity.STATES.IDLE)
end

-- function Level:createMaps()

--     -- fill the base tiles table with random grass IDs
--     for y = 1, self.tileHeight do
--         table.insert(self.baseLayer.tiles, {})

--         for x = 1, self.tileWidth do
--             local id = TILE_IDS['grass'][math.random(#TILE_IDS['grass'])]

--             table.insert(self.baseLayer.tiles[y], Tile(x, y, id))
--         end
--     end

--     -- place tall grass in the tall grass layer
--     for y = 1, self.tileHeight do
--         table.insert(self.grassLayer.tiles, {})
--         table.insert(self.halfGrassLayer.tiles, {})

--         for x = 1, self.tileWidth do
--             local id = y > 10 and TILE_IDS['tall-grass'] or TILE_IDS['empty']

--             table.insert(self.grassLayer.tiles[y], Tile(x, y, id))
--         end
--     end
-- end

function Level:update(dt)
    -- self.player:update(dt)
end

function Level:render()
    for index, layer in ipairs(self.layers) do
        layer:render()
    end
    -- self.baseLayer:render()
    -- self.grassLayer:render()
    -- self.player:render()
end

--[[
    Convert mouse coordinates into Level.gridX/Level.gridY
]]
---comment
---@param mouseX pixels
---@param mouseY pixels
---@return tileX | nil
---@return tileY | nil
function Level:findTileFromMouseCoordinate(mouseX, mouseY)
    -- Algorithm reverses Colton's rendering algorithm:
    -- 1. Divide by 16 (tile width/ height)
    -- 2. Add one, which is an offset
    local tileX = nil
    local tileY = nil

    if mouseX ~= nil then
        tileX = math.floor((mouseX / TILE_SIZE) + 1)
    end
    if mouseY ~= nil then
        tileY = math.floor((mouseY / TILE_SIZE) + 1)
    end

    return tileX, tileY
end