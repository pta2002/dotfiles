-- Little volume widget for pulseaudio
-- Requires pamixer
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local volume = { }

--[[
awful.popup {
    widget = {
        {
            {
                text   = 'foobar',
                widget = wibox.widget.textbox
            },
            {
                {
                    text   = 'foobar',
                    widget = wibox.widget.textbox
                },
                bg     = '#ff00ff',
                clip   = true,
                shape  = gears.shape.rounded_bar,
                widget = wibox.widget.background
            },
            {
                value         = 0.5,
                forced_height = 30,
                forced_width  = 100,
                widget        = wibox.widget.progressbar
            },
            layout = wibox.layout.fixed.vertical,
        },
        margins = 10,
        widget  = wibox.container.margin,
        opacity = 0.2
    },
    border_color = '#00ff00',
    border_width = 5,
    placement    = awful.placement.centered,
    shape        = gears.shape.rounded_rect,
    visible      = true,
    opacity      = 1,
    -- bg           = '#ffffff',
    type         = 'popup_menu',
    ontop        = true,
    input_passthrough = true
}
]]

local function pamixer(args)
    local command = "pamixer " .. table.concat(args, " ")
    local f = io.popen(command)
    local text = f:read("*line")
    f:close()

    return text
end

function volume.raise()
    pamixer({"-i", "5"})
end

function volume.lower()
    pamixer({"-d", "5"})
end

function volume.getvolume()
    return tonumber(pamixer({"--get-volume"}))
end

return volume
