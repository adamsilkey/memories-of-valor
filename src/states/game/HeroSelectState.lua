--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

    -- HeroSelectState --
]]

---@class HeroSelectState: BaseState
HeroSelectState = Class{__includes = BaseState}

HeroSelectState.NAME = 'HeroSelectState'

---@param level Level
---@param entity Entity
function HeroSelectState:init(level, entity)

    ---@type Level
    self.level = level

    ---@type Entity
    self.selectedEntity = entity

    ---@type boolean Controls whether or not we can input
    self.canInput = true

    ---@type boolean Controls the display of the cursor
    self.showCursor = true

    -- gSounds[SOUNDS.MUSIC.FIELD]:setLooping(true)
    -- gSounds[SOUNDS.MUSIC.FIELD]:play()

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

function HeroSelectState:exit()
    print("see ya later, nerd")
end