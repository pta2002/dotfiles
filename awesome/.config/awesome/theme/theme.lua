-------------------------------
--  "Zenburn" awesome theme  --
--    By Adrian C. (anrxc)   --
-------------------------------

local gears = require("gears")
local themes_path = gears.filesystem.get_configuration_dir()

local rnotification = require("ruled.notification")
local dpi = require("beautiful.xresources").apply_dpi

-- {{{ Main
local theme = {}
theme.wallpaper = themes_path .. "theme/background.jpg"
-- }}}

local colors = {
    "#16161c",
    "#1a1c23",
-- Red
    "#e95678",
    "#ec6a88",
-- Green
    "#27d796",
    "#3fdaa4",
-- Yellow
    "#fab795",
    "#fbc3a7",
-- Blue
    "#26bbd9",
    "#3fc4de",
-- Magenta
    "#ee64ac",
    "#f075b5",
-- Cyan
    "#59e1e3",
    "#6be4e6",
-- White
    "#fdf0ed",
    "#ffffff",
}

-- {{{ Styles
theme.font      = "sans 8"

-- {{{ Colors
theme.fg_normal  = colors[16]
theme.fg_focus   = colors[15]
theme.fg_urgent  = colors[3]
theme.bg_normal  = colors[2]
theme.bg_focus   = colors[9]
theme.bg_urgent  = theme.bg_normal
theme.bg_systray = theme.bg_normal
-- }}}

-- {{{ Borders
theme.useless_gap   = dpi(5)
theme.border_width  = dpi(4)
theme.border_color_normal = colors[1]
theme.border_color_active = colors[9]
theme.border_color_marked = colors[7]
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = "#3F3F3F"
theme.titlebar_bg_normal = "#3F3F3F"
-- }}}

theme.taglist_text_font  = "Hack Nerd Font"
theme.taglist_text_empty    = {"", "", "", "", "", "", "", "", ""}
theme.taglist_text_occupied = {"", "", "", "", "", "", "", "", ""}
theme.taglist_text_focused  = {"", "", "", "", "", "", "", "", ""}
theme.taglist_text_urgent   = {"", "", "", "", "", "", "", "", ""}

theme.taglist_text_color_empty = { colors[15], colors[15], colors[15], colors[15], colors[15], colors[15], colors[15], colors[15], colors[15] }
theme.taglist_text_color_occupied = { colors[15], colors[15], colors[15], colors[15], colors[15], colors[15], colors[15], colors[15], colors[15] }
theme.taglist_text_color_focused = { colors[9], colors[9], colors[9], colors[9], colors[9], colors[9], colors[9], colors[9], colors[9] }
theme.taglist_text_color_urgent = { colors[3], colors[3], colors[3], colors[3], colors[3], colors[3], colors[3], colors[3], colors[3] }

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = "#CC9393"
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)
-- }}}

-- {{{ Icons
-- {{{ Taglist
theme.taglist_squares_sel   = themes_path .. "theme/taglist/squarefz.png"
theme.taglist_squares_unsel = themes_path .. "theme/taglist/squarez.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = themes_path .. "theme/awesome-icon.png"
theme.menu_submenu_icon      = themes_path .. "default/submenu.png"
-- }}}

-- Set different colors for urgent notifications.
rnotification.connect_signal('request::rules', function()
    rnotification.append_rule {
        rule       = { urgency = 'critical' },
        properties = { bg = '#ff0000', fg = '#ffffff' }
    }
end)


return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
