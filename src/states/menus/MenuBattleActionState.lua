--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

    Strategy RPG Game, made for GD50 Final Project
]]

---@class MenuBattleActionState
MenuBattleActionState = Class{__includes = MenuBaseState}

MenuBattleActionState.NAME = 'MenuBattleActionState'

---@param level Level Reference to active level
---@param entity Entity Reference to active entity
---@param onClose? function Callback function to call onClose
function MenuBattleActionState:init(level, entity, onClose)

    ---@type Level Reference to current level
    self.level = level

    ---@type Entity Reference to current entity
    self.entity = entity

    ---@TODO just stubbing in a panel for right now
    -- self.panel = Panel(20, 20, 60, 60)
    self.menu = BattleActionMenu()

    ---@type function Callback function to execute onClose
    self.onClose = onClose or function () end
end

function MenuBattleActionState:enter(params)
    self.entity.controllable = false
end

function MenuBattleActionState:exit(params)
    self.entity.controllable = false
end

function MenuBattleActionState:update(dt)

    self.level:update(dt)
    self.menu:update(dt)

    ---@TODO maybe use anypress here
    -- if love.keyboard.wasPressed(KEYS.ENTER)
    --     or love.keyboard.wasPressed(KEYS.RETURN)
    if love.keyboard.wasPressed(KEYS.ESCAPE) then
        StateStack:pop()
        self.onClose()
    end
end

function MenuBattleActionState:render()
    self.level:render()
    self.menu:render()
end