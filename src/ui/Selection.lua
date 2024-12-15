--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

	Code adapted from Colton Ogden's GD50 code
]]

--[[
    The Selection class gives us a list of textual items that link to callbacks;
    this particular implementation only has one dimension of items (vertically),
    but a more robust implementation might include columns as well for a more
    grid-like selection, as seen in many kinds of interfaces and games.
]]
---@class Selection
Selection = Class{}

---@type iPixels A small pixel pad for non/center justification
local HORIZONTAL_PAD = 10

---@class SelectionItemDef Table that holds selection text and onSelect() callback
---@field text string
---@field onSelect function

---@class SelectionDef Table that holds Menu Selection definitions
---@field items SelectionItemDef[]
---@field x posX
---@field y posY
---@field height pixels
---@field width pixels
---@field font? love.Font
---@field alignMode? love.AlignMode
---@field cursor? boolean

---@param def SelectionDef
function Selection:init(def)
    self.items = def.items
    self.x = def.x
    self.y = def.y

    self.height = def.height
    self.width = def.width
    self.font = def.font or Fonts[FONTS.MEDIUM]

    ---@type pixels
    self.gapHeight = self.height / #self.items

    ---@type integer Current Menu Selection
    self.currentSelection = 1

    ---@type love.AlignMode
    self.alignMode = def.alignMode or "center"

    ---@type boolean Flag to show or disable cursor
    self.cursor = def.cursor

    -- Set cursor to show if we haven't defined it in SelectionDef
    if self.cursor == nil then self.cursor = true end
end

function Selection:update(dt)
    if self.cursor then
        if love.keyboard.wasPressed(KEYS.UP) then
            if self.currentSelection == 1 then
                self.currentSelection = #self.items
            else
                self.currentSelection = self.currentSelection - 1
            end

            -- gSounds[SOUNDS.FX.BLIP]:stop()
            -- gSounds[SOUNDS.FX.BLIP]:play()
        elseif love.keyboard.wasPressed(KEYS.DOWN) then
            if self.currentSelection == #self.items then
                self.currentSelection = 1
            else
                self.currentSelection = self.currentSelection + 1
            end

            -- gSounds[SOUNDS.FX.BLIP]:stop()
            -- gSounds[SOUNDS.FX.BLIP]:play()
        elseif love.keyboard.wasPressed(KEYS.RETURN) or love.keyboard.wasPressed(KEYS.ENTER) then
            self.items[self.currentSelection].onSelect()

            -- gSounds[SOUNDS.FX.BLIP]:stop()
            -- gSounds[SOUNDS.FX.BLIP]:play()
        end
    end
end

function Selection:render()
    local currentY = self.y         ---@type posY
    local paddedX = self.x          ---@type posX
    local paddedWidth = self.width  ---@type iPixels

    -- If we're not in center mode, then add some padding to the Left/Right margins,
    -- to make sure that everything fits nicely
    if self.alignMode ~= 'center' then
        paddedX = paddedX + HORIZONTAL_PAD
        paddedWidth = paddedWidth - HORIZONTAL_PAD * 2
    end

    love.graphics.push()
    love.graphics.setFont(self.font)
    for i = 1, #self.items do
        local paddedY = currentY + (self.gapHeight / 2) - self.font:getHeight() / 2

        -- Only draw cursor if active and we're at the right index
        if self.cursor and i == self.currentSelection then
            love.graphics.draw(
                Textures[GFX.UI.ICONS],
                Frames[GFX.UI.ICONS][ICONS.SMALL_LEFT_ARROW],
                self.x - 8,
                paddedY
            )
        end

        love.graphics.printf(
            self.items[i].text,
            math.floor(paddedX),
            math.floor(paddedY),
            paddedWidth,
            self.alignMode
        )

        currentY = currentY + self.gapHeight
    end
    love.graphics.pop()
end