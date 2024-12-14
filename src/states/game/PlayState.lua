--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

    -- PlayState --

    This will typically act as the bottom of our StateStack

	Code adapted from Colton Ogden's GD50 code
]]


---@class PlayState: BaseState
PlayState = Class{__includes = BaseState}

PlayState.NAME = 'PlayState'

function PlayState:init()
    --- First time we initialize the PlayState, we need to initialize the first level
    --- This is hardcoded to just the first and only battle currently int he game, but could/should be
    --- expanded in the future

    ---@type Level
    self.level = Level(MapDefs.Battle01)
end

function PlayState:update(dt)
    StateStack:push(BattleState(self.level))
end

function PlayState:render()
end