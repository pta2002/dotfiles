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
local cachedvolume, muted

local function geticon(vol)
    vol = vol or 0
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

local function pamixer_async(args)
    local command = "pamixer " .. table.concat(args, " ")
     awful.spawn(command)
end

function volume.raise()
    if not muted then
        cachedvolume = math.min(cachedvolume + 5, 100)
    end
    popup(cachedvolume)
    pamixer_async({"-i", "5"})
    volume.slider:refresh()
end

function volume.lower()
    cachedvolume = math.max(cachedvolume - 5, 0)
    popup(cachedvolume)
    pamixer_async({"-d", "5"})
    volume.slider:refresh()
end

function volume.getvolume()
    local vol = pamixer({"--get-volume-human"})
    if vol == "muted" then
        cachedvolume = 0
        muted = true
    else
        cachedvolume = tonumber(pamixer({"--get-volume"}))
        muted = false
    end
    return cachedvolume
end

function volume.setvolume(arg)
    pamixer_async{"--unmute"}
    pamixer_async{"--set-volume", tostring(arg)}
    volume.slider:refresh()
end

function volume.togglemute()
    volume.togglemutenopopup()
    popup(cachedvolume)
end

function volume.togglemutenopopup()
    pamixer_async({"--toggle-mute"})
    volume.slider:refresh()
end

volume.slider = slider(geticon, volume.setvolume, volume.togglemutenopopup, volume.getvolume, beautiful.colors[9])

cachedvolume = volume.getvolume()

return volume
