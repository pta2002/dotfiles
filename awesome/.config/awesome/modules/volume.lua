-- Little volume widget for pulseaudio
-- Requires pamixer
local awful     = require("awful")
local wibox     = require("wibox")
local gears     = require("gears")
local beautiful = require("beautiful")
local dpi       = require("beautiful.xresources").apply_dpi
local slider    = require("widgets.slider")

local volume = { }

local volumeicons = {'婢', '奄', '奔', '墳'}

local function geticon(vol)
    if vol <= 0 then
        return volumeicons[1]
    elseif vol < 33 then
        return volumeicons[2]
    elseif vol < 66 then
        return volumeicons[3]
    else
        return volumeicons[4]
    end
end

local volumeicon = wibox.widget {
    widget = wibox.container.background,
    fg = beautiful.colors[16],
    {
        widget = wibox.widget.textbox,
        align = 'center',
        valign = 'center',
        font = 'Hack Nerd Font 30',
        markup = volumeicons[4]
    }
}

local volumebar = wibox.widget {
    widget = wibox.widget.progressbar,
    value = 86,
    max_value = 100,
    forced_width = dpi(100),
    forced_height = dpi(12),
    background_color = beautiful.colors[9] .. "aa", -- beautiful.colors[10],
    color = beautiful.colors[9]
}

-- TODO put it in the bottom 25%
local volume_popup = awful.popup {
    widget = {
        {
            volumeicon,
            volumebar,
            layout = wibox.layout.fixed.vertical,
        },
        margins = 10,
        widget  = wibox.container.margin,
    },
    border_color = beautiful.get().colors[9],
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
    volumebar.value = value
    volumeicon.widget.markup = geticon(value)
    volume_popup.visible = true
    if timer then
        timer:stop()
    end
    timer = gears.timer.start_new(1, function()
        volume_popup.visible = false
        return false
    end)
end

local function pamixer(args)
    local command = "pamixer " .. table.concat(args, " ")
    local f = io.popen(command)
    local text = f:read("*line")
    f:close()

    return text
end

function volume.raise()
    pamixer({"-i", "5"})
    popup(volume.getvolume())
end

function volume.lower()
    pamixer({"-d", "5"})
    popup(volume.getvolume())
end

function volume.getvolume()
    local volume = pamixer({"--get-volume-human"})
    if volume == "muted" then
        return 0
    else
        return tonumber(pamixer({"--get-volume"}))
    end
end

function volume.togglemute()
    pamixer({"--toggle-mute"})
    popup(volume.getvolume())
end

volume.slider = slider(geticon, nil, nil, volume.getvolume, beautiful.colors[9])

return volume
