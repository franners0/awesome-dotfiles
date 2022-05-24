--      __        __  _   _                    
--      \ \      / / (_) | |__     __ _   _ __ 
--       \ \ /\ / /  | | | '_ \   / _` | | '__|
--        \ V  V /   | | | |_) | | (_| | | |   
--         \_/\_/    |_| |_.__/   \__,_| |_|   
                                       

local awful     = require("awful")
local beautiful = require("beautiful")
local dpi       = require("beautiful").xresources.apply_dpi
local gears     = require("gears")
local wibox     = require("wibox")
local lain = require("lain")
local spr = wibox.widget.textbox(' | ')
local markup = lain.util.markup


screen_width = awful.screen.focused().geometry.width
screen_height = awful.screen.focused().geometry.height

--      _    _  _      _               _     _____                 __  _             
--      | |  | |(_)    | |             | |   /  __ \               / _|(_)            
--      | |  | | _   __| |  __ _   ___ | |_  | /  \/  ___   _ __  | |_  _   __ _  ___ 
--      | |/\| || | / _` | / _` | / _ \| __| | |     / _ \ | '_ \ |  _|| | / _` |/ __|
--      \  /\  /| || (_| || (_| ||  __/| |_  | \__/\| (_) || | | || |  | || (_| |\__ \
--       \/  \/ |_| \__,_| \__, | \___| \__|  \____/ \___/ |_| |_||_|  |_| \__, ||___/
--                          __/ |                                           __/ |     
--                         |___/                                           |___/      



-- CPU Usage Widget

local cpu = lain.widget.cpu {
    settings = function()
        widget:set_markup("CPU: " .. cpu_now.usage .."%")
    end
}

-- RAM Usage Widget

local ram = lain.widget.mem {
    settings = function()
        widget:set_markup("RAM: " .. mem_now.used .."Mbs")
    end
}

-- Volume Widget

local volume = lain.widget.alsa {
    settings = function()
        widget:set_markup("VOL: " .. volume_now.level .."%")
    end,
}
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

-- Media Widget

local media = lain.widget.playerctl {
    settings = function()
        widget:set_markup(playerctl_now.artist .. playerctl_now.title)
    end
}

media.widget:buttons(awful.util.table.join(
    awful.button({}, 1, function() -- left click
        awful.spawn(string.format("playerctl play-pause", terminal))
    end),
    awful.button({}, 2, function() -- middle click
        os.execute(string.format("playerctl previous", terminal))
    end),
    awful.button({}, 3, function() -- right click
        os.execute(string.format("playerctl next", terminal))

    end),
    awful.button({}, 4, function() -- scroll up
        os.execute(string.format("playerctl position 2+", terminal))

    end),
    awful.button({}, 5, function() -- scroll down
        os.execute(string.format("playerctl position 2-", terminal))

    end)
))

-- Keyboard Map Widget
mykeyboardlayout = awful.widget.keyboardlayout()


-- Textclock Widget
mytextclock = wibox.widget.textclock()


-- Taglist widget
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

-- Tasklist Widget

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
                                              awful.menu.client_list({ theme = { width = 20 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

-- Set Wallpaper Function

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper)
    end
end


-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper

set_wallpaper(s)
  
    -- Each screen has its own tag table.
    if s.index==1 then
        awful.tag({ "あ", "い", "う", "え", }, s, awful.layout.layouts[2])
    elseif s.index==2 then
        awful.tag({ "あ", "い", "う", "え", }, s, awful.layout.layouts[3])
    end
    


    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        style    = {
            shape  = gears.shape.rounded_bar,
        },
        layout   = {
            margin = 1,
            spacing = 3,
            layout  = wibox.layout.flex.horizontal
        },
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen   = s,
        filter   = awful.widget.tasklist.filter.minimizedcurrenttags,
        buttons  = tasklist_buttons,
        style    = {
            shape_border_width = 1,
            shape  = gears.shape.rounded_bar,
        },
        layout   = {
            spacing = 10,
            spacing_widget = {
                {
                    forced_width = 5,
                    shape        = gears.shape.circle,
                    widget       = wibox.widget.separator
                },
                valign = 'center',
                halign = 'center',
                widget = wibox.container.place,
            },
            layout  = wibox.layout.fixed.horizontal
        },
        -- Notice that there is *NO* wibox.wibox prefix, it is a template,
        -- not a widget instance.
        widget_template = {
            {
                {
                    {
                        {
                            id     = 'icon_role',
                            widget = wibox.widget.imagebox,
                        },
                        margins = 2,
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
    }
        
    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s,  height = 16})

    if s.index==1 then
        s.mywibox:setup {

            layout = wibox.layout.align.horizontal,

            { -- Left widgets
                layout = wibox.layout.align.horizontal,
                mylauncher,
                spr,
                s.mytaglist,
                spr,
                s.mylayoutbox,
                s.mypromptbox,
            },
    
            s.mytasklist, -- Middle widget
    
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                media,
                spr,	
                wibox.widget.systray(),
                spr,
                mytextclock,
            },
        }
    elseif s.index==2 then
        s.mywibox:setup {

            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                s.mytaglist,
                spr,
                s.mylayoutbox,
                s.mypromptbox,
                
            },
    
            s.mytasklist,
    
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                ram,
                spr,
                cpu,
                spr,
                volume,
            },
        }
    end

    -- Add widgets to the wibox

end)

-- }}}