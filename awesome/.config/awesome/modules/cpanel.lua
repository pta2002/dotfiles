-- A nice and fancy control panel!
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

-- Helper function that puts a widget inside a box with a specified background color
-- Invisible margins are added so that the boxes created with this function are evenly separated
-- The widget_to_be_boxed is vertically and horizontally centered inside the box
local function create_boxed_widget(widget_to_be_boxed, width, height, color, padding)
    local box_container = wibox.container.background()
    box_container.bg = beautiful.colors[1]
    box_container.forced_height = height
    box_container.forced_width = width
    box_container.shape = gears.rectangle
    box_container.shape_border_width = dpi(4)
    box_container.shape_border_color = color
    -- box_container.shape = helpers.prrect(20, true, true, true, true)
    -- box_container.shape = helpers.prrect(30, true, true, false, true)

    local boxed_widget = wibox.widget {
         -- Add background color
         {
            {
                -- Center widget_to_be_boxed horizontally
                 nil,
                 {
                     -- Center widget_to_be_boxed vertically
                     nil,
                     -- The actual widget goes here
                     widget_to_be_boxed,
                     layout = wibox.layout.align.vertical,
                     expand = "none"
                 },
                 layout = wibox.layout.align.horizontal,
                 expand = "none"
             },
             widget = wibox.container.margin,
             margins = dpi(padding or 12)
         },
         widget = box_container,
     }

    return boxed_widget
end

-- Widgets for the panel

-- CALENDAR
local styles = {}
styles.month   = { padding      = 20,
    fg_color     = beautiful.colors[16],
    bg_color     = "#ff00ff00",
    border_width = 0,
}
styles.normal  = {}
styles.focus   = { fg_color = beautiful.colors[4],
    bg_color = "#ff00ff00",
    markup   = function(t) return t end,
}
styles.header  = { fg_color = beautiful.colors[14],
    bg_color = "#ff00ff00",
    -- markup   = function(t) return '<b>' .. t .. '</b>' end,
    markup   = function(t) return '<span font_desc="sans bold 22">' .. t .. '</span>' end,
}
styles.weekday = { fg_color = beautiful.colors[16],
    bg_color = "#ff00ff00",
    padding  = 3,
    markup   = function(t) return '<b>' .. t .. '</b>' end,
}

local function decorate_cell(widget, flag, date)
    if flag=='monthheader' and not styles.monthheader then
        flag = 'header'
    end
    local props = styles[flag] or {}
    if props.markup and widget.get_text and widget.set_markup then
        widget:set_markup(props.markup(widget:get_text()))
    end
    -- Change bg color for weekends
    local d = {year=date.year, month=(date.month or 1), day=(date.day or 1)}
    local default_fg = beautiful.colors[16]
    local default_bg = "#ff000000"
    -- local default_bg = (weekday==0 or weekday==6) and x.color6 or x.color14
    local ret = wibox.widget {
        {
            widget,
            margins = (props.padding or 2) + (props.border_width or 0),
            widget  = wibox.container.margin
        },
        shape              = props.shape,
        shape_border_color = props.border_color or beautiful.colors[1],
        shape_border_width = props.border_width or 0,
        fg                 = props.fg_color or default_fg,
        bg                 = props.bg_color or default_bg,
        widget             = wibox.container.background
    }
    return ret
end

local calendar = create_boxed_widget(wibox.widget {
   date = os.date("*t"),
   font = "Open Sans 12",
   long_weekdays = false,
   spacing = dpi(3),
   fn_embed = decorate_cell,
   widget = wibox.widget.calendar.month
}, nil, nil, beautiful.colors[13], 12)

-- POWER
local function create_button(text, action, color, font, height)
   local container = wibox.widget {
      widget = wibox.container.background,
      shape = gears.rectangle,
      shape_border_width = dpi(4),
      shape_border_color = color,
      bg = beautiful.colors[1]
   }

   return wibox.widget {
      widget = container,
      {
         widget = wibox.widget.textbox,
         markup = text,
         align = 'center',
         valign = 'center',
         font = font or "Hack Nerd Font 15",
         forced_height = height
      }
   }
end

local grid = wibox.widget {
   layout = wibox.layout.grid,
   spacing = dpi(12),
   homogenous = false,
}

grid:add_widget_at(calendar, 1, 1, 5, 4)
grid:add_widget_at(create_button('', nil, nil, nil, dpi(50)), 6, 1, 1, 1)
grid:add_widget_at(create_button('', nil, nil, nil, dpi(50)), 6, 2, 1, 1)
grid:add_widget_at(create_button('', nil, nil, nil, dpi(50)), 6, 3, 1, 1)
grid:add_widget_at(create_button('', nil, nil, nil, dpi(50)), 6, 4, 1, 1)

-- Configure the actual panel
local cpanel = wibox{
   visible = false,
   ontop = true,
   type = "dock",
   screen = screen.primary,
   bg = beautiful.colors[1] .. "aa",
   widget = {
      layout = wibox.layout.align.vertical,
      expand = "none",
      nil,
      {
         nil,
         grid,
         nil,
         layout = wibox.layout.align.horizontal,
         expand = "none",
      },
      nil,
   }
}

awful.placement.maximize(cpanel)

awful.screen.connect_for_each_screen(function(s)
   if s == screen.primary then
      s.cpanel = cpanel
   else
      s.cpanel = {}
   end
end)

local function set_visibility(v)
   for s in screen do
      s.cpanel.visible = v
   end
end

local cpanel_keygrabber

local function hide()
   awful.keygrabber.stop(cpanel_keygrabber)
   set_visibility(false)
end

local function show()
   local w = mouse.current_wibox
   if w then
      w.cursor = "left_ptr"
   end

   cpanel_keygrabber = awful.keygrabber.run(function(_, key, event)
      if event == "release" then return end
      if key == 'Escape' then
         hide()
      end
   end)
   set_visibility(true)
end

return {
   set_visibility = set_visibility,
   show = show,
   hide = hide,
}
