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

    ---@type RangeFinderDef
    local rangeDef = {
        entity = self.selectedEntity,
        level = self.level,
    }
    self.level.rangeFinder = RangeFinder(rangeDef)

    ---@type tileX Stores starting X Position
    self.originX = self.selectedEntity.gridX
    ---@type tileY Stores starting Y Position
    self.originY = self.selectedEntity.gridY
end

function HeroSelectState:update(dt)
    if not self.dialogueOpened then
        if (
            love.keyboard.wasPressed(KEYS.ENTER) or
            love.keyboard.wasPressed(KEYS.RETURN)
            or love.mouse.wasPressed(1)
        ) then
            print("Enter a menu, dude!")
        elseif love.keyboard.wasPressed(KEYS.ESCAPE) then
            -- Disable control of Hero
            self.selectedEntity.controllable = false

            local defs = {
                toX = self.originX,
                toY = self.originY
            }
            self.selectedEntity:changeState(STATES.ENTITY_AUTO_WALK, defs)

            -- Return to origin spot
            StateStack:pop()
        end
    end

    self.level:update(dt)
end

function HeroSelectState:render()
    self.level:render()
end

function HeroSelectState:enter(params)

    --- Disable GameQuit in this State
    Game.CAN_QUIT = false

    --- Set State Defaults
    self.canInput = true
    self.dialogueOpened = false
    self.selectedEntity.controllable = true
    self.level.cursor:disable()
end

function HeroSelectState:exit()
    print('leaving HeroSelectState')

    -- Set location of cursor to the x, y of current selected entity
    self.level.cursor.tileX = self.selectedEntity.gridX
    self.level.cursor.tileY = self.selectedEntity.gridY
    -- Remove RangeFinder
    self.level.rangeFinder = nil
    -- Re-enable cursor
    self.level.cursor:enable()
end