--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

	StateMachine adapted from Colton Ogden's GD50 code
]]

---@class StateStack
StateStack = Class{}

function StateStack:init()
    ---@type State[]
    self.states = {}
end

function StateStack:update(dt)
    self.states[#self.states]:update(dt)
end

-- function StateStack:processAI(params, dt)
--     ---@diagnostic disable-next-line: param-type-mismatch
--     self.states[#self.states]:processAI(params, dt)
-- end

function StateStack:render()
    for i, state in ipairs(self.states) do
        state:render()
    end
end

function StateStack:clear()
    self.states = {}
end

---@return State
function StateStack:top()
    return self.states[#self.states]
end

function StateStack:push(state)
    table.insert(self.states, state)
    state:enter()
end

function StateStack:pop()
    -- self.states[#self.states]:exit()
    self:top():exit()
    table.remove(self.states)
end