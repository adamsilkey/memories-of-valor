--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

    -- Vector --

    Point / Vector class - handles common operations related to points

    Adapted largely from my AOC Point class. Leaving the intercardinal points,
    though we don't use them in this project
]]

---@class Vector
Vector = Class{}

---@param x number
---@param y number
function Vector:init(x, y)
    self.x = x
    self.y = y
end

---@enum Vector.DIRS
Vector.DIRS = {
    -- NW = 'NW',
    N = 'N',
    -- NE = 'NE',
    W = 'W',
    E = 'E',
    -- SW = 'SW',
    S = 'S',
    -- SE = 'SE',
}

Vector.COMPASS = {
    -- NW = {-1, -1},
    N = {0, -1},
    -- NE = {1, -1},
    W = {-1, 0},
    E = {1, 0},
    -- SW = {-1, 1},
    S = {0, 1},
    -- SE = {1, 1},
}

--[[
    Go from an x, y to a LRUD DIRS
]]
---comment
---@param x integer
---@param y integer
---@return DIRS
function Vector.transformToLRUD(x, y)
    if x == 0 and y == -1 then
        return DIRS.UP
    elseif x == -1 and y == 0 then
        return DIRS.LEFT
    elseif x == 1 and y == 0 then
        return DIRS.RIGHT
    else -- x == 0, y == 1
        return DIRS.DOWN
    end
end

--[[
    Coordinate string, similar to what is used by Coordinates()
]]
---@param x number
---@param y number
---@return string coordinateString
function Vector.cString(x, y)
    return x..","..y
end

--[[
    Moves the Vector
]]
---@param d Vector.DIRS
---@return number newX
---@return number newY
function Vector:move(d)
    assert(Vector.DIRS[d] ~= nil, 'Improper direciton passed in: '..d)

    local change = Vector.COMPASS[d]
    local dx, dy = change[1], change[2]

    self.x, self.y = self.x + dx, self.y + dy

    return self.x, self.y
end

--[[
    Checks what the changed Vector would be
]]
---@param d Vector.DIRS
---@return number lookX
---@return number lookY
function Vector:check(d)
    assert(Vector.DIRS[d] ~= nil, 'Improper direciton passed in: '..d)

    local change = Vector.COMPASS[d]
    local dx, dy = change[1] + self.x, change[2] + self.y

    return dx, dy
end


--[[
    Gets a handful of useful values from two points
]]
---@param x1 integer
---@param y1 integer
---@param x2 integer
---@param y2 integer
---@return integer dx
---@return integer dy
---@return integer manhattanDistance
function Vector.checkDistance(x1, y1, x2, y2)
    local dx = x2 - x1
    local dy = y2 - y1
    local manhattanDistance = math.abs(dx) + math.abs(dy)

    return dx, dy, manhattanDistance
end