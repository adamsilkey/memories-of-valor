---@diagnostic disable: redundant-parameter
--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

    Strategy RPG Game, made for GD50 Final Project

	StateMachine adapted from Colton Ogden's GD50 code
]]

---@class StateMachine
StateMachine = Class{}

---@alias StateCallbacks {[string]: function}

---@param states StateCallbacks Dictionary of State Callbacks to be loaded into the StateMachine()
function StateMachine:init(states)
	---@type BaseState Default empty state
	self.empty = BaseState()

	-- Dictionary of loaded States
	-- [name] -> [callback function that returns said state]
	---@type StateCallbacks
	self.states = states or {}

	---@type State Currently active state

	---@type State
	self.current = self.empty
end

---@param stateName STATES Registered State Name
---@param enterParams? table Table of Parameters
function StateMachine:change(stateName, enterParams)
	assert(self.states[stateName]) -- state must exist!
	self.current:exit()
	self.current = self.states[stateName]()
	self.current:enter(enterParams)
end

function StateMachine:update(dt)
	self.current:update(dt)
end

function StateMachine:render()
	self.current:render()
end

-- --[[
-- 	Used for states that can be controlled by the AI to influence update logic.
-- ]]
-- function StateMachine:processAI(params, dt)
-- 	---@diagnostic disable-next-line: param-type-mismatch
-- 	self.current:processAI(params, dt)
-- end
