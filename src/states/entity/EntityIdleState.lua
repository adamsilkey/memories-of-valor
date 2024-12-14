--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

	Code adapted from Colton Ogden's GD50 code
]]

---@class EntityIdleState: BaseState
EntityIdleState = Class{__includes = EntityBaseState}

EntityIdleState.NAME = 'EntityIdleState'

---@param entity Entity
function EntityIdleState:init(entity)
    self.entity = entity

    self.entity:changeAnimation('idle-' .. self.entity.direction)

    ---@type seconds Wait Duration in seconds, used for AI Control
    self.waitDuration = 0
    ---@type seconds Wait Timer in seconds, used for AI Control
    self.waitTimer = 0
end

-- --[[
--     We can call this function if we want to use this state on an agent in our game; otherwise,
--     we can use this same state in our Player class and have it not take action.
-- ]]
-- ---@param params table | nil Table of AI Parameters
-- ---@param dt seconds Delta time, in seconds
-- function EntityIdleState:processAI(params, dt)
--     if self.waitDuration == 0 then
--         self.waitDuration = math.random(5)
--     else
--         self.waitTimer = self.waitTimer + dt

--         if self.waitTimer > self.waitDuration then
--             self.entity:changeState('walk')
--         end
--     end
-- end
