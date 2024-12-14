--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

    -- Cursor --

    The Map Selection Cursor
]]

---@class Cursor
Cursor = Class{}

---@param level Level Reference to the current level
function Cursor:init(level)
    -- Reference to current Level()
    self.level = level

    ---@type boolean Flag to determine if we should show the cursor or not
    self.visible = true

    ---@type seconds Track how long it's been since the cursor has moved from keyboard
    self.keyholdTimer = 0

    ---@type RGB cursor color
    self.color = {
        r = 233 / 255,
        g = 233 / 255,
        b = 233 / 255,
        a = 1
    }

    self.tileX = 0      ---@type tileX X position on grid
    self.tileY = 0      ---@type tileY Y position on grid
end

function Cursor:update(dt)

    --- Timer that tracks the amount of time passed since a handleKeyboard()
    --- action was executed
    ---@type seconds
    self.keyholdTimer = self.keyholdTimer + dt

    -- Keyboard controls
    self:handleKeyboard()

    -- Mouse controls
    if love.mouse.wasMoved then
        self:handleMouse()
    end
end

function Cursor:render()
    if self.visible then
        love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
        -- draw actual cursor rect
        love.graphics.setLineWidth(1)
        love.graphics.rectangle(
            'line',
            self.tileX * TILE_SIZE,
            self.tileY * TILE_SIZE,
            16,
            16,
            1
        )
    end

    if DEBUG_MODE then
        ---@DEBUG Shows cursor stats
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setFont(Fonts[FONTS.SMALL])
        love.graphics.printf('Cursor: ('..self.tileX..','..self.tileY..')', 0, VIRTUAL_HEIGHT - 20, VIRTUAL_WIDTH, 'left')

        local pos = 'MOUSE: [off screen]'
        if mouse.x ~= nil and mouse.y ~= nil then
            pos = 'MOUSE: ('..mouse.x..','..mouse.y..')'
        end
        love.graphics.printf(pos, 0, VIRTUAL_HEIGHT - 10, VIRTUAL_WIDTH, 'left')
    end
end

--[[
    Convert mouse coordinates into Level.gridX/Level.gridY
]]
---comment
---@return tileX | nil
---@return tileY | nil
function Cursor:handleMouse()
    -- Algorithm reverses Colton's rendering algorithm:
    -- 1. Divide by 16 (tile width/ height)
    -- 2. Add one, which is an offset

    if mouse.x ~= nil and mouse.y ~= nil then
        -- The offsets look funny here, but Lua is generally 1-based

        local x = math.floor((mouse.x / TILE_SIZE) + 1)
        local y = math.floor((mouse.y / TILE_SIZE) + 1)

        if self.level:inbounds(x, y) then
            self.tileX, self.tileY = x - 1, y - 1
        end
    end
end

--[[
    Hanldes keyboard input and gracefully handling delays / repeated input
]]
function Cursor:handleKeyboard()

    ---@type seconds Threshhold between moving the cursor
    local DELAY_THRESHOLD = 0.05

    -- If we released a key, can reset the keyholdTimer to allow for players
    -- to quickly go back and forth
    if love.keyboard.anyReleased(
        KEYS.UP, KEYS.DOWN, KEYS.LEFT, KEYS.RIGHT
    ) then
        self.keyholdTimer = 0
    end

    -- Only repeat the action if the keyhold timer has gone above 0
    if self.keyholdTimer >= 0 then
        if love.keyboard.isDown(KEYS.UP) then
            self.tileY = math.max(0, self.tileY - 1)
            self.keyholdTimer = -DELAY_THRESHOLD
        elseif love.keyboard.isDown(KEYS.DOWN) then
            self.tileY = math.min(self.level.height - 1, self.tileY + 1)
            self.keyholdTimer = -DELAY_THRESHOLD
        elseif love.keyboard.isDown(KEYS.LEFT) then
            self.tileX = math.max(0, self.tileX - 1)
            self.keyholdTimer = -DELAY_THRESHOLD
        elseif love.keyboard.isDown(KEYS.RIGHT) then
            self.tileX = math.min(self.level.width - 1, self.tileX + 1)
            self.keyholdTimer = -DELAY_THRESHOLD
        end

        -- If we _just_ hit a key, then let's add an extra delay, so that
        -- input feels more precise and you don't get double tap/phantom hits
        if love.keyboard.anyPressed(
            KEYS.UP, KEYS.DOWN, KEYS.LEFT, KEYS.RIGHT
        ) then
            -- If we have JUST pressed a key, then we want to actually delay the
            -- keyhold timer a little more before starting to repeat
            self.keyholdTimer = -0.25
        end
    end
end