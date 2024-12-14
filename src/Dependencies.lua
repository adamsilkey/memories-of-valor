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
--- CONSTANTS ------------------------------------------------------------------
---

require 'src/Constants'

require 'src/Util'


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


---
--- TEXTURES -------------------------------------------------------------------
---

Textures = {
    [GFX.TILES.WORLD] = love.graphics.newImage('assets/tiles/WorldTileset.png')
}


---
--- FRAMES ---------------------------------------------------------------------
---

Frames = {
    [GFX.TILES.WORLD] = GenerateQuads(Textures[GFX.TILES.WORLD], TILE_SIZE, TILE_SIZE),
}