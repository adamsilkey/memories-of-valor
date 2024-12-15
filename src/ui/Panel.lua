--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

	Code adapted from Colton Ogden's GD50 code
]]

---@class Panel
Panel = Class{}

---@param x posX
---@param y posY
---@param width iPixels
---@param height iPixels
function Panel:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    ---@type boolean Flag to toggle if the panel is visible or not
    self.visible = true
end

function Panel:update(dt)

end

function Panel:render()
    if self.visible then
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.rectangle('fill', self.x, self.y, self.width, self.height, 3)
        love.graphics.setColor(56/255, 56/255, 56/255, 1)
        love.graphics.rectangle('fill', self.x + 1, self.y + 1, self.width - 2, self.height - 2, 3)
        love.graphics.setColor(1, 1, 1, 1)
    end
end

-- Toggles the current visible setting
function Panel:toggle()
    self.visible = not self.visible
end