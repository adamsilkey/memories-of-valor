--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

    -- EntityAutoWalkState --

    This will enable an entity to automatically walk to a spot
]]

--[[
    WOW!!!!! There's a lot to cover here.

    Part of games like Shining Force and Fire Emblem are enemies who move
    automatically from spot to spot, pathfinding around various things.

    There's probably a ton of ways to do this, but here's how I did it:

    1. Keep track of your origin point
    2. Use Pathfinding to find a path to your destination
    3. Build up that path -- from that path, we will construct a series of
       steps with all the information that we need.

       For each step:
       - Direction to be walking
       - Coordinate to move to

       0 1 2 3
       1 S
       2
       3     T

       A path might look something like this:

       0 1 2 3
       1 S
       2 |
       3 L _ T

       So going the steps would be:
       1. Down - (1,2)
       2. Down - (1,3)
       3. Right - (2,3)
       4. Right - (3,3)

    4. Construct a series of Timers in a loop
       - Each timer will begin at an offest time equal to
         (Step Number - 1) * ENTITY_WALK_SPEED
       - This ensures that we hae a cascading series of Timer Moves

       1. does stuf...
          2. does stuff after a little bit...
             3. does stuff after even longer...
                4. finally does stuff after even longer...

       - This allows all the animations to be smoothed
    5. At the very end, we will reset the gridX, gridY of the entity
       and have them face south once more
]]

---@class EntityAutoWalkState: EntityBaseState
EntityAutoWalkState = Class{__includes = EntityBaseState}

EntityAutoWalkState.NAME = 'EntityAutoWalkState'


---@class EntityAutoWalkStateDefs
---@field toX tileX
---@field toY tileY

---@class EntityAutoWalkStepDefs
---@field d DIRS
---@field toX tileX
---@field toY tileY

---@param entity Entity
---@param level Level
function EntityAutoWalkState:init(entity, level)
    self.entity = entity
    self.level = level
end

---@param params EntityAutoWalkStateDefs
function EntityAutoWalkState:enter(params)
    self:autoMove(params.toX, params.toY)
end

--- Builds the automove list and then executes a series of timers
---@param endX tileX Ending tileX
---@param endY tileY Ending tileY
function EntityAutoWalkState:autoMove(endX, endY)
    -- print("Enterings autoMove")
    local startX, startY = self.entity.gridX, self.entity.gridY
    -- print(startX, startY, endX, endY)
    local path = self.level.pathfinder:getPath(startX, startY, endX, endY)

    local currentX, currentY = startX, startY
    local d

    --- Build up all our instructions all at the same time
    local autoMovePath = {}
    if path then
        if Game.DEBUG_MODE then print('Path Found') end
        for node, count in path:nodes() do
            local toX, toY = node:getX(), node:getY()
            if Game.DEBUG_MODE then print(('Step: %d - (%d,%d)'):format(count, toX, toY)) end

            -- Skip over the first one, which is the tile we are currently standing on
            if count > 1 then

                -- Get the appropriate direction
                d = self:getNextDirection(currentX, currentY, toX, toY)
                -- print('d: '..d)

                local def = {
                    d = d,
                    toX = toX,
                    toY = toY,
                }

                table.insert(autoMovePath, def)
                currentX, currentY = toX, toY
            end
        end

        self:createTimers(autoMovePath, endX, endY)
    end
end

--[[
    Creates all of the Timers used to execute an AutoWalk
]]
---@param autoMovePath EntityAutoWalkStepDefs[]
---@param endX tileX
---@param endY tileY
function EntityAutoWalkState:createTimers(autoMovePath, endX, endY)
    --- Create timers for each individual step
    for i, def in ipairs(autoMovePath) do
        self:doTheWalk(i, def)
    end

    --- Create the 'final' timer, which will ensure we land up where we
    --- need to be with a facing
    Timer.after(#autoMovePath * ENTITY_MOVE_TIME, function()
        -- Revert to Idle State
        self.entity.direction = DIRS.DOWN
        self.entity:changeState(STATES.ENTITY_IDLE)
        self.entity.gridX = endX
        self.entity.gridY = endY
    end)
end

--- Creates a timer based on a passed in step number and series of defs
---@param step integer
---@param def table
function EntityAutoWalkState:doTheWalk(step, def)
    local d = def.d
    local toX = def.toX
    local toY = def.toY

    -- Wait for your turn....
    Timer.after(ENTITY_MOVE_TIME * (step - 1), function()
        -- Change facing
        local facing = ANIMATIONS.WALK_BASE .. tostring(d)
        -- print("facing::: ".. facing)
        self.entity:changeAnimation(facing)
        -- Perform the walk
        Timer.tween(ENTITY_MOVE_TIME, {
            [self.entity] = {
                x = math.floor((toX - 1) * TILE_SIZE),
                y = math.floor((toY - 1) * TILE_SIZE),
            }
        })
    end)
end

---@param startX tileX
---@param startY tileY
---@param nextX tileX
---@param nextY tileY
---@return Vector.DIRS
function EntityAutoWalkState:getNextDirection(startX, startY, nextX, nextY)
    return Vector.transformToLRUD(nextX - startX, nextY - startY)
end