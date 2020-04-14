local awful = require("awful")
local wibox = require("wibox")
local taglist = require("modules.taglist")
local settings = require("settings")

local mytextclock = wibox.widget.textclock()

screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    local battery

    if settings.battery then
        battery = require("widgets.battery")
    end

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

   -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, bg = "#00000035", height = 20 })

    -- Add widgets to the wibox
    s.mywibox.widget = {
        layout = wibox.layout.align.horizontal,
        spacing_widget = wibox.widget.separator,
        {
            layout = wibox.layout.fixed.horizontal,
            taglist(s),
            s.mypromptbox
        },
        { layout = wibox.layout.flex.horizontal },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            battery,
            mytextclock,
        },
    }
end)
-- }}}

