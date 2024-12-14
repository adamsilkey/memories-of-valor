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
    -- ---@type Level
    -- self.level = Level()

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

    -- self.level:update(dt)
end

function PlayState:render()
    -- self.level:render()
end