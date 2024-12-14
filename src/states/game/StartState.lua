--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

    Strategy RPG Game, made for GD50 Final Project

	Code adapted from Colton Ogden's GD50 code
]]

---@class StartState: BaseState
StartState = Class{__includes = BaseState}

StartState.NAME = 'Start'

function StartState:update(dt)
    if love.keyboard.wasPressed(KEYS.ESCAPE) then
        love.event.quit()
    end

    -- if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
    --     gStateMachine:change('play')
    -- end
end

function StartState:render()
    -- love.graphics.draw(Textures[GFX.BACKGROUNDS.TITLE], 0, 0, 0)

    love.graphics.draw(Textures[GFX.BACKGROUNDS.TITLE], 0, 0, 0,
        VIRTUAL_WIDTH / Textures[GFX.BACKGROUNDS.TITLE]:getWidth(),
        VIRTUAL_HEIGHT / Textures[GFX.BACKGROUNDS.TITLE]:getHeight())

    -- -- love.graphics.setFont(gFonts['gothic-medium'])
    -- -- love.graphics.printf('Legend of', 0, VIRTUAL_HEIGHT / 2 - 32, VIRTUAL_WIDTH, 'center')

    -- -- love.graphics.setFont(gFonts['gothic-large'])
    -- -- love.graphics.printf('50', 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')

    --- Black Background, offset
    love.graphics.setFont(Fonts[FONTS.TITLE])
    love.graphics.setColor(34/255, 34/255, 34/255, 1)
    love.graphics.printf('Memories of Valor', 2, VIRTUAL_HEIGHT / 2 + 20, VIRTUAL_WIDTH, 'center')

    --- Main Color
    local r = 51
    local g = 133
    local b = 180

    love.graphics.setColor(r/255, g/255, b/255, 1)
    love.graphics.printf('Memories of Valor', 0, VIRTUAL_HEIGHT / 2 + 22, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(Fonts[FONTS.TITLE_SMALL])
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 64, VIRTUAL_WIDTH, 'center')
end
