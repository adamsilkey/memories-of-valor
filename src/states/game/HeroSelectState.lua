--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

    -- HeroSelectState --

    State is used when a controllable hero is currently selected
]]

---@class HeroSelectState: BaseState
HeroSelectState = Class{__includes = BaseState}

HeroSelectState.NAME = 'HeroSelectState'

---@class HeroSelectStateEnterDef
---@field level Level
---@field entity Entity

---@param def HeroSelectStateEnterDef
function HeroSelectState:init(def)
    ---@type Level
    self.level = def.level
    ---@type Entity
    self.selectedEntity = def.entity

    ---@type boolean Controls whether or not we can input
    self.canInput = true

    ---@type boolean Flag to determine if dialogue is currently open
    self.dialogueOpened = false
end

function HeroSelectState:update(dt)
    if not self.dialogueOpened then
        if love.keyboard.wasPressed(KEYS.ENTER) or love.keyboard.wasPressed(KEYS.RETURN)
            or love.mouse.wasPressed(1) then
            StateStack:pop()
        end
    end

    self.level:update(dt)
end

function HeroSelectState:render()
    self.level:render()
end

function HeroSelectState:enter()

    --- Set State Defaults
    self.canInput = true
    self.dialogueOpened = false
    self.selectedEntity.controllable = true
    self.level.cursor.enabled = false
end

function HeroSelectState:exit()
    self.level.cursor.enabled = true
end