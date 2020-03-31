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
theme.bg_focus   = colors[1]
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

-- {{{ Layout
theme.layout_tile       = themes_path .. "theme/layouts/tile.png"
theme.layout_tileleft   = themes_path .. "theme/layouts/tileleft.png"
theme.layout_tilebottom = themes_path .. "theme/layouts/tilebottom.png"
theme.layout_tiletop    = themes_path .. "theme/layouts/tiletop.png"
theme.layout_fairv      = themes_path .. "theme/layouts/fairv.png"
theme.layout_fairh      = themes_path .. "theme/layouts/fairh.png"
theme.layout_spiral     = themes_path .. "theme/layouts/spiral.png"
theme.layout_dwindle    = themes_path .. "theme/layouts/dwindle.png"
theme.layout_max        = themes_path .. "theme/layouts/max.png"
theme.layout_fullscreen = themes_path .. "theme/layouts/fullscreen.png"
theme.layout_magnifier  = themes_path .. "theme/layouts/magnifier.png"
theme.layout_floating   = themes_path .. "theme/layouts/floating.png"
theme.layout_cornernw   = themes_path .. "theme/layouts/cornernw.png"
theme.layout_cornerne   = themes_path .. "theme/layouts/cornerne.png"
theme.layout_cornersw   = themes_path .. "theme/layouts/cornersw.png"
theme.layout_cornerse   = themes_path .. "theme/layouts/cornerse.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus  = themes_path .. "zenburn/titlebar/close_focus.png"
theme.titlebar_close_button_normal = themes_path .. "zenburn/titlebar/close_normal.png"

theme.titlebar_minimize_button_normal = themes_path .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path .. "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_focus_active  = themes_path .. "zenburn/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = themes_path .. "zenburn/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path .. "zenburn/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = themes_path .. "zenburn/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = themes_path .. "zenburn/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = themes_path .. "zenburn/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path .. "zenburn/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = themes_path .. "zenburn/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = themes_path .. "zenburn/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = themes_path .. "zenburn/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = themes_path .. "zenburn/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = themes_path .. "zenburn/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = themes_path .. "zenburn/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = themes_path .. "zenburn/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path .. "zenburn/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = themes_path .. "zenburn/titlebar/maximized_normal_inactive.png"
-- }}}
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
