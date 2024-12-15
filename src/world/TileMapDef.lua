--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

    -- TileMapDef --

    Contains three annotations for the lua exports from the Tiled program
]]

---@class TileMapLayerDef Contains actual map of tiles
---@field type string
---@field x number
---@field y number
---@field width integer
---@field height integer
---@field id integer
---@field name string
---@field class string
---@field visible boolean
---@field opacity number
---@field offsetx number
---@field offsety number
---@field parallaxx number
---@field parallaxy number
---@field properties table
---@field encoding string
---@field data frame[]

---@class TilesetDef
---@field name integer
---@field firstgid integer
---@field filename string
---@field exportfilename? string

---@class TileMapDef TileMap Def file from Tiled Export
---@field version string
---@field luaversion string
---@field tiledversion string
---@field class string
---@field orientation string
---@field renderorder string
---@field width integer
---@field height integer
---@field tilewidth iPixels
---@field tileheight iPixels
---@field nextlayerid integer
---@field nextobjectid integer
---@field properties table
---@field layers TileMapLayerDef[]

---@enum TILE_IDS List of special tileIDs
TILE_IDS = {
    BLOCKED = 400,
}