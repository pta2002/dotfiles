local gears = require("gears")
local wibox = require("wibox")
local mpris = require("evil.mpris")

local status = {}

local music_status = wibox.widget {
  markup = '',
  widget = wibox.widget.textbox
}

local function get_markup()
  if status.title and status.artist ~= "" then
    music_status.markup = status.artist .. ' - ' .. status.title
  elseif status.title then
    music_status.markup = status.title
  end
end

awesome.connect_signal("evil::mpris", function(val)
  status = val
  get_markup()
end)

mpris:emit_mpris_info()
get_markup()

return music_status
