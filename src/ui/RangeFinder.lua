--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

    -- Range Finder --

    The Unit Range Finder
]]

---@class RangeFinder
RangeFinder = Class{}

---@class RangeFinderDef
---@field level Level
---@field entity Entity
---@field range? integer Range override
---@field color? GFX.UI
---@field centerColor? GFX.UI   Override a special color for the center

---
--- ENTITY DEFS ----------------------------------------------------------------
---

---@type {[GFX.UI]: AnimationDef}
RangeFinder.AnimationDefs = {
    [GFX.UI.RANGE_FINDER_BLUE_50] = {
        frames = {
            1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
        },
        interval = 0.05,
        texture = GFX.UI.RANGE_FINDER_BLUE_50,
    },
    [GFX.UI.RANGE_FINDER_BLUE_FULL] = {
        frames = {
            1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
        },
        interval = 0.05,
        texture = GFX.UI.RANGE_FINDER_BLUE_FULL,
    },
    [GFX.UI.RANGE_FINDER_RED_50] = {
        frames = {
            1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
        },
        interval = 0.05,
        texture = GFX.UI.RANGE_FINDER_RED_50,
    },
    [GFX.UI.RANGE_FINDER_RED_FULL] = {
        frames = {
            1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
        },
        interval = 0.05,
        texture = GFX.UI.RANGE_FINDER_RED_FULL,
    },
}

---@param def RangeFinderDef
function RangeFinder:init(def)
    self.level = def.level
    self.entity = def.entity

    self.range = def.range or self.entity.stats.movement
    self.color = def.color or GFX.UI.RANGE_FINDER_BLUE_FULL
    self.centerColor = def.centerColor or self.color

    ---@type tileX Origin point for the range finder
    self.startX = self.entity.gridX
    ---@type tileY Origin point for the range finder
    self.startY = self.entity.gridY

    assert(self.startX ~= nil, 'startX nil')
    assert(self.startY ~= nil, 'startY nil')

    ---@type Coordinates
    self.tilesInRange = self:bfs()

    ---@type { [GFX.UI]: Animation}
    self.animations = Animation.createAnimations(RangeFinder.AnimationDefs)

    self.currentAnimation = self.animations[self.color]

    ---@TODO Remove dead code
    -- print("Letsa go")
    -- for x, y in self.pointsToHighlight:values() do
    --     print(Vector.cString(x, y))
    -- end
end

function RangeFinder:update(dt)
    self.currentAnimation:update(dt)
end

function RangeFinder:render()
    --- Render the range finder grid
    for tileX, tileY in self.tilesInRange:values() do
        self:drawTile(tileX, tileY)
    end

    --- Re draw the center tile in case the color has been overriden
    self:drawTile(self.startX, self.startY, self.centerColor)
end

---@param tileX tileX
---@param tileY tileY
---@param color? GFX.UI
function RangeFinder:drawTile(tileX, tileY, color)
    -- Get color if overridden
    color = color or self.currentAnimation.name
    -- Convert x, y to POS
    local x, y = (tileX - 1) * TILE_SIZE, (tileY - 1) * TILE_SIZE
    love.graphics.draw( -- drawable,x,y,r,sx,sy,ox,oy
        Textures[color],
        Frames[color][self.currentAnimation:getCurrentFrame()],
        x,
        y
    )
end

---comment
---@return Coordinates coordinatesTohighlight
function RangeFinder:bfs()
    ---@type Deque
    local deque = Deque()
    deque:append({self.startX, self.startY})

    ---@type Coordinates
    local visited = Coordinates()

    ---@type Coordinates
    local seen = Coordinates()

    ---@type table<string, integer>
    local distances = {}

    --- This is a hack because I don'tk now how to do this easily in lua
    distances[Vector.cString(self.startX, self.startY)] = 0

    while deque:length() > 0 do
        local point = deque:popLeft()
        ---@type Vector
        point = Vector(point[1], point[2])
        -- print('adding '.. Vector.cString(point.x, point.y))
        visited:add(point.x, point.y)
        if not visited:find(point.x, point.y) then
            print('EXCUSE ME?!')
            assert()
        end

        ---@type integer
        local currentDistance = distances[Vector.cString(point.x, point.y)]
        local nextDistance = currentDistance + 1
        ---@TODO Pretty sure there's a bug here
        -- print(Vector.cString(point.x, point.y)..", CurrentDistance: "..currentDistance)

        for direction, vec in pairs(Vector.COMPASS) do
            local nx, ny = point:check(direction)
            -- local dx, dy, manhattanDistance = Vector.checkDistance(point.x, point.y, nx, ny)

            -- If found in seen, keep going. We use GOTO Here because Lua doesn't have a
            -- continue statement
            if seen:find(nx, ny) then
                goto continue
            end

            -- Add to seen
            assert(nx ~= nil, 'nx nil, point.x '..point.x)
            assert(ny ~= nil, 'ny nil, point.y '..point.y)
            seen:add(nx, ny)

            ---@TODO this is where we would add checking for obstacles
            if self.level:inbounds(nx, ny) and self.level:isPassable(nx, ny) then
                --- Add to our distances map
                distances[Vector.cString(nx, ny)] = nextDistance

                --- This is where we would add a check to find out if we are hitting an obstacle
                if nextDistance <= self.range and not visited:find(nx, ny) then
                    -- Where are we going next?
                    deque:append({nx, ny})
                end
            end
            ::continue::
        end
    end

    -- print('in bfs')
    -- for x, y in visited:values() do
    --     print(x, y)
    --     -- print(Vector.cString(x, y))
    -- end
    -- print('this is what we found')

    --- Finally at the end of this, update our points
    return visited
end