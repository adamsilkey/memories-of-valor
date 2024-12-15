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
    -- Set offsets and scale factors
    local x = math.floor(self.entity.x - self.entity.offsetX)
    local y = math.floor(self.entity.y - self.entity.offsetY)
    local sx = 1
    local sy = 1

    -- Draw Animation --- Reverse the sprite if anim.reverse
    love.graphics.draw(
        Textures[anim.texture],
        Frames[anim.texture][anim:getCurrentFrame()],
        x + (anim.reverse and self.entity.width or 0),
        y,
        0,
        sx * (anim.reverse and -1 or 1),
        sy
    )
    if DEBUG_MODE then
        ---@DEBUG For showing the boundary of the graphics
        love.graphics.setColor(255, 0, 255, 255)
        love.graphics.rectangle(
            'line',
            x,
            y,
            self.entity.width,
            self.entity.height
        )
        love.graphics.setColor(255, 255, 255, 255)

        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setFont(Fonts[FONTS.SMALL])
        local fontOffest = 10

        local entityGridMsg = 'Grid: ('..self.entity.gridX..','..self.entity.gridY..')'
        local entityPosMsg = 'POS: ('..x..','..y..')'

        local msgs = {entityPosMsg, entityGridMsg}

        for i, msg in ipairs(msgs) do
            love.graphics.printf(msg, 0, VIRTUAL_HEIGHT - fontOffest * i, VIRTUAL_WIDTH, 'center')
        end
    end
end