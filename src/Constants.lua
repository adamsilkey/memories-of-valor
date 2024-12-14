
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

---@alias frameID integer Texture frame ID (i.e. numerical index to quad)

---@alias seconds number Time in seconds (can be fractional)


---
--- CONSTANTS ------------------------------------------------------------------
---

VIRTUAL_WIDTH = 384     ---@type iPixels Virtual Screen Width, in pixels
VIRTUAL_HEIGHT = 216    ---@type iPixels Virtual Screen Height, in pixels

WINDOW_WIDTH = 1280     ---@type iPixels Default Window Width, in pixels
WINDOW_HEIGHT = 720     ---@type iPixels Default Window Height, in pixels

TILE_SIZE = 16           ---@type iPixels Tile Size


---
--- CLASS DEFS------------------------------------------------------------------
---

---@class RGB
---@field r number Red value (between 0 - 1)
---@field g number Green value (between 0 - 1)
---@field b number Blue value (between 0 - 1)


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
    F = 'f',
    P = 'p',
    S = 's',
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
