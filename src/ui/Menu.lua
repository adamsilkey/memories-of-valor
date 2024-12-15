--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

	Code adapted from Colton Ogden's GD50 code
]]

--[[
    A Menu is simply a Selection layered onto a Panel, at least for use in this
    game. More complicated Menus may be collections of Panels and Selections that
    form a greater whole.
]]

---@class Menu
Menu = Class{}

---@class MenuDef
---@field x posX
---@field y posY
---@field width pixels
---@field height pixels
---@field items SelectionItemDef[]
---@field alignMode? love.AlignMode
---@field cursor? boolean
---@field font? love.Font

---@param def MenuDef
function Menu:init(def)
    ---@type Panel
    self.panel = Panel(def.x, def.y, def.width, def.height)

    ---@type Selection
    self.selection = Selection {
        items = def.items,
        x = def.x,
        y = def.y,
        width = def.width,
        height = def.height,
        alignMode = def.alignMode,
        cursor = def.cursor,
        font = def.font,
    }
end

function Menu:update(dt)
    self.selection:update(dt)
end

function Menu:render()
    self.panel:render()
    self.selection:render()
end