-- => Colors
-- Provides utility functions for handling colors
-- ============================================================


local color_libary = require("modules.color")
local tonumber = tonumber
local string = string
local math = math
local type = type
local floor = math.floor
local max = math.max
local min = math.min
local pow = math.pow
local random = math.random
local abs = math.abs
local format = string.format
local gcolor = require("gears.color")
local parse_color = gcolor.parse_color

-- Returns a value that is clipped to interval edges if it falls outside the interval
local function clip(num, min_num, max_num) return
    max(min(num, max_num), min_num) end

local function round(x, p)
	local power = 10 ^ (p or 0)
	return (x * power + 0.5 - (x * power + 0.5) % 1) / power
end


-- Converts the given hex color to normalized rgba
local function hex2rgb(color)
    -- color = color:gsub("#", "")
    -- local strlen = color:len()
    -- if strlen == 6 then
    --     return tonumber("0x" .. color:sub(1, 2)) / 255,
    --            tonumber("0x" .. color:sub(3, 4)) / 255,
    --            tonumber("0x" .. color:sub(5, 6)) / 255, 1
    -- end
    -- if strlen == 8 then
    --     return tonumber("0x" .. color:sub(1, 2)) / 255,
    --            tonumber("0x" .. color:sub(3, 4)) / 255,
    --            tonumber("0x" .. color:sub(5, 6)) / 255,
    --            tonumber("0x" .. color:sub(7, 8)) / 255
    -- end
    return parse_color(color)
end

-- Converts the given hex color to hsv
local function hex2hsv(color)
    local r, g, b = hex2rgb(color)
    local C_max = max(r, g, b)
    local C_min = min(r, g, b)
    local delta = C_max - C_min
    local H, S, V
    if delta == 0 then
        H = 0
    elseif C_max == r then
        H = 60 * (((g - b) / delta) % 6)
    elseif C_max == g then
        H = 60 * (((b - r) / delta) + 2)
    elseif C_max == b then
        H = 60 * (((r - g) / delta) + 4)
    end
    if C_max == 0 then
        S = 0
    else
        S = delta / C_max
    end
    V = C_max
    return H, S * 100, V * 100
end

-- Converts the given hsv color to hex
local function hsv2hex(H, S, V)
    S = S / 100
    V = V / 100
    if H > 360 then H = 360 end
    if H < 0 then H = 0 end
    local C = V * S
    local X = C * (1 - math.abs(((H / 60) % 2) - 1))
    local m = V - C
    local r_, g_, b_ = 0, 0, 0
    if H >= 0 and H < 60 then
        r_, g_, b_ = C, X, 0
    elseif H >= 60 and H < 120 then
        r_, g_, b_ = X, C, 0
    elseif H >= 120 and H < 180 then
        r_, g_, b_ = 0, C, X
    elseif H >= 180 and H < 240 then
        r_, g_, b_ = 0, X, C
    elseif H >= 240 and H < 300 then
        r_, g_, b_ = X, 0, C
    elseif H >= 300 and H < 360 then
        r_, g_, b_ = C, 0, X
    end
    local r, g, b = (r_ + m) * 255, (g_ + m) * 255, (b_ + m) * 255
    return ("#%02x%02x%02x"):format(floor(r), floor(g), floor(b))
end


-- Lightens a given hex color by the specified amount
local function lighten(color, amount)
    local r, g, b
    r, g, b = hex2rgb(color)
    r = 255 * r
    g = 255 * g
    b = 255 * b
    r = r + floor(2.55 * amount)
    g = g + floor(2.55 * amount)
    b = b + floor(2.55 * amount)
    r = r > 255 and 255 or r
    g = g > 255 and 255 or g
    b = b > 255 and 255 or b
    return ("#%02x%02x%02x"):format(r, g, b)
end

-- Darkens a given hex color by the specified amount
local function darken(color, amount)
    local r, g, b
    r, g, b = hex2rgb(color)
    r = 255 * r
    g = 255 * g
    b = 255 * b
    r = max(0, r - floor(r * (amount / 100)))
    g = max(0, g - floor(g * (amount / 100)))
    b = max(0, b - floor(b * (amount / 100)))
    return ("#%02x%02x%02x"):format(r, g, b)
end

function blend(color1, color2)
	color1 = color_libary.color({ hex = color1 })
	color2 = color_libary.color({ hex = color2 })

	return color_libary.color({
		r = round(0.3 * color1.r + 0.7 * color2.r),
		g = round(0.3 * color1.g + 0.7 * color2.g),
		b = round(0.3 * color1.b + 0.7 * color2.b),
	}).hex
end



return
{
    clip = clip,
    hex2rgb = hex2rgb,
    hex2hsv = hex2hsv,
    hsv2hex = hsv2hex,
    lighten = lighten,
    darken = darken,
    blend = blend,
}
