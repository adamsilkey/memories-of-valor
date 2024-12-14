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

    -- Variables related to grid movement

    self.showCursor = true      ---@type boolean Controls the display of the cursor
    self.cursorSelectX = 0        ---@type tileX X position on grid we're highlighting
    self.cursorSelectY = 0        ---@type tileY X position on grid we're highlighting

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

    --- Probably want to move all this move functionality to a separate move state for the stack
    --- The tilemapHeight/Width are offset by one because this is 0-based
    if self.canInput then
        ---@TODO Add sound here
        -- Move cursor around
        if love.keyboard.wasPressed(KEYS.UP) then
            self.cursorSelectY = math.max(0, self.cursorSelectY - 1)
        elseif love.keyboard.wasPressed(KEYS.DOWN) then
            self.cursorSelectY = math.min(self.level.tilemapHeight - 1, self.cursorSelectY + 1)
        elseif love.keyboard.wasPressed(KEYS.LEFT) then
            self.cursorSelectX = math.max(0, self.cursorSelectX - 1)
        elseif love.keyboard.wasPressed(KEYS.RIGHT) then
            self.cursorSelectX = math.min(self.level.tilemapWidth - 1, self.cursorSelectX + 1)
        end
    end

        --- Heal your pokemon
        if love.keyboard.wasPressed(KEYS.P) then
            -- self.dialogueOpened = true

            -- heal player pokemon
            -- gSounds[SOUNDS.FX.HEAL]:play()
            -- self.level.player.party.pokemon[1].currentHP = self.level.player.party.pokemon[1].HP

            -- show a dialogue for it, allowing us to do so again when closed
            -- gStateStack:push(DialogueState('Your Pokemon has been healed!',

            -- function()
            --     self.dialogueOpened = false
            -- end))

        --- Get Stats
        elseif love.keyboard.wasPressed(KEYS.S) then
            -- self.dialogueOpened = true


            ---@TODO There's a design enhancement here where we pass in the list of keys
            ---      that should be checked to close out a menu

            -- -- Open stats menu
            -- gStateStack:push(PokeStatsMenuState(self.level.player.party.pokemon[1],
            -- function()
            --     self.dialogueOpened = false
            -- end))
        end
    end

    self.level:update(dt)
end

function PlayState:render()
    self.level:render()

    if self.showCursor then
        local whiteLevel = 233
        -- love.graphics.setColor(217/255, 87/255, 99/255, 1)
        love.graphics.setColor(whiteLevel/255, whiteLevel/255, whiteLevel/255, 1)
    end

    -- draw actual cursor rect
    love.graphics.setLineWidth(1)
    love.graphics.rectangle(
        'line',
        self.cursorSelectX * TILE_SIZE,
        self.cursorSelectY * TILE_SIZE,
        16,
        16,
        1
    )
end