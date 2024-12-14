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
    -- love.graphics.draw(gTextures['background'], 0, 0, 0,
    --     VIRTUAL_WIDTH / gTextures['background']:getWidth(),
    --     VIRTUAL_HEIGHT / gTextures['background']:getHeight())

    -- -- love.graphics.setFont(gFonts['gothic-medium'])
    -- -- love.graphics.printf('Legend of', 0, VIRTUAL_HEIGHT / 2 - 32, VIRTUAL_WIDTH, 'center')

    -- -- love.graphics.setFont(gFonts['gothic-large'])
    -- -- love.graphics.printf('50', 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')

    -- love.graphics.setFont(gFonts['zelda'])
    -- love.graphics.setColor(34/255, 34/255, 34/255, 1)
    -- love.graphics.printf('Legend of 50', 2, VIRTUAL_HEIGHT / 2 - 30, VIRTUAL_WIDTH, 'center')

    -- love.graphics.setColor(175/255, 53/255, 42/255, 1)
    -- love.graphics.printf('Legend of 50', 0, VIRTUAL_HEIGHT / 2 - 32, VIRTUAL_WIDTH, 'center')

    -- love.graphics.setColor(1, 1, 1, 1)
    -- love.graphics.setFont(gFonts['zelda-small'])
    -- love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 64, VIRTUAL_WIDTH, 'center')
end
