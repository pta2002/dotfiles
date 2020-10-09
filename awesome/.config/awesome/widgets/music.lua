local gears = require("gears")
local wibox = require("wibox")
local mpris = require("evil.mpris")
local dpi = require("beautiful.xresources").apply_dpi
local beautiful = require("beautiful")

local status = {}

local music_status = wibox.widget {
  layout = wibox.layout.fixed.horizontal,
  spacing = dpi(10),
  {
    {
      markup = '',
      align = 'center',
      widget = wibox.widget.textbox
    },
    widget = wibox.container.background,
    bg = beautiful.colors[13],
    forced_width = dpi(30)
  },
  {
    markup = 'Not playing',
    widget = wibox.widget.textbox
  }
}

local function get_markup()
  if status.title and status.artist ~= "" then
    music_status.children[2].markup = status.artist .. ' - ' .. status.title
  elseif status.title then
    music_status.children[2].markup = status.title
  end
end

awesome.connect_signal("evil::mpris", function(val)
  status = val
  get_markup()
end)

mpris:emit_mpris_info()
get_markup()

return music_status
