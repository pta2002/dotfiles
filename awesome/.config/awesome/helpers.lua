local gears = require("gears")
local awful = require("awful")

local helpers = {}

helpers.rrect = function(radius)
    return function(c, width, height)
        gears.shape.rounded_rect(c, width, height, radius)
    end
end

helpers.colorize_text = function(text, color)
    return "<span foreground='" .. color .."'>" .. text .. "</span>"
end

helpers.power = {}

function helpers.power.off()
    awful.spawn("systemctl poweroff")
end

function helpers.power.reboot()
    awful.spawn("systemctl reboot")
end

function helpers.power.logout()
    awesome.quit()
end

function helpers.power.lock()
    -- TODO!!!
    awful.spawn("notify-send 'not yet'")
end

return helpers
