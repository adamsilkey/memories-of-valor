
--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

    Strategy RPG Game, made for GD50 Final Project
]]

---
--- ALIASES --------------------------------------------------------------------
---

---@alias pixels number Value in pixels (0-based, may be a fractional pixel)
---@alias iPixels integer Value in pixels (0-based, must be an integer)
---@alias posX number The X Position (Column, 0-based, may be a fractional pixel)
---@alias posY number The Y Position (Row, 0-based, may be a fractional pixel)

---@alias coordX integer The X Coordinate for the Map (not pixels)
---@alias coordY integer The Y Coordinate for the Map (not pixels)

---@alias tileX integer The X coordinate of a Tile in the Map (not pixels)
---@alias tileY integer The Y coordinate of a Tile in the Map (not pixels)

---@alias frame integer Texture frame ID (i.e. numerical index to quad)

---@alias seconds number Time in seconds (can be fractional)


---
--- CONSTANTS ------------------------------------------------------------------
---

VIRTUAL_WIDTH = 384     ---@type iPixels Virtual Screen Width, in pixels
-- VIRTUAL_HEIGHT = 216    ---@type iPixels Virtual Screen Height, in pixels
----- Is this a bug????????
VIRTUAL_HEIGHT = 208    ---@type iPixels Virtual Screen Height, in pixels

WINDOW_WIDTH = 1280     ---@type iPixels Default Window Width, in pixels
WINDOW_HEIGHT = 720     ---@type iPixels Default Window Height, in pixels

TILE_SIZE = 16          ---@type iPixels Tile Size
ACTOR_SIZE = 32         ---@type iPixels Tile Size of Actors
ICON_SIZE = 32          ---@type iPixels Tile Size of Icons

---@type seconds The global amount of time required to go move between tiles
ENTITY_MOVE_TIME = 0.15


---
--- CLASS DEFS------------------------------------------------------------------
---

---@class RGB
---@field r number Red value (between 0 - 1)
---@field g number Green value (between 0 - 1)
---@field b number Blue value (between 0 - 1)
---@field a? number Alpha value (between 0 - 1)


---
--- GRAPHICS CONSTANTS ---------------------------------------------------------
---

--- Add textures both here and in constants.lua

---@class GFX Namespace for Graphics Constants
GFX = {}

---@enum GFX.BACKGROUNDS Namespace for Backgrounds
GFX.BACKGROUNDS = {
    TITLE = 'title',
}

---@enum GFX.UI Namespace for UI
GFX.UI = {
    ICONS = 'Icons',
    RANGE_FINDER_BLUE_50 = 'RangeFinderBlue50',
    RANGE_FINDER_BLUE_FULL = 'RangeFinderBlueFull',
    RANGE_FINDER_GREEN_50 = 'RangeFinderGreen50',
    RANGE_FINDER_GREEN_FULL = 'RangeFinderGreenFull',
    RANGE_FINDER_RED_50 = 'RangeFinderRed50',
    RANGE_FINDER_RED_FULL = 'RangeFinderRedFull',
}

---@enum GFX.TILES Namespace for tiles
GFX.TILES = {
    WORLD = 'world',
}


---@TODO Add a check here that checks for any name collisions
---@TODO Check collisions against EntityDefs


---
--- KEYBOARD -------------------------------------------------------------------
---

---@enum KEYS For holding keyboard constants
KEYS = {
    --- Directions
    UP = 'up',
    DOWN = 'down',
    LEFT = 'left',
    RIGHT = 'right',

    --- Interaction Keys
    ENTER = 'enter',
    ESCAPE = 'escape',
    RETURN = 'return',
    SPACE = 'space',

    --- Letters
    A = 'a',
    D = 'd',
    F = 'f',
    P = 'p',
    S = 's',
    W = 'w',

    --- Function Keys
    F1 = 'f1',
}

---
--- DIRECITONS -----------------------------------------------------------------
---

---@enum DIRS
DIRS = {
    UP = 'up',
    DOWN = 'down',
    LEFT = 'left',
    RIGHT = 'right',
}
