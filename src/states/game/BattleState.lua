--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

    -- BattleState --

	Code adapted from Colton Ogden's GD50 code
]]


---@class BattleState: BaseState
BattleState = Class{__includes = BaseState}

BattleState.NAME = 'BattleState'

---@param level Level
function BattleState:init(level)

    ---@type Level
    self.level = level

    ---@type boolean Controls whether or not we can input
    self.canInput = true

    ---@type boolean Controls the display of the cursor
    self.showCursor = true

    -- gSounds[SOUNDS.MUSIC.FIELD]:setLooping(true)
    -- gSounds[SOUNDS.MUSIC.FIELD]:play()

    ---@type boolean Flag to determine if dialogue is currently open
    self.dialogueOpened = false

    --------------
    --- Events ---
    --------------

    --- Cursor Events
    Event.on(EVENTS.CURSOR_SELECT, function(x, y)
        for i, entity in ipairs(self.level.entities) do
            if entity.gridX == x and entity.gridY == y then

                ---@type HeroSelectStateEnterDef
                local def = {
                    level = self.level,
                    entity = entity,
                }
                StateStack:push(HeroSelectState(def))
            end
        end
    end)
end

function BattleState:enter(params)
    print('did we enter???')
    -- Enable Cursor in BattleState
    self.level.cursor:enable()

    -- Enable Quit
    Game.CAN_QUIT = true
end

function BattleState:update(dt)
    if not self.dialogueOpened then
        -- if love.keyboard.wasPressed(KEYS.ENTER) or love.keyboard.wasPressed(KEYS.RETURN) then
        --     StateStack:push(FadeInState({
        --         r = 1, g = 1, b = 1
        --     }, 1,
        --     function ()
        --         StateStack:pop()
        --         StateStack:push(StartState())
        --     end))
        -- end
    end

    self.level:update(dt)
end

function BattleState:render()
    self.level:render()
end