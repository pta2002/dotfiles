local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

local slider = {}

return function(get_icons, slider_action, click_action, refresh_action, color)
    local value = refresh_action()
    local ret = wibox.widget {
        layout = wibox.layout.grid,
        expand = false,
    }
    local icon = wibox.widget {
        markup = get_icons(value),
        widget = wibox.widget.textbox,
        font   = "Font Awesome 20",
    }
    local bar = {
        widget = wibox.widget.progressbar,
        value  = value,
        max_value = 100,
        forced_height = dpi(30),
        forced_width  = dpi(250),
        background_color = color .. "77",
        color = color,
    }

    ret:add_widget_at(icon, 1, 1, 1, 1)
    ret:add_widget_at(bar,  1, 2, 1, 6)

    return ret
end
