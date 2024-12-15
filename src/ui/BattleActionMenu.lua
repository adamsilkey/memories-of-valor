--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

    -- BattleActionMenu --

	Code adapted from Colton Ogden's GD50 code
]]

--[[
    This menu duplicates the classic Shining Force style battle menu
]]

---@class BattleActionMenu
BattleActionMenu = Class{}

function BattleActionMenu:init()

    self.width = 40
    self.height = 40

    self.x = math.floor((VIRTUAL_WIDTH / 2) - (self.width / 2))
    self.y = math.floor(VIRTUAL_HEIGHT - self.height)

    --- To hold the four square panels
    self.panels = {
        N = Panel(self.x, self.y, self.width, self.height)
    }
end

function BattleActionMenu:update(dt)
end

function BattleActionMenu:render()
    for name, panel in pairs(self.panels) do
        panel:render()
    end
end