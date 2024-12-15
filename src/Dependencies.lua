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
Event = require 'lib/knife.event'
Timer = require 'lib/knife.timer'
Grid = require 'lib/jumper.grid'
Pathfinder = require 'lib/jumper.pathfinder'

---
--- REQUIRES -------------------------------------------------------------------
---

require 'src/Constants'
require 'src/Events'

require 'src/Animation'
require 'src/Entity'
require 'src/StateMachine'
require 'src/Util'

require 'src/helpers/Coordinates'
require 'src/helpers/Deque'
require 'src/helpers/Set'
require 'src/helpers/SparseArray'
require 'src/helpers/Vector'

require 'src/defs/EntityDefs'
require 'src/defs/IconDefs'

require 'src/ui/Cursor'
require 'src/ui/Menu'
require 'src/ui/Panel'
require 'src/ui/RangeFinder'
require 'src/ui/Selection'
require 'src/ui/Textbox'

require 'src/world/Level'
require 'src/world/Tile'
require 'src/world/TileMap'
require 'src/world/TileMapDef'

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

--- Entities
require 'src/states/entity/EntityBaseState'
require 'src/states/entity/EntityAutoWalkState'
require 'src/states/entity/EntityIdleState'
require 'src/states/entity/EntityWalkState'

--- Menus
require 'src/states/menus/MenuBaseState'
require 'src/states/menus/MenuBattleActionState'

--- Game
require 'src/states/game/BattleState'
require 'src/states/game/HeroSelectState'
require 'src/states/game/FadeInState'
require 'src/states/game/PlayState'
require 'src/states/game/StartState'

---@enum STATES Namespace for holding State Names, which are defined in the states themselves
STATES = {
    BASE = BaseState.NAME,

    --- Entity States
    ENTITY_BASE = EntityBaseState.NAME,
    ENTITY_AUTO_WALK = EntityAutoWalkState.NAME,
    ENTITY_IDLE = EntityIdleState.NAME,
    ENTITY_WALK = EntityWalkState.NAME,

    --- Menu States
    MENU_BASE = MenuBaseState.NAME,
    MENU_BATTLE_ACTION = MenuBattleActionState.NAME,

    --- Game States
    BATTLE = BattleState.NAME,
    CHARACTER_SELECT = HeroSelectState.NAME,
    FADE_IN = FadeInState.NAME,
    PLAY = PlayState.NAME,
    START = StartState.NAME,
}

--- Registered States
---@alias State
---| BaseState
---| EntityBaseState
---| EntityAutoWalkState
---| EntityIdleState
---| EntityWalkState
---| MenuBaseState
---| BattleState
---| HeroSelectState
---| FadeInState
---| PlayState
---| StartState


---
--- MAPS -----------------------------------------------------------------------
---

WorldTilesetDef = require 'maps/WorldTileset'

---@class Namespace for holding Map Defs
MapDefs = {
    ---@type TileMapDef
    Battle01 = require 'maps/Battle01',
}



---
--- TEXTURES -------------------------------------------------------------------
---

Textures = {
    [ENTITIES.HEROES.SWORD_1] = love.graphics.newImage('assets/actors/heroes/Sword1.png'),
    [ENTITIES.HEROES.SPEAR_1] = love.graphics.newImage('assets/actors/heroes/Spear1.png'),
    [ENTITIES.ENEMIES.BANDIT_1] = love.graphics.newImage('assets/actors/enemies/Bandit1.png'),
    [GFX.BACKGROUNDS.TITLE] = love.graphics.newImage('assets/backgrounds/title.png'),
    [GFX.UI.ICONS] = love.graphics.newImage('assets/ui/ansimuz_icons.png'),
    [GFX.UI.RANGE_FINDER_BLUE_50] = love.graphics.newImage('assets/ui/RangeFinderBlue50.png'),
    [GFX.UI.RANGE_FINDER_BLUE_FULL] = love.graphics.newImage('assets/ui/RangeFinderBlueFull.png'),
    [GFX.UI.RANGE_FINDER_GREEN_50] = love.graphics.newImage('assets/ui/RangeFinderGreen50.png'),
    [GFX.UI.RANGE_FINDER_GREEN_FULL] = love.graphics.newImage('assets/ui/RangeFinderGreenFull.png'),
    [GFX.UI.RANGE_FINDER_RED_50] = love.graphics.newImage('assets/ui/RangeFinderRed50.png'),
    [GFX.UI.RANGE_FINDER_RED_FULL] = love.graphics.newImage('assets/ui/RangeFinderRedFull.png'),
    [GFX.TILES.WORLD] = love.graphics.newImage('assets/tiles/WorldTileset.png'),
}


---
--- FRAMES ---------------------------------------------------------------------
---

Frames = {
    [ENTITIES.HEROES.SWORD_1] = GenerateQuads(Textures[ENTITIES.HEROES.SWORD_1], ACTOR_SIZE, ACTOR_SIZE),
    [ENTITIES.HEROES.SPEAR_1] = GenerateQuads(Textures[ENTITIES.HEROES.SPEAR_1], ACTOR_SIZE, ACTOR_SIZE),
    [ENTITIES.ENEMIES.BANDIT_1] = GenerateQuads(Textures[ENTITIES.ENEMIES.BANDIT_1], ACTOR_SIZE, ACTOR_SIZE),
    [GFX.UI.ICONS] = GenerateQuads(Textures[GFX.UI.ICONS], ICON_SIZE, ICON_SIZE),
    [GFX.UI.RANGE_FINDER_BLUE_50] = GenerateQuads(Textures[GFX.UI.RANGE_FINDER_BLUE_50], TILE_SIZE, TILE_SIZE),
    [GFX.UI.RANGE_FINDER_BLUE_FULL] = GenerateQuads(Textures[GFX.UI.RANGE_FINDER_BLUE_FULL], TILE_SIZE, TILE_SIZE),
    [GFX.UI.RANGE_FINDER_GREEN_50] = GenerateQuads(Textures[GFX.UI.RANGE_FINDER_GREEN_50], TILE_SIZE, TILE_SIZE),
    [GFX.UI.RANGE_FINDER_GREEN_FULL] = GenerateQuads(Textures[GFX.UI.RANGE_FINDER_GREEN_FULL], TILE_SIZE, TILE_SIZE),
    [GFX.UI.RANGE_FINDER_RED_50] = GenerateQuads(Textures[GFX.UI.RANGE_FINDER_RED_50], TILE_SIZE, TILE_SIZE),
    [GFX.UI.RANGE_FINDER_RED_FULL] = GenerateQuads(Textures[GFX.UI.RANGE_FINDER_RED_FULL], TILE_SIZE, TILE_SIZE),
    [GFX.TILES.WORLD] = GenerateQuads(Textures[GFX.TILES.WORLD], TILE_SIZE, TILE_SIZE),
}

-- for i, v in ipairs(Frames[GFX.TILES.WORLD]) do
--     print(i, v)
-- end


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