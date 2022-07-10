-- This file will generate titlebars, window borders and will set some "rules" for better behaviour with fullscreen windows or games.

local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- Double click titlebar function
function double_click_event_handler(double_click_event)
    if double_click_timer then
        double_click_timer:stop()
        double_click_timer = nil
        return true
    end
    
    double_click_timer = gears.timer.start_new(0.20, function()
        double_click_timer = nil
        return false
    end)
end

-- Titlebarssto


client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
        -- WILL EXECUTE THIS ON DOUBLE CLICK
            if double_click_event_handler() then
                c.maximized = not c.maximized
                c:raise()
            else
                awful.mouse.client.move(c)
            end
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar.enable_tooltip = false
    
    awful.titlebar(c, {size = 32,}) : setup {
        { -- Left
            {
            spacing = 10,
            awful.titlebar.widget.closebutton    (c),
            spacing = 3,
            awful.titlebar.widget.floatingbutton (c),
            spacing = 3,
            awful.titlebar.widget.minimizebutton (c),
            layout  = wibox.layout.fixed.horizontal
            },
            margins = 9,
            widget = wibox.container.margin
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.flex.horizontal
    }
end)


client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}



client.connect_signal("manage", function (c)
    c.shape = function(cr,w,h)
        gears.shape.rounded_rect(cr,w,h,12)
    end
end)



client.connect_signal("property::fullscreen", function (c)
    if c.fullscreen then
        c.shape = gears.shape.rectangle

    elseif not c.fullscreen then
        c.shape = function(cr,w,h)
            gears.shape.rounded_rect(cr,w,h,12)
        end
    end

end)
