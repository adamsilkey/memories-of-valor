---@diagnostic disable: undefined-field
--[[
    GD50

    -- SparseArray Class --

    Author: Adam Silkey
    ads289@g.harvard.edu

    Sparse Array that will let us arbitrarily add/remove items with fast lookups
    and without having to worry about table resizing happening automatically

    Design Notes:
    - Does not do any validation that a proper type has been passed in or not,
      will need to rely on the user to handle that _for now_
    - Does not prevent users from directly modifying the table and MESSING things
      up. Should probably fix that with metatables at some point
]]

---@TODO should REALLY fix allowing people to directly add to the table, as this is
---causing ALL SORTS OF GRIEF AYYYYYY


---@class SparseArray
SparseArray = Class{}

function SparseArray:init()
    local _next = 1
    local __size = 0

    self._vkmap = {}

    function self:_size() return __size end
    function self:_increaseSize() __size = __size + 1 end
    function self:_decreaseSize() __size = __size - 1 end

    function self:next() return _next end
    function self:_incrementnext() _next = _next + 1 end
end

---@return integer size Number of Elements in Sparse Array
function SparseArray:size()
    return self:_size()
end

--[[
    Add an element to the sparse array
]]
function SparseArray:add(element)
    local id = self:next()
    -- Update our index values
    self:_incrementnext()

    -- Make a two-way lookup for the elements/ids and change size
    self[id] = element
    self._vkmap[element] = id
    self:_increaseSize()
end

--[[
    Allow iteration through SparseArray
]]
function SparseArray:items()
    local iter, tbl, key = pairs(self)
    local value
    return function()
        key, value = iter(tbl, key)
        -- We don't want to return internal tables or any functions.
        -- Given that keys are handled by us, we shouldn't have an issue with this test
        while key and (string.sub(key, 1, 1) == "_" or type(value) == "function") do
            key, value = iter(tbl, key)
        end
        return value
    end
end

--[[
    Remove element from the sparse array
]]
function SparseArray:remove(element)
    if self._vkmap[element] then
        local index = self._vkmap[element]
        -- Remove from both key and value lokoups and decrease size
        self._vkmap[element] = nil
        self[index] = nil
        self._decreaseSize()
    end
end

--[[
    Remove an element by index
]]
function SparseArray:removeByIndex(index)
    if self[index] then
        local element = self[index]
        -- Remove from both key and value lokoups and decrease size
        self[index] = nil
        self._vkmap[element] = nil
        self:_decreaseSize()
    end
end