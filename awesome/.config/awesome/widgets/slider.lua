local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi
-- local mousegrabber = require("mousegrabber")

local slider = {}

function slider:refresh()
    local val = self.refresh_action()
    self.children[1].markup = self.get_icons(val)
    self.children[2].value  = val
end

local function move_handle(self, width, x, _)
    self.value = math.floor(x * 100 / width)

    self.slider_action(self.value)
end

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
        align  = 'left',
    }
    local bar = wibox.widget {
        widget = wibox.widget.progressbar,
        value  = value,
        max_value = 100,
        forced_height = dpi(30),
        forced_width  = dpi(230),
        background_color = color .. "77",
        color = color,
    }

    icon:connect_signal("button::press", function(_, _, _, button, _, _)
        if button ~= 1 then return end

        if click_action then
            click_action()
        end
    end)

    bar:connect_signal("button::press", function(self, x, y, button_id, _, geo)
        -- Basically all taken from here:
        -- https://github.com/awesomeWM/awesome/blob/master/lib/wibox/widget/slider.lua#L493
        if button_id ~= 1 then return end

        local matrix_from_device = geo.hierarchy:get_matrix_from_device()
        local width = geo.widget_width

        move_handle(self, width, x, y)

        local wgeo = geo.drawable.drawable:geometry()
        local matrix = matrix_from_device:translate(-wgeo.x, -wgeo.y)

        mousegrabber.run(function(mouse)
            if not mouse.buttons[1] then return false end

            move_handle(self, width, matrix:transform_point(mouse.x, mouse.y))

            return true
        end, "left_ptr")
    end)

    ret.refresh_action = refresh_action
    ret.get_icons = get_icons
    ret.refresh = slider.refresh
    bar.slider_action = slider_action

    ret:add_widget_at(icon, 1, 1, 1, 1)
    ret:add_widget_at(bar,  1, 2, 1, 6)

    return ret
end
