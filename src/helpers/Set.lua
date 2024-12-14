--[[
    Memories of Valor

    -- Set Class --

    Author: Adam Silkey
    ads289@g.harvard.edu

    Set class that provides set-like functionality (like in Python)

    Under the hood, we're using the hash table and adding convenience
    functions. Basically - we can only have one of each key inside the set.

    This is a barebones implementation created for the specific needs
    of this problem set. We're not looking to implement all the standard
    functions of a set here.

    Features:
    - Tracks length of the set from an internal variable, protected by a closure
    - Add an item to a set
    - Discard an item from a set
    - find -- checks if an element exists inside a set
    - Adds a custom iterator that returns all the keys to the set
      (as opposed to using pairs())
]]

---@class Set
Set = Class{}

function Set:init()
    -- _len is the internal counter of the current 'length' of the set
    local _len = 0

    function self:len()
        return _len
    end

    function self:_incrementLen()
        _len = _len + 1
    end

    function self:_decrementLen()
        _len = _len - 1
    end
end

--[[
    Add an element to a set
]]
function Set:add(element)
    if not self[element] then
        self[element] = true
        ---@diagnostic disable-next-line: undefined-field
        self:_incrementLen()
    end
end

--[[
    Discard an element from a set if it's present

    Does not raise an error if the element doesn't exist
]]
function Set:discard(element)
    if self[element] == true then
        self[element] = nil
        ---@diagnostic disable-next-line: undefined-field
        self:_decrementLen()
    end
end

--[[
    Checks if an element is in a set

    Returns true if element is present, otherwise returns false
]]
function Set:find(element)
    if self[element] == true then
        return true
    else
        return false
    end
end

--[[
    Returns each element in the set
]]
function Set:keys()
    local key, _
    local selfSet = self -- Capture self in a local variable
    return function()
        repeat
            key, _ = next(selfSet, key)
        -- By using the until clause, we are only going to return
        -- types that are a boolean (those which have been added by Set:add())
        until key == nil or type(selfSet[key]) == "boolean"
        return key
    end
end
