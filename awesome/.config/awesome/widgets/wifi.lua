local wibox     = require("wibox")
local network   = require("modules.network")
local beautiful = require("beautiful")
local awesome   = _G.awesome
local dpi       = require("beautiful.xresources").apply_dpi

local icon_no_network = ''
local icon_wifi       = ''
local icon_ethernet   = '' -- This is correct, but nerd fonts renders it wrong

local w = wibox.widget{
    layout  = wibox.layout.fixed.horizontal,
    spacing = dpi(10),
    {
        {
            markup = icon_no_network,
            align = 'center',
            font = 'Font Awesome 5 Pro Solid',
            widget = wibox.widget.textbox,
        },
        widget       = wibox.container.background,
        bg           = beautiful.colors[3],
        forced_width = dpi(30)
    },
    {
        markup = "No internet",
        widget = wibox.widget.textbox
    }
}

awesome.connect_signal("network::update", function(info)
    if info then
        if info.is_wifi then
            w.children[1].bg            = beautiful.colors[9]
            w.children[1].widget.markup = icon_wifi
            w.children[2].markup        = info.name
        else
            w.children[1].bg            = "#d65d0e"
            w.children[1].widget.markup = icon_ethernet
            w.children[2].markup        = "Wired"
        end
    end
end)

network:refresh()

return w
