--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

    Strategy RPG Game, made for GD50 Final Project
]]

---
--- LIBRARIES ------------------------------------------------------------------
---

Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

---
--- REQUIRES -------------------------------------------------------------------
---

require 'src/Constants'

require 'src/Tile'
require 'src/StateMachine'
require 'src/Util'


---
--- STATES ---------------------------------------------------------------------
---

--- When adding a state, be sure to register the state name here in STATES.NAMES
--- There's almost certainly a better way to do this.
---
---@TODO: Really, what we should have here is a States Class which handles all
--- the references to all the states. And then, whenever we create a new state class
--- we should then register that state in the class, which will add the state constants
--- (like name) to a global registry that we can then check against and make sure we're
--- never passing in improper values

require 'src/states/BaseState'
require 'src/states/StateStack'

require 'src/states/game/PlayState'
require 'src/states/game/FadeInState'
require 'src/states/game/StartState'

---@enum STATES Namespace for holding State Names, which are defined in the states themselves
STATES = {
    BASE = BaseState.NAME,

    --- Game States
    FADE_IN = FadeInState.NAME,
    PLAY = PlayState.NAME,
    START = StartState.NAME,
}

--- Registered States
---@alias State
---| BaseState
---| FadeInState
---| PlayState
---| StartState


---
--- MAPS -----------------------------------------------------------------------
---

MapTileset = require 'maps/WorldTileset'
MapBattleO1 = require 'maps/Battle01'


---
--- GRAPHICS CONSTANTS ---------------------------------------------------------
---

--- Add textures both here and in constants.lua

---@class GFX Namespace for Graphics Constants
GFX = {}

---@enum GFX.TILES Namespace for tiles
GFX.TILES = {
    WORLD = 'world',
}

---@enum GFX.BACKGROUNDS Namespace for Backgrounds
GFX.BACKGROUNDS = {
    TITLE = 'title',
}


---
--- TEXTURES -------------------------------------------------------------------
---

Textures = {
    [GFX.TILES.WORLD] = love.graphics.newImage('assets/tiles/WorldTileset.png'),
    [GFX.BACKGROUNDS.TITLE] = love.graphics.newImage('assets/backgrounds/title.png'),
}


---
--- FRAMES ---------------------------------------------------------------------
---

Frames = {
    [GFX.TILES.WORLD] = GenerateQuads(Textures[GFX.TILES.WORLD], TILE_SIZE, TILE_SIZE),
}


---
--- FONTS ----------------------------------------------------------------------
---

---@enum FONTS Enum for Font Constants
FONTS = {
    TITLE = 'title',
    TITLE_SMALL = 'title-small',
    SMALL = 'small',
    MEDIUM = 'medium',
    LARGE = 'large',
    GOTHIC_MEDIUM = 'gothic-medium',
    GOTHIC_LARGE = 'gothic-large',
}

Fonts = {
    [FONTS.SMALL] = love.graphics.newFont('assets/fonts/font.ttf', 8),
    [FONTS.MEDIUM] = love.graphics.newFont('assets/fonts/font.ttf', 16),
    [FONTS.LARGE] = love.graphics.newFont('assets/fonts/font.ttf', 32),
    [FONTS.GOTHIC_MEDIUM] = love.graphics.newFont('assets/fonts/GothicPixels.ttf', 16),
    [FONTS.GOTHIC_LARGE] = love.graphics.newFont('assets/fonts/GothicPixels.ttf', 32),
    [FONTS.TITLE] = love.graphics.newFont('assets/fonts/zelda.otf', 32),
    [FONTS.TITLE_SMALL] = love.graphics.newFont('assets/fonts/zelda.otf', 16)
}