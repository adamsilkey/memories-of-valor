--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

    Strategy RPG Game, made for GD50 Final Project
]]

require "src/Dependencies"

function love.load()
    print("Hello?")
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
    -- StateStack:push(StartState())

    ---@DEBUG Just setting our start state to PlayState(), so we don't have to have the transition each time
    ---@DEBUG Besure to reset this
    StateStack:push(PlayState())

    -- Initialize all input tables

    ---@type {[KEYS]: true} Tracks which keys have been pressed
    love.keyboard.keysPressed = {}

    ---@type {[KEYS]: true} Tracks which keys have been released
    love.keyboard.keysReleased = {}

    love.mouse.buttonPressed = {}

    ---@type boolean Tracks whether the mouse has been moved
    love.mouse.wasMoved = false

    mouse = {}
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
    return love.keyboard.keysPressed[key]
end

--[[
    Special function that returns if any one of an array of keys was pressed
]]
function love.keyboard.anyPressed(...)
    for i, key in ipairs({...}) do
        if love.keyboard.keysPressed[key] then
            return true
        end
    end

    return false
end

-- Callback function for setting keysReleased
function love.keyreleased(key)
    love.keyboard.keysReleased[key] = true
end

--[[
    Special function that returns if any one of an array of keys was pressed
]]
function love.keyboard.anyReleased(...)
    for i, key in ipairs({...}) do
        if love.keyboard.keysReleased[key] then
            return true
        end
    end

    return false
end

-- Callback function for detecting mouse moves
function love.mousemoved(x, y, dx, dy, istouch)
    love.mouse.wasMoved = true
end

-- Callback function for detecting mouse presses
function love.mousepressed(x, y, button)
    ---@TODO could probably have this tfack the location that the mopuse was pressed

    love.mouse.buttonPressed[button] = true
end

function love.mouse.wasPressed(button)
    if love.mouse.buttonPressed[button] then
        return true
    else
        return false
    end
end


function love.update(dt)

    -- Track mouse changes
    local x, y = love.mouse.getPosition()
    mouse.x, mouse.y = push:toGame(x, y)

    Timer.update(dt)
    StateStack:update(dt)

    -- Reset all input tables/flags
    love.keyboard.keysPressed = {}
    love.keyboard.keysReleased = {}
    love.mouse.buttonPressed = {}
    love.mouse.wasMoved = false
end

function love.draw()
    push:start()
    StateStack:render()
    push:finish()
end