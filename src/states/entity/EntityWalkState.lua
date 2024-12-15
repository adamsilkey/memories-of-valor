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
    -- We can only move the entity when the entity is controllable
    if not self.entity.controllable then
        self.entity:changeState(STATES.ENTITY_IDLE)
    end

    self.entity:changeAnimation(ANIMATIONS.WALK_BASE .. tostring(self.entity.direction))

    local toX, toY = self.entity.gridX, self.entity.gridY

    if self.entity.direction == DIRS.LEFT then
        toX = toX - 1
    elseif self.entity.direction == DIRS.RIGHT then
        toX = toX + 1
    elseif self.entity.direction == DIRS.UP then
        toY = toY - 1
    else    -- DIRS.DOWN
        toY = toY + 1
    end

    -- break out if we try to move out of the map boundaries or try to move through an impassible spot
    -- if toX < 1 or toX > self.level.width or toY < 1 or toY > self.level.height then
    if not self.level:inbounds(toX, toY) or not self.level:isPassable(toX, toY) then
        self.entity:changeState(STATES.ENTITY_IDLE)
        self.entity:changeAnimation(ANIMATIONS.IDLE_BASE .. tostring(self.entity.direction))
        return
    end

    -- Since we are moving between grid spots, we tween the X/Y position of our sprite
    -- over a short time period
    Timer.tween(0.15, {
        [self.entity] = {
            x = (toX - 1) * TILE_SIZE,
            y = (toY - 1) * TILE_SIZE,
        }
    }):finish(function()
        -- Update the entity's gridX/gridY
        self.entity.gridY = toY
        self.entity.gridX = toX

        -- Handle additional input
        if love.keyboard.isDown(KEYS.LEFT, KEYS.A) then
            self.entity.direction = DIRS.LEFT
            self.entity:changeState(STATES.ENTITY_WALK)
        elseif love.keyboard.isDown(KEYS.RIGHT, KEYS.D) then
            self.entity.direction = DIRS.RIGHT
            self.entity:changeState(STATES.ENTITY_WALK)
        elseif love.keyboard.isDown(KEYS.UP, KEYS.W) then
            self.entity.direction = DIRS.UP
            self.entity:changeState(STATES.ENTITY_WALK)
        elseif love.keyboard.isDown(KEYS.DOWN, KEYS.D) then
            self.entity.direction = DIRS.DOWN
            self.entity:changeState(STATES.ENTITY_WALK)
        else
            -- Always look down when exiting movement
            self.entity.direction = DIRS.DOWN
            self.entity:changeState(STATES.ENTITY_IDLE)
        end
    end)
end