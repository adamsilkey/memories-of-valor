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

    self.width = self.tilemapDef.width      ---@type integer Number of tiles by width
    self.height = self.tilemapDef.height    ---@type integer Number of tiles by height

    ---@type TileMap[]
    self.layers = {}
    for index, layerdef in ipairs(self.tilemapDef.layers) do
        table.insert(self.layers, TileMap(layerdef))
    end

    ---@type Cursor Strategic Cursor used to select items on map
    self.cursor = Cursor(self)

    local heroDef = ENTITY_DEFS[ENTITIES.HEROES.SWORD_1]
    ---@type Entity
    self.entity = Entity(heroDef, 2, 2)
    self.entity.stateMachine = StateMachine {
        [STATES.ENTITY_IDLE_STATE] = function() return EntityIdleState(self.entity) end,
    }
    self.entity:changeState(STATES.ENTITY_IDLE_STATE)

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

function Level:update(dt)
    -- self.player:update(dt)
    self.entity:update(dt)
    self.cursor:update(dt)
end

function Level:render()
    for index, layer in ipairs(self.layers) do
        layer:render()
    end

    self.entity:render()

    self.cursor:render()
end

--- Determines if a given TileX/TileY coordinate is inbounds
---@param tileX tileX
---@param tileY tileY
---@return boolean
function Level:inbounds(tileX, tileY)
    return tileX >= 1 and tileX <= self.width and tileY >= 1 and tileY <= self.height
end