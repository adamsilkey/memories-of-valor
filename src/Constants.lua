
--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

    Strategy RPG Game, made for GD50 Final Project
]]

--- ALIASES --------------------------------------------------------------------

---@alias pixels number Value in pixels (0-based, may be a fractional pixel)
---@alias iPixels integer Value in pixels (0-based, must be an integer)

--- CONSTANTS ------------------------------------------------------------------

VIRTUAL_WIDTH = 640     ---@type iPixels Virtual Screen Width, in pixels
VIRTUAL_HEIGHT = 360    ---@type iPixels Virtual Screen Height, in pixels

WINDOW_WIDTH = 1280     ---@type iPixels Default Window Width, in pixels
WINDOW_HEIGHT = 720     ---@type iPixels Default Window Height, in pixels

TILE_SIZE = 16           ---@type iPixels Tile Size