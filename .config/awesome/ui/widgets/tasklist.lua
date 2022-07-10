
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")


-- Tasklist Widget Buttons.
local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = dpi(120) } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
end))

s.tasklist = awful.widget.tasklist {
    screen   = s,
    filter   = awful.widget.tasklist.filter.minimizedcurrenttags,
    buttons  = tasklist_buttons,
    style    = {
        shape_border_width = beautiful.border_width,
        shape  = gears.shape.rounded_bar,
    },
    layout   = {
    spacing = 12,
    spacing_widget = {
        {
            forced_width = 5,
            forced_height = 2,
            shape        = gears.shape.rounded_rect,
            widget       = wibox.widget.separator
        },
        valign = 'center',
        halign = 'center',
        widget = wibox.container.place,
    },
    layout  = wibox.layout.fixed.horizontal
    },

    widget_template = {
        {
        {
            {
                {
                    {
                        id     = 'icon_role',
                        widget = wibox.widget.imagebox,
                    },
                    margins = 3,
                    widget  = wibox.container.margin,
                },
                {
                    id     = 'text_role',
                    widget = wibox.widget.textbox,
                },
                layout = wibox.layout.fixed.horizontal,
            },
            left  = 10,
            right = 10,
            widget = wibox.container.margin
        },
        id     = 'background_role',
        widget = wibox.container.background,
    },
    top  = 3,
    bottom = 3,
    widget = wibox.container.margin},
}

return s.tasklist