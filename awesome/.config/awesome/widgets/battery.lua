local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

-- Set colors
local active_color = beautiful.battery_bar_active_color or "#5AA3CC"
local background_color = beautiful.battery_bar_background_color or "#222222"

local battery_icons_discharge = {'','','','','','','','','',''}
local battery_icons_charge = {''}

local charging = false
local value = 50

local function round(i)
    if math.abs(math.floor(i) - i) < math.abs(math.ceil(i) - i) then
        return math.floor(i)
    else
        return math.ceil(i)
    end
end

local function determine_icon(percent, icons)
    local icon = round(percent / (100 / #icons)) + 1
    return icons[icon]
end

local battery_icon = wibox.widget{
    layout = wibox.layout.fixed.horizontal,
    spacing = dpi(10),
    {
        {
            markup = determine_icon(50, battery_icons_discharge),
            align = 'center',
            widget = wibox.widget.textbox
        },
        widget = wibox.container.background,
        bg = active_color,
        forced_width = dpi(30)
    },
    {
        markup = '50%',
        widget = wibox.widget.textbox
    }
}

local function get_markup()
    if charging then
        battery_icon.children[1].widget.markup = battery_icons_charge[1]
        battery_icon.children[2].markup = tostring(value) .. '%'

        battery_icon.children[1].bg = beautiful.get().green
    else
        battery_icon.children[1].widget.markup = determine_icon(value, battery_icons_discharge)
        battery_icon.children[2].markup = '' .. tostring(value) .. '%'

        if value < 15 then
            battery_icon.children[1].bg = beautiful.get().fg_urgent
        else
            battery_icon.children[1].bg = active_color
        end
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
