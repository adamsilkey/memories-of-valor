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

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT)

    love.keyboard.keysPressed = {}
end

---@diagnostic disable-next-line: duplicate-set-field
function push.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed = {}
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed(key)
end

function love.update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()

    push:finish()
end