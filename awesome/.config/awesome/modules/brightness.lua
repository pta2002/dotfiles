-- Little brightness widget
-- Requires brightnessctl
local awful     = require("awful")
local wibox     = require("wibox")
local gears     = require("gears")
local beautiful = require("beautiful")
local dpi       = require("beautiful.xresources").apply_dpi
local slider    = require("widgets.slider")

local brightness = {}

local icon = ''
local cachedbrigthness, maxbrightness
local color = "#d65d0e"

local brightnessicon = wibox.widget {
    widget = wibox.container.background,
    fg = beautiful.colors[16],
    {
        widget = wibox.widget.textbox,
        align = 'center',
        valign = 'center',
        font = 'Font Awesome 30',
        markup = icon
    }
}

local brightnessbar = wibox.widget {
    widget = wibox.widget.progressbar,
    value = 86,
    max_value = 100,
    forced_width = dpi(100),
    forced_height = dpi(12),
    background_color = color .. "aa", -- beautiful.colors[10],
    color = color
}

local brightness_popup = awful.popup {
    widget = {
        {
            brightnessicon,
            brightnessbar,
            spacing = dpi(6),
            layout = wibox.layout.fixed.vertical,
        },
        margins = 10,
        widget  = wibox.container.margin,
    },
    border_color = color,
    border_width = dpi(4),
    placement    = awful.placement.centered,
    visible      = false,
    opacity      = 1,
    bg           = beautiful.colors[1],
    type         = 'popup_menu',
    ontop        = true,
    screen       = screen.primary,
    input_passthrough = true
}

local timer

local function popup(value)
    brightnessbar.value = value
    brightness_popup.visible = true
    if timer then
        timer:stop()
    end
    timer = gears.timer.start_new(1, function()
        brightness_popup.visible = false
        return false
    end)
end

local function brightnessctl(args)
    local command = "brightnessctl " .. table.concat(args, " ")
    local f = io.popen(command)
    local text = f:read("*line")
    f:close()

    return text
end

local function brightnessctl_async(args)
    local command = "brightnessctl " .. table.concat(args, " ")
     awful.spawn(command)
end

function brightness.raise()
    cachedbrightness = math.min(cachedbrightness + 0.05 * maxbrightness, maxbrightness)
    popup(cachedbrightness * 100 / maxbrightness)
    brightnessctl_async({"s", "+5%"})
    brightness.slider:refresh()
end

function brightness.lower()
    cachedbrightness = math.max(cachedbrightness - 0.05 * maxbrightness, 0)
    popup(cachedbrightness * 100 / maxbrightness)
    brightnessctl_async({"s", "5%-"})
    brightness.slider:refresh()
end

function brightness.getbrightness()
    local vol = brightnessctl({"g"})
    cachedbrightness = tonumber(brightnessctl({"g"}))
    return cachedbrightness * 100 / maxbrightness
end

function brightness.setbrightness(arg)
    brightnessctl_async{"s", tostring(arg * maxbrightness / 100)}
    brightness.slider:refresh()
end

cachedbrightness = tonumber(brightnessctl({"g"}))
maxbrightness = tonumber(brightnessctl({"m"}))

brightness.slider = slider(function() return icon end, brightness.setbrightness, nil, brightness.getbrightness, color)

return brightness
