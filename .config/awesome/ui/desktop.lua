-- This file will config and generate your widgets, "status-bar"/taskbar and wallpaper.



local awful     = require("awful")
local beautiful = require("beautiful")
local dpi       = require("beautiful").xresources.apply_dpi
local gears     = require("gears")
local wibox     = require("wibox")
local lain = require("lain")
local markup = lain.util.markup
local shape = require("gears.shape")




--      _    _  _      _               _     _____                 __  _
--      | |  | |(_)    | |             | |   /  __ \               / _|(_)
--      | |  | | _   __| |  __ _   ___ | |_  | /  \/  ___   _ __  | |_  _   __ _  ___
--      | |/\| || | / _` | / _` | / _ \| __| | |     / _ \ | '_ \ |  _|| | / _` |/ __|
--      \  /\  /| || (_| || (_| ||  __/| |_  | \__/\| (_) || | | || |  | || (_| |\__ \
--       \/  \/ |_| \__,_| \__, | \___| \__|  \____/ \___/ |_| |_||_|  |_| \__, ||___/
--                          __/ |                                           __/ |
--                         |___/                                           |___/


-- Volume Widget
local volicon = wibox.widget {
        image = beautiful.widget_vol,
        widget = wibox.widget.imagebox,
        resize = true,
       -- forced_width = 12,
}

local volume = lain.widget.alsa({
    settings = function()
        if volume_now.status == "off" then
            volicon:set_image(beautiful.widget_vol_mute)
        elseif tonumber(volume_now.level) == 0 then
            volicon:set_image(beautiful.widget_vol_no)
        elseif tonumber(volume_now.level) <= 8 then
            volicon:set_image(beautiful.widget_vol_low)
        else
            volicon:set_image(beautiful.widget_vol)
        end

        widget:set_markup(markup.font(beautiful.font, " " .. volume_now.level.."%"))
    end
})

volicon:buttons(awful.util.table.join(
    awful.button({}, 1, function() -- left click
        awful.spawn("pavucontrol")
    end),
    awful.button({}, 3, function() -- right click
        os.execute(string.format("%s set %s toggle", volume.cmd, volume.togglechannel or volume.channel))
        volume.update()
    end),
    awful.button({}, 4, function() -- scroll up
        os.execute(string.format("%s set %s 1%%+", volume.cmd, volume.channel))
        volume.update()
    end),
    awful.button({}, 5, function() -- scroll down
        os.execute(string.format("%s set %s 1%%-", volume.cmd, volume.channel))
        volume.update()
    end)
))

volume.widget:buttons(awful.util.table.join(
    awful.button({}, 1, function() -- left click
        awful.spawn("pavucontrol")
    end),
    awful.button({}, 3, function() -- right click
        os.execute(string.format("%s set %s toggle", volume.cmd, volume.togglechannel or volume.channel))
        volume.update()
    end),
    awful.button({}, 4, function() -- scroll up
        os.execute(string.format("%s set %s 1%%+", volume.cmd, volume.channel))
        volume.update()
    end),
    awful.button({}, 5, function() -- scroll down
        os.execute(string.format("%s set %s 1%%-", volume.cmd, volume.channel))
        volume.update()
    end)
))







local cpu2 = require("ui.widgets.cpu")

local ram2 = require("ui.widgets.ram")

mykeyboardlayout = awful.widget.keyboardlayout()




-- Systray Widget


local tray = wibox.widget{
	{{
		{
			{
                wibox.layout.margin(wibox.widget.systray(), 0, 3, 5, 5),
                wibox.layout.margin(volicon, 0, 0, 4, 4),
                volume,
			layout = wibox.layout.align.horizontal
			},
            right = 5,
            left = 5,
            layout = wibox.container.margin,

		},

        shape = function (cr, width, height)
        shape.rounded_rect(cr, width, height, 12) end,
        shape_border_width = beautiful.border_width,
        shape_border_color = beautiful.widget_border_color2,
        widget = wibox.container.background,
        bg = beautiful.bg_normal,
    },
    top = 3,
    bottom = 3,
    right = 6,
    layout = wibox.container.margin,
	},
	layout = wibox.layout.align.horizontal
}



-- Taglist Widget Buttons.
local taglist_buttons = gears.table.join(
        awful.button({ }, 1, function(t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
                if client.focus then
                    client.focus:move_to_tag(t)
                end
            end),
            awful.button({ }, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                if client.focus then
                    client.focus:toggle_tag(t)
                end
            end),
        awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
        awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)


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
                                              awful.menu.client_list({ theme = { width = dpi(320) } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
end))


-- Separator Widget
local spr = wibox.widget.textbox('')

local clock = require("ui.widgets.calendar")


popups = {
	clock_popup = clock.popup(),
}

--        _    _  _  _
--       | |  | |(_)| |
--       | |  | | _ | |__    __ _  _ __
--       | |/\| || || '_ \  / _` || '__|
--       \  /\  /| || |_) || (_| || |
--        \/  \/ |_||_.__/  \__,_||_|





-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
--screen.connect_signal("property::geometry", function(s) gears.wallpaper.maximized(beautiful.wallpaper, s   ) end)

awful.screen.connect_for_each_screen(function(s)

--gears.wallpaper.maximized(beautiful.wallpaper,s)






--     _                                  _     _____       _      _
--    | |                                | |   |_   _|     | |    | |
--    | |      __ _  _   _   ___   _   _ | |_    | |  __ _ | |__  | |  ___
--    | |     / _` || | | | / _ \ | | | || __|   | | / _` || '_ \ | | / _ \
--    | |____| (_| || |_| || (_) || |_| || |_    | || (_| || |_) || ||  __/
--    \_____/ \__,_| \__, | \___/  \__,_| \__|   \_/ \__,_||_.__/ |_| \___|
--                    __/ |
--                   |___/

    -- Each screen has its own tag table.
    if s.index==1 then
        awful.tag({ "Juno", "Apollo", "Jupiter", "Bacchus", }, s, awful.layout.layouts[2])
    elseif s.index==2 then
        awful.tag({ "Ceres", "Vesta", "Pluto", "Venus", }, s, awful.layout.layouts[3])
    end


-- Create a promptbox for each screen
s.mypromptbox = awful.widget.prompt{
    prompt = '<b>Run: </b>',
}


--       _                           _____  ______
--      | |                         |_   _| | ___ \
--      | |     __ _ _   _  ___  _   _| |   | |_/ / _____  __
--      | |    / _` | | | |/ _ \| | | | |   | ___ \/ _ \ \/ /
--      | |___| (_| | |_| | (_) | |_| | |   | |_/ / (_) >  <
--      \_____/\__,_|\__, |\___/ \__,_\_/   \____/ \___/_/\_\
--                    __/ |
--                   |___/

    if s.index==1 then
    s.mylayoutbox = awful.widget.layoutbox(s)
    elseif s.index==2 then
    s.mylayoutbox = awful.widget.layoutbox(s)
    end
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () mymainmenu:toggle() end),
                           awful.button({ }, 3, function () awful.layout.inc( 1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))





--            _____           _     _     _
--           |_   _|         | |   (_)   | |
--             | | __ _  __ _| |    _ ___| |_
--             | |/ _` |/ _` | |   | / __| __|
--             | | (_| | (_| | |___| \__ \ |_
--             \_/\__,_|\__, \_____/_|___/\__|
--                       __/ |
--                      |___/



    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
    }




--          _____            _     _  _       _
--         |_   _|          | |   | |(_)     | |
--           | |  __ _  ___ | | __| | _  ___ | |_
--           | | / _` |/ __|| |/ /| || |/ __|| __|
--           | || (_| |\__ \|   < | || |\__ \| |_
--           \_/ \__,_||___/|_|\_\|_||_||___/ \__|
--

s.mytasklist = awful.widget.tasklist {
    screen   = s,
    filter   = awful.widget.tasklist.filter.currenttags,
    buttons  = tasklist_buttons,
    style    = {
        shape_border_width = beautiful.border_width,
        shape  = gears.shape.rounded_bar,
    },
    layout   = {
    spacing = dpi(4),

    layout  = wibox.layout.fixed.horizontal
    },

    widget_template =
        {
        {
            {
                {
                    {
                        id     = 'icon_role',
                        widget = wibox.widget.imagebox,
                    },
                    margins = 6,
                    widget  = wibox.container.margin,
                },
                {
                    id     = 'text_role',
                    widget = wibox.widget.textbox,
                    ellipsize = 'end'
                },
                layout = wibox.layout.fixed.horizontal,
            },
            left  = 4,
            right = 4,
            widget = wibox.container.margin
        },
        id     = 'background_role',
        widget = wibox.container.background,
    },

}




s.bar = awful.wibar({
        position = "bottom",
        screen = s,
        height = beautiful.wibar_height,
        margins = {
            top    = 0,
            bottom = 6 * 2,
            left = 6 * 2,
            right = 6 * 2
        },
    }

)

-- This sets the widgets for the primary display.

if s.index==1 then
s.bar:setup {
    layout = wibox.layout.align.horizontal,
    --expand = "none",
    wibox.widget{
            {
                {
                    {
                        wibox.layout.margin(s.mylayoutbox, 8, 5, 7, 7),
                        wibox.layout.margin(s.mytaglist, 0, 0, 3, 3),
                        s.mypromptbox,
                        spacing = dpi(6),

                    layout = wibox.layout.fixed.horizontal
                    },
                    right = 5,
                    left = 5,
                    top = 2,
                    bottom = 2,
                    layout = wibox.container.margin,

                },

                shape = function (cr, width, height)
                shape.rounded_rect(cr, width, height, 15) end,
                shape_border_width = beautiful.border_width,
                shape_border_color = beautiful.border_focus,
                widget = wibox.container.background,
                bg = beautiful.bg_normal,

            },
        layout = wibox.layout.align.horizontal

    },

    wibox.layout.margin(s.mytasklist, dpi(4), dpi(4), 0, 0),

    wibox.widget{
            {
                {
                    {
                        require('ui.widgets.playerctl'),
                        tray,
                        clock.widget(popups.clock_popup),
                        layout = wibox.layout.align.horizontal
                    },
                    right = 5,
                    left = 5,
                    top = 2,
                    bottom = 2,
                    layout = wibox.container.margin,

                },

                shape = function (cr, width, height)
                shape.rounded_rect(cr, width, height, 15) end,
                shape_border_width = beautiful.border_width,
                shape_border_color = beautiful.border_focus,
                widget = wibox.container.background,
                bg = beautiful.bg_normal,

            },
        layout = wibox.layout.fixed.horizontal

    },

}

-- This sets the widgets for the second display.

elseif s.index==2 then

s.bar:setup {
    layout = wibox.layout.align.horizontal,
    --expand = "none",
    wibox.widget{
            {
                {
                    {
                        wibox.layout.margin(s.mylayoutbox, 8, 5, 7, 7),
                        wibox.layout.margin(s.mytaglist, 0, 0, 3, 3),
                        s.mypromptbox,
                        spacing = dpi(6),
                    layout = wibox.layout.fixed.horizontal
                    },
                    right = 5,
                    left = 5,
                    top = 2,
                    bottom = 2,
                    layout = wibox.container.margin,

                },

                shape = function (cr, width, height)
                shape.rounded_rect(cr, width, height, 15) end,
                shape_border_width = beautiful.border_width,
                shape_border_color = beautiful.border_focus,
                widget = wibox.container.background,
                bg = beautiful.bg_normal,

            },
        layout = wibox.layout.fixed.horizontal
    },

    wibox.layout.margin(s.mytasklist, dpi(4), dpi(4), 0, 0),

    wibox.widget{
            {
                {
                    {
                        ram2,
                        cpu2,
                        spacing = dpi(6),
                    layout = wibox.layout.fixed.horizontal
                    },
                    right = 5,
                    left = 5,
                    top = 2,
                    bottom = 2,
                    layout = wibox.container.margin,

                },

                shape = function (cr, width, height)
                shape.rounded_rect(cr, width, height, 15) end,
                shape_border_width = beautiful.border_width,
                shape_border_color = beautiful.border_focus,
                widget = wibox.container.background,
                bg = beautiful.bg_normal,

            },
        layout = wibox.layout.fixed.horizontal

    },


}

end


end)


-- }}}
