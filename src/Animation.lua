--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

	Code adapted from Colton Ogden's GD50 code
]]

---@class Animation
Animation = Class{}

---
--- ENUMS ----------------------------------------------------------------------
---

---@enum ANIMATIONS
ANIMATIONS = {
    IDLE_BASE = 'idle-',
    IDLE_UP = 'idle-up',
    IDLE_DOWN = 'idle-down',
    IDLE_LEFT = 'idle-left',
    IDLE_RIGHT = 'idle-right',

    WALK_BASE = 'walk-',
    WALK_UP = 'walk-up',
    WALK_DOWN = 'walk-down',
    WALK_LEFT = 'walk-left',
    WALK_RIGHT = 'walk-right',

    ATTACK_BASE = 'attack-',
    ATTACK_UP = 'attack-up',
    ATTACK_DOWN = 'attack-down',
    ATTACK_LEFT = 'attack-left',
    ATTACK_RIGHT= 'attack-right',

    DIE_BASE = 'die-',
    DIE_UP = 'die-up',
    DIE_DOWN = 'die-down',
    DIE_LEFT = 'die-left',
    DIE_RIGHT = 'die-right',
}

---@class AnimationDef
---@field frames frame[]
---@field interval seconds
---@field texture string
---@field reverse? boolean
---@field looping? boolean

--[[
    Create a list of animations based on a series of AnimationDefs
]]
---@param defs {[ANIMATIONS]: AnimationDef}
---@return {[ANIMATIONS]: Animation} animations Dictionary of Animation()
function Animation.createAnimations(defs)
    ---@type Animation[]
    local animations = {}

    for name, def in pairs(defs) do
        animations[name] = Animation (name, {
            texture = def.texture,
            frames = def.frames,
            interval = def.interval,
            reverse = def.reverse,
            looping = def.looping,
        })
    end

    return animations
end

---@param name ANIMATIONS | GFX.UI
---@param def AnimationDef
function Animation:init(name, def)
    -- Name of Animation. Handy to refer to
    self.name = name
    -- Array of frame IDs (Quads)
    self.frames = def.frames
    -- Interval between animation frames, in seconds
    self.interval = def.interval
    -- Name of texture, for lookup in textures
    self.texture = def.texture
    -- Flag to determine if animation should be reversed or not, defaults to false
    self.reverse = def.reverse
    if self.reverse == nil then
        self.reverse = false
    end
    -- Flag to determine if animation should loop or not, defaults to true
    self.looping = def.looping
    if self.looping == nil then
        self.looping = true
    end

    -- Timer in seconds
    ---@type seconds
    self.timer = 0
    -- Current frame ID (Quad)
    ---@type frame
    self.currentFrame = 1

    -- Number of times we've looped an animation
    ---@type integer
    self.timesPlayed = 0
end

--[[
    Reset the animation to the start
]]
function Animation:refresh()
    self.timer = 0
    self.currentFrame = 1
    self.timesPlayed = 0
end

function Animation:update(dt)
    -- if not a looping animation and we've played at least once, exit
    if not self.looping and self.timesPlayed > 0 then
        return
    end

    -- no need to update if animation is only one frame
    if #self.frames > 1 then
        self.timer = self.timer + dt

        if self.timer > self.interval then
            self.timer = self.timer % self.interval

            self.currentFrame = math.max(1, (self.currentFrame + 1) % (#self.frames + 1))

            -- if we've looped back to the beginning, record
            if self.currentFrame == 1 then
                self.timesPlayed = self.timesPlayed + 1
            end
        end
    end
end

--[[
    Retrieve the frame ID of the currently active animation frame
]]
function Animation:getCurrentFrame()
    return self.frames[self.currentFrame]
end

