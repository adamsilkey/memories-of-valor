--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

    -- Deque --

    Deque - Double Ended Queue

    This is a barebones implementation of a Deque with no real
    convenience functions. All it does is provide us with a deque
    for the purposes of our BFS
]]

---@class Deque
Deque = Class{}

function Deque:init()
    self.left = 1
    self.right = 0
end

---@return integer
function Deque:length()
    return self.right - self.left + 1
end

function Deque:left()
    return self[self.left]
end

function Deque:right()
    return self[self.right]
end

function Deque:pushLeft(value)
    self.left = self.left - 1
    self[self.left] = value
end

function Deque:append(value)
    self.right = self.right + 1
    self[self.right] = value
end

function Deque:popLeft()
    if self:length() > 0 then
        local value = self[self.left]
        self[self.left] = nil
        self.left = self.left + 1
        return value
    end
end

function Deque:pop()
    if self:length() > 0 then
        local value = self[self.right]
        self[self.right] = nil
        self.right = self.right - 1
        return value
    end
end