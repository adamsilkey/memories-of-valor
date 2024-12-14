--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

	Code adapted from Colton Ogden's GD50 code
]]

---@class EntityWalkState: EntityBaseState
EntityWalkState = Class{__includes = EntityBaseState}

EntityWalkState.NAME = 'EntityWalkState'

---@param entity Entity
---@param level Level
function EntityWalkState:init(entity, level)
    self.entity = entity
    self.level = level

    ---@type boolean Flag to determine whether the Entity can currently walk
    self.canWalk = false
end

function EntityWalkState:enter(params)
    self:attemptMove()
end

function EntityWalkState:attemptMove()
    self.entity:changeAnimation(Entity.STATES.WALK .. '-' .. tostring(self.entity.direction))

    local toX, toY = self.entity.mapX, self.entity.mapY

    if self.entity.direction == DIRECTIONS.LEFT then
        toX = toX - 1
    elseif self.entity.direction == DIRECTIONS.RIGHT then
        toX = toX + 1
    elseif self.entity.direction == DIRECTIONS.UP then
        toY = toY - 1
    else    -- DIRECTIONS.DOWN
        toY = toY + 1
    end

    -- break out if we try to move out of the map boundaries
    if toX < 1 or toX > 24 or toY < 1 or toY > 13 then
        self.entity:changeState(Entity.STATES.IDLE)
        self.entity:changeAnimation(Entity.STATES.IDLE .. '-' .. tostring(self.entity.direction))
        return
    end

    self.entity.mapY = toY
    self.entity.mapX = toX

    Timer.tween(0.5, {
        [self.entity] = {x = (toX - 1) * TILE_SIZE, y = (toY - 1) * TILE_SIZE - self.entity.height / 2}
    }):finish(function()
        if love.keyboard.isDown(KEYS.LEFT) then
            self.entity.direction = DIRECTIONS.LEFT
            self.entity:changeState(Entity.STATES.WALK)
        elseif love.keyboard.isDown(KEYS.LEFT) then
            self.entity.direction = DIRECTIONS.RIGHT
            self.entity:changeState(Entity.STATES.WALK)
        elseif love.keyboard.isDown(KEYS.UP) then
            self.entity.direction = DIRECTIONS.UP
            self.entity:changeState(Entity.STATES.WALK)
        elseif love.keyboard.isDown(KEYS.DOWN) then
            self.entity.direction = DIRECTIONS.DOWN
            self.entity:changeState(Entity.STATES.WALK)
        else
            self.entity:changeState(Entity.STATES.IDLE)
        end
    end)
end