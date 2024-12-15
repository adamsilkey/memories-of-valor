--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

    -- BattleTargetSelectionState --
]]

---@class BattleTargetSelectionState: BaseState
BattleTargetSelectionState = Class{__includes = BaseState}

BattleTargetSelectionState.NAME = 'BattleTargetSelectionState'

---@param level Level
---@param entity Entity
function BattleTargetSelectionState:init(level, entity)
    ---@type Level
    self.level = level
    assert(self.level ~= nil, "level didn't assign")
    ---@type Entity
    self.entity = entity
    assert(self.entity ~= nil, "entity didn't assign")

    --- Instantiate a new RangeFinder
    ---@type RangeFinderDef
    local def = {
        level = self.level,
        entity = self.entity,
        range = 1,      ---@TODO Hardcoded for now, will need to accomodate for range attackers in the future
        color = GFX.UI.RANGE_FINDER_RED_50,
        centerColor = GFX.UI.RANGE_FINDER_BLUE_FULL,
    }
    ---@type RangeFinder
    self.rangeFinder = RangeFinder(def)
    --- Limit Cursor range to attack range (make it melee for now)
    --- Selection on self

    --- Insantiate a new cursor
    ---@type Cursor
    self.cursor = Cursor()
end

function BattleTargetSelectionState:update(dt)
    self.level:update(dt)

    if love.keyboard.wasPressed(KEYS.ESCAPE) then
        StateStack:pop()
    end
end

function BattleTargetSelectionState:render(dt)
    self.rangeFinder:render()
    self.cursor:render()

    -- Need to rerender Entity so it shows up on top
    self.entity:render()
--     self.level:update(dt)
--     self.entity:update(dt)
end