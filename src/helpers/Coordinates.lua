--[[
    Memories of Valor

    -- Coordinates Class --

    Author: Adam Silkey
    ads289@g.harvard.edu

    Coordinates is a class that will hold unique Grid Coordinates
]]

---@class Coordinates: Set
Coordinates = Class{__includes = Set}

-- Private API ----------------------------------------------------------------
--[[
    Convenience function to convert the coordinate string into an X, Y pair.
]]
---@param coordinateString string
---@return integer, integer
local function convertCoordinate(coordinateString)
    -- Regex!
    -- (%d+) - match numbers, store in a capture group
    -- , -- match a comma
    -- (%d+) - match numbers, store in a capture group

    -- Discard the first two params and just get the capture group
    local _, _, x, y = string.find(coordinateString, "(%d+),(%d+)")

    -- Cast to integers
    ---@cast x +integer, -number, -nil
    x = tonumber(x)
    ---@cast y +integer, -number, -nil
    y = tonumber(y)

    --- Something's messed up about this. Just gonna disable it
    ---@diagnostic disable-next-line:return-type-mismatch
    return x, y
end

-- Public API ------------------------------------------------------------------

function Coordinates:init()
    -- Initialize the parent class
    Set.init(self)
end

--[[
    Convenience function to create a Coordinate string used internally
    as keys for our set. 78,29 becomes "78,29"
]]
---@param x integer
---@param y integer
---@return string
function Coordinates.createCoordinateString(x, y)
    return x..","..y
end

--[[
    Adds a coordinate pair into the Coordinates set. Acts like a set, so it won't
    add an extra (x, y) pair if one already exists.
]]
---@param x tileX X tile, (1-based, column)
---@param y tileY Y tile, (1-based, row)
function Coordinates:add(x, y)
    -- Convert x, y into a unique number
    local coordString = self.createCoordinateString(x, y)

    -- Store our coordString into the set, using the parent class add()
    Set.add(self, coordString)
end


---@param x posX X POS, (0-based, column)
---@param y posY Y POS, (0-based, row)
function Coordinates:find(x, y)
    local cS = self.createCoordinateString(x, y)
    if Set.find(self, cS) == true then
        return true
    else
        return false
    end
end


--[[
    Iterate over the coordinates, returning back the converted coordinate pair
    Call like so:
        for x, y in Coordinates:values() do
            blah blah x, y
        end
]]
function Coordinates:values()
    local iter, tbl, key = pairs(self)
    local value
    return function()
        local x, y
        key, value = iter(tbl, key)

        -- There's a potential here that we'll find an improper type value from
        -- our iterator: a function, a special internal variable, or even something
        -- like .len.
        -- If that's the case, we need to keep iterating until we find something proper
        -- again
        while key and (
            key == 'len' or
            string.sub(key, 1, 1) == '==' or
            type(value) == 'function'
        ) do
            key, value = iter(tbl, key)
        end

        -- Return nil if we've run out of keys
        if key == nil then
            return nil
        end
        -- Else, concatenate our coordiantes and go from there
        x, y = convertCoordinate(key)
        return x, y
    end
end
