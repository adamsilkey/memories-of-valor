--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

    Strategy RPG Game, made for GD50 Final Project
]]

require "src/Dependencies"

function love.load()
    math.randomseed(os.time())
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Memories of Valor')

    push:setupScreen(
        VIRTUAL_WIDTH,
        VIRTUAL_HEIGHT,
        WINDOW_WIDTH,
        WINDOW_HEIGHT,
        {
            fullscreen = false,
            vsync = true,
            resizable = true,
        }
    )

    -- this time, we are using a stack for all of our states, where the field state is the
    -- foundational state; it will have its behavior preserved between state changes because
    -- it is essentially being placed "behind" other running states as needed (like the battle
    -- state)

    ---@type StateStack
    StateStack = StateStack()
    StateStack:push(StartState())

    ---@type {[KEYS]: true}
    love.keyboard.keysPressed = {}
end

---@diagnostic disable-next-line: duplicate-set-field
function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == KEYS.ESCAPE then
        ---@TODO gonna want to implement the state stack stuff here
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed(key)
end

function love.update(dt)
    Timer.update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()

    push:finish()
end