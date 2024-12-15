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

    ---@type RangeFinder RangeFinder that shows how far someone can move
    self.rangeFinder = nil

    -- Entities in the Level
    ---@type Entity[]
    self.entities = {}

    self:addGoodGuys()

end


function Level:addGoodGuys()
    ---@type {[string]: Vector }
    local heroes = {
        [ENTITIES.HEROES.SWORD_1] = Vector(3, 3),
        [ENTITIES.HEROES.SPEAR_1] = Vector(2, 4),
    }

    for heroString, startVec in pairs(heroes) do
        local heroDef = ENTITY_DEFS[heroString]
        ---@type Entity
        local hero = Entity(heroDef, startVec.x, startVec.y)
        hero.stateMachine = StateMachine {
            [STATES.ENTITY_IDLE] = function() return EntityIdleState(hero) end,
            [STATES.ENTITY_WALK] = function() return EntityWalkState(hero, self) end,
        }
        hero:changeState(STATES.ENTITY_IDLE)

        table.insert(self.entities, hero)
    end
end

function Level:update(dt)
    -- self.player:update(dt)
    for i, entity in ipairs(self.entities) do
        entity:update(dt)
    end

    if self.rangeFinder ~= nil then
        self.rangeFinder:update(dt)
    end
    self.cursor:update(dt)
end

function Level:render()
    for index, layer in ipairs(self.layers) do
        layer:render()
    end

    if self.rangeFinder ~= nil then
        self.rangeFinder:render()
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