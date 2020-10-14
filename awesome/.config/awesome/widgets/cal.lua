local wibox = require 'wibox'
local dpi = require("beautiful.xresources").apply_dpi

local textclock = {
    layout = wibox.layout.fixed.horizontal,
    spacing = dpi(10),
    {
        {
            markup = '',
            align = 'center',
            font = 'Font Awesome 5 Pro Solid',
            widget = wibox.widget.textbox,
        },
        widget = wibox.container.background,
        bg = require('beautiful').colors[7],
        forced_width = dpi(30)
    },
    wibox.widget.textclock("%a %d/%m - %H:%M", 10)
}

return textclock

