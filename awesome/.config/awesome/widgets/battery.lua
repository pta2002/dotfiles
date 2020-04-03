local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

-- Set colors
local active_color = beautiful.battery_bar_active_color or "#5AA3CC"
local background_color = beautiful.battery_bar_background_color or "#222222"

local charging = false
local value = 50

local battery_icon = wibox.widget{
    markup = 'Bat: 50%',

    widget = wibox.widget.textbox
}

local function get_markup()
    if charging then
        battery_icon.markup = 'Bat: <b>' .. tostring(value) .. '%</b>'
    else
        battery_icon.markup = 'Bat: ' .. tostring(value) .. '%'
    end
end

awesome.connect_signal("evil::charger", function(val)
    charging = val
    get_markup()
end)

awesome.connect_signal("evil::battery", function(val)
    value = val
    get_markup()
end)

return battery_icon