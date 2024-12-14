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

    -- Entities in the Level
    ---@type Entity[]
    self.entities = {}

    self:addGoodGuys()
end


function Level:addGoodGuys()
    local heroDef = ENTITY_DEFS[ENTITIES.HEROES.SWORD_1]
    ---@type Entity
    local swordHero = Entity(heroDef, 2, 2)
    swordHero.stateMachine = StateMachine {
        [STATES.ENTITY_IDLE_STATE] = function() return EntityIdleState(swordHero) end,
    }
    swordHero:changeState(STATES.ENTITY_IDLE_STATE)

    table.insert(self.entities, swordHero)
end

function Level:update(dt)
    -- self.player:update(dt)
    for i, entity in ipairs(self.entities) do
        entity:update(dt)
    end
    self.cursor:update(dt)
end

function Level:render()
    for index, layer in ipairs(self.layers) do
        layer:render()
    end

    for i, entity in ipairs(self.entities) do
        entity:render()
    end

    self.cursor:render()
end

--- Determines if a given TileX/TileY coordinate is inbounds
---@param tileX tileX
---@param tileY tileY
---@return boolean
function Level:inbounds(tileX, tileY)
    return tileX >= 1 and tileX <= self.width and tileY >= 1 and tileY <= self.height
end