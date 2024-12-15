--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

	Code adapted from Colton Ogden's GD50 code
]]

---@class Entity
Entity = Class{}

---@param def EntityDef
---@param gridX tileX
---@param gridY tileY
function Entity:init(def, gridX, gridY)

    self.name = def.name
    self.type = def.type

    ---@type boolean Flag that determines if the entity should respond to user input
    self.controllable = false

    -- One of the four cardinal directions (UDLR / NSEW)
    ---@type DIRS
    self.direction = DIRS.DOWN

    self.animations = Animation.createAnimations(def.animations)

    ---@type Animation
    self.currentAnimation = nil

    -- Entity stats
    self.stats = def.stats

    -- Entity walk speed
    self.walkSpeed = def.walkSpeed

    -- Entity Dimensions

    self.gridX = gridX          ---@type tileX
    self.gridY = gridY          ---@type tileY
    self.width = ACTOR_SIZE     ---@type iPixels
    self.height = ACTOR_SIZE    ---@type iPixels

    self.x = 0          ---@type pixels
    self.y = 0          ---@type pixels
    self.offsetX = TILE_SIZE - math.floor(TILE_SIZE / 2)    ---@type pixels
    self.offsetY = math.floor(TILE_SIZE / 2)                ---@type pixels
    --- This will put the character in the center of the tile

    -- Change the rendering to be based on pixel
    self:tileToPixel()

    --- Entity State Machine
    ---@type StateMachine
    self.stateMachine = nil
    -- Adam Notes: We initialize nil statemachine to aid autocomplete/code diagnostics

    -- Timer for turning transparency on and off, flashing
    ---@type seconds
    self.flashTimer = 0

    -- Flag for declaring if an entity is dead or not
    ---@type boolean
    self.dead = false

    -- onDeath callback, default empty
    ---@type function
    self.onDeath = function() end
end

--[[
    Change active Animation
]]
---@param name string
function Entity:changeAnimation(name)
    self.currentAnimation = self.animations[name]
end

function Entity:update(dt)

    self.stateMachine:update(dt)

    if self.currentAnimation then
        self.currentAnimation:update(dt)
    end
end

-- function Entity:processAI(params, dt)
--     self.stateMachine:processAI(params, dt)
-- end

function Entity:render(adjacentOffsetX, adjacentOffsetY)

    love.graphics.setColor(1, 1, 1, 1)
    self.x, self.y = self.x + (adjacentOffsetX or 0), self.y + (adjacentOffsetY or 0)
    self.stateMachine:render()
end

--[[
    Change active Entity state
]]
---@param name STATES
---@param params? table Table of optional state parameters
function Entity:changeState(name, params)
    self.stateMachine:change(name, params)
end



--- UTILITY ----

function Entity:tileToPixel()
    -- Get x and y
    local x, y = (self.gridX - 1) * TILE_SIZE, (self.gridY - 1) * TILE_SIZE

    -- Offset the x and y based on the sprite (which is centered in the bottom)
    self.x = x
    self.y = y
end