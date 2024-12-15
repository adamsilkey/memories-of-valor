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

    ---@type Coordinates Holds all the impassible tiles
    self.collision = Coordinates()

    ---@type TileMap[]
    self.layers = {}
    for index, layerdef in ipairs(self.tilemapDef.layers) do
        ---@class TileMap
        local tilemap = TileMap(layerdef)
        table.insert(self.layers, tilemap)

        -- If there's a collision layer, use that to determine collisions
        if tilemap.class == TileMap.CLASSES.COLLISION then
            self.collision = tilemap.coordinates
        end
    end


    ---@type Cursor Strategic Cursor used to select items on map
    self.cursor = Cursor(self)

    ---@type RangeFinder RangeFinder that shows how far someone can move
    self.rangeFinder = nil

    -- Entities in the Level
    ---@type Entity[]
    self.entities = {}

    self:addGoodGuys()
    self:addBadGuys()
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

function Level:addBadGuys()
    local badguys = {
        {ENTITIES.ENEMIES.BANDIT_1, Vector(20, 4)},
        {ENTITIES.ENEMIES.BANDIT_1, Vector(19, 5)},
        {ENTITIES.ENEMIES.BANDIT_1, Vector(19, 3)},
        {ENTITIES.ENEMIES.BANDIT_1, Vector(18, 3)},
        {ENTITIES.ENEMIES.BANDIT_1, Vector(21, 4)},
    }

    for i, badguyTbl in ipairs(badguys) do
        local badguyString = badguyTbl[1]
        local startVec = badguyTbl[2]

        -- print('adding StartVec: ', Vector.cString(startVec.x, startVec.y))
        local badguyDef = ENTITY_DEFS[badguyString]
        ---@type Entity
        local badguy = Entity(badguyDef, startVec.x, startVec.y)
        badguy.stateMachine = StateMachine {
            [STATES.ENTITY_IDLE] = function() return EntityIdleState(badguy) end,
            [STATES.ENTITY_WALK] = function() return EntityWalkState(badguy, self) end,
        }
        badguy:changeState(STATES.ENTITY_IDLE)

        table.insert(self.entities, badguy)
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
        if layer.visible then
            layer:render()
        end
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

--- Determines if an entity can pass a given coordinate
---@param tileX tileX
---@param tileY tileY
---@return boolean
function Level:isPassable(tileX, tileY)
    local passable = not self.collision:find(tileX, tileY)
    return passable
end

--- Determines if an entity can stop on a given coordinate
---@param tileX tileX
---@param tileY tileY
---@param entity Entity
---@return boolean
function Level:isStoppable(tileX, tileY, entity)
    local stoppable = not self.collision:find(tileX, tileY)
    return stoppable
end