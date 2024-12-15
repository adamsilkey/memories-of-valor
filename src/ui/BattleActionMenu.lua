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

local SCALE_FACTOR = 0.45

---@enum BattleActionMenu.DIRS
BattleActionMenu.DIRS = {
    N = 'N',
    S = 'S',
    E = 'E',
    W = 'W',
}

function BattleActionMenu:init()

    -- Everything about the four panels generated below is dynamic to make
    -- a nice symmmetrical little window at the bottom of the screen

    self.miniWidth = 16
    self.miniHeight = 24

    self.width = self.miniWidth * 3
    self.height = self.miniHeight * 2

    self.x = math.floor((VIRTUAL_WIDTH / 2) - (self.width / 2))
    self.y = math.floor(VIRTUAL_HEIGHT - self.height)

    --- To hold the four square panels
    self.panels = {
        -- This was a debug panel usd to try and gauge the oerall size
        -- BIGGIE = Panel(self.x, self.y, self.width, self.height),

        --- Panel 1 - Top - x=(self.width / 2) -  (self.miniWidth / 2), y=0
        N = self:createMiniPanel(
            math.floor((self.width / 2) - (self.miniWidth / 2)),
            0,
            ICONS.BATTLE_MENU_SWORD
        ),
        --- Panel 2 - Bottom - x=(smae as Panel 1), y = self.y + miniHeight
        S = self:createMiniPanel(
            math.floor((self.width / 2) - (self.miniWidth / 2)),
            self.miniHeight,
            ICONS.BATTLE_MENU_WALK
        ),
        --- Panel 3 - Left
        W = self:createMiniPanel(
            0,
            math.floor((self.height / 2) - (self.miniHeight / 2)),
            ICONS.BATTLE_MENU_MAGIC
        ),
        --- Panel 4 - Right
        E = self:createMiniPanel(
            self.miniWidth * 2,
            math.floor((self.height / 2) - (self.miniHeight / 2)),
            ICONS.BATTLE_MENU_ITEM
        ),
    }

    self.currentPanel = self.DIRS.N

end

function BattleActionMenu:update(dt)
    if love.keyboard.isDown(KEYS.LEFT, KEYS.A) then
        self.currentPanel = self.DIRS.W
    elseif love.keyboard.isDown(KEYS.RIGHT, KEYS.D) then
        self.currentPanel = self.DIRS.E
    elseif love.keyboard.isDown(KEYS.UP, KEYS.W) then
        self.currentPanel = self.DIRS.N
    elseif love.keyboard.isDown(KEYS.DOWN, KEYS.D) then
        self.currentPanel = self.DIRS.S
    end
end

function BattleActionMenu:render()
    for name, panel in pairs(self.panels) do
        if name ~= self.currentPanel then
            panel:render({dimIcon = true})
        else
            panel:render({boldBorder = true})
        end
    end
end

function BattleActionMenu:createMiniPanel(offsetX, offsetY, icon)
    local x = math.floor(self.x + offsetX)
    local y = math.floor(self.y + offsetY)

    ---@type PanelDef
    local panelDef = {
        x=x,
        y=y,
        width=self.miniWidth,
        height=self.miniHeight,
        icon=icon,
        iconXoffset=1,
        iconYoffset=4,
        iconScaleFactor=SCALE_FACTOR,
    }

    return Panel(panelDef)
end