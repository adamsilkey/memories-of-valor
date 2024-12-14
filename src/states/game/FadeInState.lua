--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

	Code adapted from Colton Ogden's GD50 code
]]

---@class FadeInState: BaseState
FadeInState = Class{__includes = BaseState}

FadeInState.NAME = 'FadeIn'

---@param color RGB
---@param time seconds
---@param onFadeComplete function Callback function to execute on completion
function FadeInState:init(color, time, onFadeComplete)

    self.opacity = 0    ---@type number Opacity (0 - 1)

    self.r = color.r    -- Red Value (0 - 1)
    self.g = color.g    -- Green Value (0 - 1)
    self.b = color.b    -- Blue Value (0 - 1)
    self.time = time    -- Time in seconds

    Timer.tween(self.time, {
        [self] = {opacity = 1}
    })
    :finish(function()
        StateStack:pop()
        onFadeComplete()
    end)
end

function FadeInState:render()
    love.graphics.setColor(self.r, self.g, self.b, self.opacity)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    love.graphics.setColor(1, 1, 1, 1)
end