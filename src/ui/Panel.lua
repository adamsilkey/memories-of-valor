--[[
    Memories of Valor

    Author: Adam Silkey
    Email: Adam.Silkey@gmail.com

	Code adapted from Colton Ogden's GD50 code
]]

---@class Panel
Panel = Class{}

---@class PanelDef
---@field x posX
---@field y posY
---@field width iPixels
---@field height iPixels
---@field color? RGB
---@field borderColor? RGB
---@field icon? ICONS Unique Icon Frame ID
---@field iconXoffset iPixels
---@field iconYoffset iPixels
---@field iconScaleFactor? number

---@param def PanelDef
function Panel:init(def)
    self.x = def.x
    self.y = def.y
    self.width = def.width
    self.height = def.height

    self.color = def.color
    if self.color == nil then
        self.color = {
            r = 56 / 255,
            g = 56 / 255,
            b = 56 / 255,
            a = 1,
        }
    end

    self.borderColor = def.borderColor
    if self.borderColor == nil then
        self.borderColor = {
            r = 0.8,
            g = 0.8,
            b = 0.8,
            a = 1,
        }
    end

    self.icon = def.icon
    self.iconXoffset = def.iconXoffset or 0
    self.iconYoffset = def.iconYoffset or 0
    self.iconScaleFactor = def.iconScaleFactor or 1

    ---@type boolean Flag to toggle if the panel is visible or not
    self.visible = true

    -- Found examples of how to do this in various places
    -- Played around with it until I landed on the approach of using dot/mix
    -- https://forum.derivative.ca/t/glsl-to-tint-greyscale-image-to-color/134255
    -- https://gist.github.com/Volcanoscar/4a9500d240497d3c0228f663593d167a
    --
    -- Gray shader that will turn a sprite into grayscale when used
    ---@type love.Shader
    self.grayShader = love.graphics.newShader[[
        extern float grayFactor;

        vec4 effect(vec4 vcolor, Image tex, vec2 texcoord, vec2 pixcoord)
        {
            vec4 outputcolor = Texel(tex, texcoord) * vcolor;
            float gray = dot(outputcolor.rgb, vec3(0.3, 0.6, 0.1));
            outputcolor.rgb = mix(outputcolor.rgb, vec3(gray), grayFactor);
            return outputcolor;
        }
    ]]
end

function Panel:update(dt)

end

---@class PanelRenderDefs
---@field dimIcon? boolean
---@field boldBorder? boolean

---@param params? table
function Panel:render(params)
    if params == nil then
        params = {}
    end

    local dimIcon = params.dimIcon
    if dimIcon == nil then
        dimIcon = false
    end

    local boldBorder = params.boldBorder
    if boldBorder == nil then
        boldBorder = false
    end

    if self.visible then
        love.graphics.setColor(
            self.borderColor.r,
            self.borderColor.g,
            self.borderColor.b,
            self.borderColor.a
        )
        love.graphics.rectangle('fill', self.x, self.y, self.width, self.height, 3)
        love.graphics.setColor(
            self.color.r,
            self.color.g,
            self.color.b,
            self.color.a
        )
        love.graphics.rectangle('fill', self.x + 1, self.y + 1, self.width - 2, self.height - 2, 3)
        love.graphics.setColor(1, 1, 1, 1)

        if boldBorder then
            -- Render Bold Border
            love.graphics.setColor(1, 1, 1, 1)
            -- draw actual cursor rect
            love.graphics.setLineWidth(2)
            love.graphics.rectangle('line', self.x, self.y, self.width, self.height, 3)
        end


        if self.icon ~= nil then
            if dimIcon then
                love.graphics.setShader(self.grayShader)
                self.grayShader:send("grayFactor", 1)
            end
            love.graphics.draw(
                Textures[GFX.UI.ICONS],
                Frames[GFX.UI.ICONS][self.icon],
                self.x + self.iconXoffset,
                self.y + self.iconYoffset,
                0,
                self.iconScaleFactor,
                self.iconScaleFactor
            )
            -- Reset the shader
            love.graphics.setShader()
        end
    end
end

-- Toggles the current visible setting
function Panel:toggle()
    self.visible = not self.visible
end