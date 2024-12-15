--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

---@class Textbox
Textbox = Class{}

---@enum Textbox.MODES Different Modes that change behavior
Textbox.MODES = {
    DEFAULT = 'default',
    IMPACT = 'impact',
}

---@param x posX
---@param y posY
---@param width pixels
---@param height pixels
---@param text string
---@param font love.Font
---@param alignMode? love.AlignMode
---@param mode? Textbox.MODES
function Textbox:init(x, y, width, height, text, font, alignMode, mode)
    self.panel = Panel(x, y, width, height)     ---@type Panel
    self.x = x              -- posX of Textbox
    self.y = y              -- posY of Textbox
    self.width = width      -- Width of Textbox
    self.height = height    -- Height of Textbox

    self.text = text        -- Text to be passed in
    self.font = font or Fonts[FONTS.SMALL]     -- Font, defaulting to small

    -- Chunk number depends on fontsize
    local chunkNumber
    if self.font == Fonts[FONTS.SMALL] then
        chunkNumber = 6
    elseif self.font == Fonts[FONTS.MEDIUM] then
        chunkNumber = 3
    elseif self.font == Fonts[FONTS.LARGE] then
        chunkNumber = 2
    else -- Unknown font
        error("Unknown font passed in! Check the code, my man!")
    end

    ---@type integer Total number of chunks to display in a box
    self.chunksPerTextbox = chunkNumber

    ---@type love.AlignMode AlignMode of Textbox
    self.alignMode = alignMode or "left"

    ---@type Textbox.MODES Changes behavior of textbox
    self.mode = mode or Textbox.MODES.DEFAULT

    ---@type integer, string[]
    _, self.textChunks = self.font:getWrap(self.text, self.width - 12)

    self.chunkCounter = 1       ---@type integer Flag to indicate current chunk
    self.endOfText = false      ---@type boolean Flag to indicate end of Text
    self.closed = false         ---@type boolean Flag to ???

    self:next()
end

--[[
    Goes to the next page of text if there is any, otherwise toggles the textbox.
]]
function Textbox:nextChunks()
    ---@type string[]
    local chunks = {}

    for i = self.chunkCounter, self.chunkCounter + self.chunksPerTextbox do
        table.insert(chunks, self.textChunks[i])

        -- if we've reached the number of total chunks, we can return
        if i == #self.textChunks then
            self.endOfText = true
            return chunks
        end
    end

    self.chunkCounter = self.chunkCounter + self.chunksPerTextbox

    return chunks
end

function Textbox:next()
    if self.endOfText then
        self.displayingChunks = {}
        self.panel:toggle()
        self.closed = true
    else
        self.displayingChunks = self:nextChunks()
    end
end

function Textbox:update(dt)
    if love.keyboard.wasPressed(KEYS.SPACE) or
        love.keyboard.wasPressed(KEYS.ENTER) or
        love.keyboard.wasPressed(KEYS.RETURN) then
        self:next()
    end
end

function Textbox:isClosed()
    return self.closed
end

function Textbox:render()
    self.panel:render()
    love.graphics.setFont(self.font)
    local fontHeight = self.font:getHeight()

    if self.mode == Textbox.MODES.DEFAULT then
        for i = 1, #self.displayingChunks do
            love.graphics.printf(
                self.displayingChunks[i],
                self.x + 5,
                self.y + 5 + (i - 1) * fontHeight,
                self.width,
                self.alignMode
            )
        end
    -- Big Chonky IMPACT Text
    elseif self.mode == Textbox.MODES.IMPACT then

        -- IMPACTS should be CENTERED!!!!!!!!
        local alignMode = "center"

        -- Put font in center of the textbox
        local y = self.y + self.height / 2 - fontHeight / 2
        y = math.floor(y)

        love.graphics.printf(
            self.text,
            self.x + 3,
            y,
            self.width,
            alignMode
        )
    end
end