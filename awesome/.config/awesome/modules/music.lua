local wibox = require("wibox")
local mpris = require("evil.mpris")
local awful = require("awful")
local dpi = require("beautiful.xresources").apply_dpi
local beautiful = require("beautiful")

local status = {}

local playpausebutton = wibox.widget {
  widget = wibox.container.background,
  {
    markup = '  ',
    align = 'center',
    font = 'Font Awesome 15',
    widget = wibox.widget.textbox,
  }
}

playpausebutton:buttons({
  awful.button({}, 1, function()
    mpris.play_pause()
  end)
})

local backbutton = wibox.widget {
  widget = wibox.container.background,
  {
    markup = '',
    align = 'center',
    font = 'Font Awesome 12',
    widget = wibox.widget.textbox,
  }
}

backbutton:buttons({
  awful.button({}, 1, function()
    mpris.go_prev()
  end)
})

local fwdbutton = wibox.widget {
  widget = wibox.container.background,
  {
    markup = '',
    align = 'center',
    font = 'Font Awesome 12',
    widget = wibox.widget.textbox,
  }
}

fwdbutton:buttons({
  awful.button({}, 1, function()
    mpris.go_next()
  end)
})

local function hoverize(widget, color)
  widget:connect_signal("mouse::enter", function()
    local w = _G.mouse.current_wibox
    if w then
      w.cursor = "hand2"
    end
    if color then
      widget.fg = color
    end
  end)

  widget:connect_signal("mouse::leave", function()
    local w = _G.mouse.current_wibox
    if w then
      w.cursor = "left_ptr"
    end
    if color then
      widget.fg = nil
    end
  end)
end

hoverize(playpausebutton, beautiful.colors[14])
hoverize(backbutton, beautiful.colors[14])
hoverize(fwdbutton, beautiful.colors[14])

-- TODO don't let it overflow!
local music_status = wibox.widget {
  layout = wibox.layout.fixed.vertical,
  spacing = dpi(10),
  {
    markup = '-',
    font   = "Open Sans Bold 17",
    widget = wibox.widget.textbox,
    forced_width = dpi(300),
    align  = 'center'
  },
  {
    markup = '-',
    font   = "Open Sans Semibold 13",
    widget = wibox.widget.textbox,
    forced_width = dpi(300),
    align  = 'center'
  },
  {
    layout = wibox.layout.align.horizontal,
    expand = "none",
    nil,
    {
      layout = wibox.layout.fixed.horizontal,
      spacing = dpi(20),
      backbutton,
      playpausebutton,
      fwdbutton
    },
    nil
  }
}

local function get_markup()
  if status.title then
    music_status.children[1].markup = status.title
    if status.artist and status.artist ~= "" then
      music_status.children[2].markup = status.artist
    else
      music_status.children[2].markuo = "-"
    end
  end

  if status.status == "Playing" then
    playpausebutton.widget.markup = "  "
  else
    playpausebutton.widget.markup = "  "
  end
end

awesome.connect_signal("evil::mpris", function(val)
  status = val
  get_markup()
end)

mpris:emit_mpris_info()
get_markup()

return music_status
