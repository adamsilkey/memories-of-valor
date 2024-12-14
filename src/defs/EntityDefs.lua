--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

	Code adapted from Colton Ogden's GD50 code
]]

---@class EntityStatDefs
---@field baseHP integer
---@field baseMP integer
---@field baseAttack integer
---@field baseDefense integer
---@field baseAgility integer
---@field movement integer
---@field HPIV integer
---@field MPIV integer
---@field AttackIV integer
---@field DefenseIV integer
---@field AgilityIV integer


---@class EntityDef
---@field name string Unique name identifier
---@field type ENTITIES.TYPES Identity Type identifier
---@field stats EntityStatDefs
---@field animations { [ANIMATIONS] : AnimationDef }
---@field walkSpeed integer

----------@field animations { [ANIMATIONS]: AnimationDef }

---@TODO maybe some kind of pos def to pass into entities
------ ---@field direction DIRS
------ ---@field x posX
------ ---@field y posY
------ ---@field width width
------ ---@field height height
------ ---@field offsetX pixels
------ ---@field offsetY pixels

---
--- ENTITY DEFS ----------------------------------------------------------------
---

---@class ENTITIES Namespace for holding entity information
ENTITIES = {}

---@enum ENTITIES.TYPES
ENTITIES.TYPES = {
    HERO = 'Hero',
}

---@enum
ENTITIES.HEROES = {
    SWORD_1 = 'Sword1',
}

---@type {[string]: EntityDef}
ENTITY_DEFS = {
    [ENTITIES.HEROES.SWORD_1] = {
        name = ENTITIES.HEROES.SWORD_1,
        type = ENTITIES.TYPES.HERO,
        walkSpeed = 60,
        stats = {
            baseHP = 12,
            baseMP = 8,
            baseAttack = 6,
            baseDefense = 4,
            baseAgility = 4,
            movement = 6,
            HPIV = 4,
            MPIV = 2,
            AttackIV = 4,
            DefenseIV = 3,
            AgilityIV = 2,
        },
        animations = {
            [ANIMATIONS.IDLE_RIGHTLEFT] = {
                frames = {
                    1,
                    2,
                    3,
                    4,
                },
                interval = 0.15,
                texture = ENTITIES.HEROES.SWORD_1,
            },
            [ANIMATIONS.IDLE_DOWN] = {
                frames = {
                    41,
                    42,
                    43,
                    44,
                },
                interval = 0.15,
                texture = ENTITIES.HEROES.SWORD_1,
            },
            [ANIMATIONS.IDLE_UP] = {
                frames = {
                    81,
                    82,
                    83,
                    84,
                },
                interval = 0.15,
                texture = ENTITIES.HEROES.SWORD_1,
            },
            [ANIMATIONS.WALK_RIGHTLEFT] = {
                frames = {
                    9,
                    10,
                    11,
                    12,
                },
                interval = 0.15,
                texture = ENTITIES.HEROES.SWORD_1,
            },
            [ANIMATIONS.WALK_DOWN] = {
                frames = {
                    49,
                    50,
                    51,
                    52,
                },
                interval = 0.15,
                texture = ENTITIES.HEROES.SWORD_1,
            },
            [ANIMATIONS.WALK_UP] = {
                frames = {
                    89,
                    90,
                    91,
                    92,
                },
                interval = 0.15,
                texture = ENTITIES.HEROES.SWORD_1,
            },
            [ANIMATIONS.ATTACK_RIGHTLEFT] = {
                frames = {
                    17,
                    18,
                    19,
                    20,
                },
                interval = 0.05,
                texture = ENTITIES.HEROES.SWORD_1,
                looping = false,
            },
            [ANIMATIONS.ATTACK_DOWN] = {
                frames = {
                    57,
                    58,
                    59,
                    60,
                },
                interval = 0.05,
                looping = false,
                texture = ENTITIES.HEROES.SWORD_1,
            },
            [ANIMATIONS.ATTACK_UP] = {
                frames = {
                    97,
                    98,
                    99,
                    100,
                },
                interval = 0.05,
                looping = false,
                texture = ENTITIES.HEROES.SWORD_1,
            },
            [ANIMATIONS.DIE_RIGHTLEFT] = {
                frames = {
                    25,
                    26,
                    27,
                    28,
                },
                interval = 0.05,
                looping = false,
                texture = ENTITIES.HEROES.SWORD_1,
            },
            [ANIMATIONS.DIE_DOWN] = {
                frames = {
                    65,
                    66,
                    67,
                    68,
                },
                interval = 0.05,
                looping = false,
                texture = ENTITIES.HEROES.SWORD_1,
            },
            [ANIMATIONS.DIE_UP] = {
                frames = {
                    105,
                    106,
                    107,
                    108,
                },
                interval = 0.05,
                looping = false,
                texture = ENTITIES.HEROES.SWORD_1,
            },
        },
    },
}
