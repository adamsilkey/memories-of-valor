--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

	Code adapted from Colton Ogden's GD50 code
]]


---@class PlayState: BaseState
PlayState = Class{__includes = BaseState}

PlayState.NAME = 'BattleMap'

function PlayState:init()
    --- First time we initialize the PlayState, we need to initialize the first level
    --- This is hardcoded to just the first and only battle currently int he game, but could/should be
    --- expanded in the future

    ---@type Level
    self.level = Level(MapDefs.Battle01)

    ---@type boolean Controls whether or not we can input
    self.canInput = true

    ---@type boolean Controls the display of the cursor
    self.showCursor = true

    -- gSounds[SOUNDS.MUSIC.FIELD]:setLooping(true)
    -- gSounds[SOUNDS.MUSIC.FIELD]:play()

    ---@type boolean Flag to determine if dialogue is currently open
    self.dialogueOpened = false
end

function PlayState:update(dt)
    if not self.dialogueOpened then
        if love.keyboard.wasPressed(KEYS.ENTER) or love.keyboard.wasPressed(KEYS.RETURN) then
            StateStack:push(FadeInState({
                r = 1, g = 1, b = 1
            }, 1,
            function ()
                StateStack:pop()
                StateStack:push(StartState())
            end))
        end
    end

    self.level:update(dt)
end

function PlayState:render()
    self.level:render()

    ---@TODO move this all to a cursor class
end