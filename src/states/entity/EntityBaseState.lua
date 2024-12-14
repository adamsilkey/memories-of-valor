--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

	Code adapted from Colton Ogden's GD50 code
]]

---@class EntityBaseState
EntityBaseState = Class{}

EntityBaseState.NAME = 'EntityBaseState'

---@param entity Entity
function EntityBaseState:init(entity)
    self.entity = entity
end

function EntityBaseState:update(dt) end
function EntityBaseState:enter() end
function EntityBaseState:exit() end
function EntityBaseState:processAI(params, dt) end

function EntityBaseState:render()
    -- alias to current animation
    local anim = self.entity.currentAnimation
    -- Set offsets
    local x = math.floor(self.entity.x - self.entity.offsetX)
    local y = math.floor(self.entity.y - self.entity.offsetY)

    -- Draw Animation
    love.graphics.draw(
        Textures[anim.texture],
        Frames[anim.texture][anim:getCurrentFrame()],
        x,
        y
    )
    ---@DEBUG For showing the boundary of the graphics
    love.graphics.setColor(255, 0, 255, 255)
    love.graphics.rectangle('line', x, y, self.entity.width, self.entity.height)
    love.graphics.setColor(255, 255, 255, 255)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(Fonts[FONTS.TITLE_SMALL])
    love.graphics.printf('Grid: ('..self.entity.gridX..','..self.entity.gridY..')', 0, VIRTUAL_HEIGHT / 2 + 64, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('POS: ('..x..','..y..')', 0, VIRTUAL_HEIGHT / 2 + 80, VIRTUAL_WIDTH, 'center')
end