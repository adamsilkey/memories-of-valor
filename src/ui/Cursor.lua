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
    -- Move cursor around
    if love.keyboard.wasPressed(KEYS.UP) then
        self.tileY = math.max(0, self.tileY - 1)
    elseif love.keyboard.wasPressed(KEYS.DOWN) then
        self.tileY = math.min(self.level.height - 1, self.tileY + 1)
    elseif love.keyboard.wasPressed(KEYS.LEFT) then
        self.tileX = math.max(0, self.tileX - 1)
    elseif love.keyboard.wasPressed(KEYS.RIGHT) then
        self.tileX = math.min(self.level.width - 1, self.tileX + 1)
    end

    -- Mouse controls
    if love.mouse.wasMoved then
        self:updateTileFromMouse()
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
end

--[[
    Convert mouse coordinates into Level.gridX/Level.gridY
]]
---comment
---@return tileX | nil
---@return tileY | nil
function Cursor:updateTileFromMouse()
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
