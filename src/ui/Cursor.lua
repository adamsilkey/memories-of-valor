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

    ---@type boolean Flag to determine if cursor is currently enabled or not
    self.enabled = true
    -- ---@type boolean Flag to determine if we should show the cursor or not
    -- self.visible = true

    -- ---@type boolean Flag to determine if we can click
    -- self.canInput = true

    ---@type seconds Track how long it's been since the cursor has moved from keyboard
    self.keyholdTimer = 0
    ---@type boolean Enables us to only fire one event on interaction with the cursor
    self.cursorPressed = false

    ---@type RGB cursor color
    self.color = {
        r = 233 / 255,
        g = 233 / 255,
        b = 233 / 255,
        a = 1
    }

    self.tileX = 1      ---@type tileX X position on grid
    self.tileY = 1      ---@type tileY Y position on grid

    -- self.selectedX = nil    ---@type tileX Selected X position on grid
    -- self.selectedY = nil    ---@type tileY Selected Y position on grid
end

function Cursor:update(dt)

    --- Timer that tracks the amount of time passed since a handleKeyboard()
    --- action was executed
    ---@type seconds
    self.keyholdTimer = self.keyholdTimer + dt


    if self.enabled then
        -- CURSOR MOVEMENT
        -- Keyboard controls
        self:handleKeyboard()
        -- Mouse controls
        if love.mouse.wasMoved then
            self:handleMouse()
        end

        -- CURSOR SELECTION
        -- if we've pressed enter or used the mouse...
        if not self.cursorPressed and
            (love.keyboard.wasPressed(KEYS.ENTER) or
            love.keyboard.wasPressed(KEYS.RETURN) or
            love.mouse.wasPressed(1)) then

            Event.dispatch(EVENTS.CURSOR_SELECT, self.tileX, self.tileY)
            self.cursorPressed = true
        end
        if self.cursorPressed and
            (love.keyboard.wasReleased(KEYS.ENTER) or
            love.keyboard.wasReleased(KEYS.RETURN) or
            love.mouse.wasReleased(1)) then

            self.cursorPressed = false
        end
    end

    --     local newX = self.tileX
    --     local newY = self.tileY

    --     -- if same tile as currently highlighted, deselect
    --     if newX == self.selectedX and newY == self.selectedY then
    --         self.selectedX = nil
    --         self.selectedY = nil

    --     -- Otherwise, set the new highlighted tile
    --     else
    --         self.selectedX = newX
    --         self.selectedY = newY
    --     end
    -- end
end

function Cursor:render()
    -- Render cursor if visible
    if self.enabled then

        -- Render normal select
        love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
        -- draw actual cursor rect
        love.graphics.setLineWidth(1)
        love.graphics.rectangle(
            'line',
            (self.tileX - 1) * TILE_SIZE,  --- Lua grids are one based, graphics are 0
            (self.tileY - 1) * TILE_SIZE,  --- Lua grids are one based, graphics are 0
            16,
            16,
            1
        )

        if DEBUG_MODE then
            ---@DEBUG Shows cursor stats
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.setFont(Fonts[FONTS.SMALL])

            local fontOffest = 10

            local cursorMsg = 'Cursor: ('..self.tileX..','..self.tileY..')'
            -- local selectedMsg = 'Selected: N/A'
            -- if self.selectedX ~= nil and self.selectedY ~= nil then
            --     selectedMsg  = 'Selected: ('..self.selectedX..','..self.selectedY..')'
            -- end
            local pos = 'MOUSE: [off screen]'
            if mouse.x ~= nil and mouse.y ~= nil then
                pos = 'MOUSE: ('..mouse.x..','..mouse.y..')'
            end

            local msgs = {
                pos,
                -- selectedMsg,
                cursorMsg,
            }

            for i, msg in ipairs(msgs) do
                love.graphics.printf(msg, 0, VIRTUAL_HEIGHT - fontOffest * i, VIRTUAL_WIDTH, 'left')
            end
        end
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

        local x = math.floor((mouse.x / TILE_SIZE)) + 1
        local y = math.floor((mouse.y / TILE_SIZE)) + 1

        if self.level:inbounds(x, y) then
            self.tileX, self.tileY = x, y
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
        KEYS.UP, KEYS.DOWN, KEYS.LEFT, KEYS.RIGHT,
        KEYS.W,  KEYS.S,    KEYS.A,    KEYS.D
    ) then
        self.keyholdTimer = 0
    end

    -- Only repeat the action if the keyhold timer has gone above 0
    if self.keyholdTimer >= 0 then
        if love.keyboard.isDown(KEYS.UP, KEYS.W) then
            self.tileY = math.max(0, self.tileY - 1)
            self.keyholdTimer = -DELAY_THRESHOLD
        elseif love.keyboard.isDown(KEYS.DOWN, KEYS.S) then
            self.tileY = math.min(self.level.height - 1, self.tileY + 1)
            self.keyholdTimer = -DELAY_THRESHOLD
        elseif love.keyboard.isDown(KEYS.LEFT, KEYS.A) then
            self.tileX = math.max(0, self.tileX - 1)
            self.keyholdTimer = -DELAY_THRESHOLD
        elseif love.keyboard.isDown(KEYS.RIGHT, KEYS.D) then
            self.tileX = math.min(self.level.width - 1, self.tileX + 1)
            self.keyholdTimer = -DELAY_THRESHOLD
        end

        -- If we _just_ hit a key, then let's add an extra delay, so that
        -- input feels more precise and you don't get double tap/phantom hits
        if love.keyboard.anyPressed(
            KEYS.UP, KEYS.DOWN, KEYS.LEFT, KEYS.RIGHT,
            KEYS.W,  KEYS.S,    KEYS.A,    KEYS.D
        ) then
            -- If we have JUST pressed a key, then we want to actually delay the
            -- keyhold timer a little more before starting to repeat
            self.keyholdTimer = -0.25
        end
    end
end
