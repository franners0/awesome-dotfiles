local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")
local wibox = require("wibox")
local beautiful = require("beautiful")
local menubar = require("menubar")
require("awful.autofocus")

--screen_width = awful.screen.focused().geometry.width
--screen_height = awful.screen.focused().geometry.height


-- Signal function to execute when a new client appears.


client.connect_signal("request::manage", function(c, context)

    -- Fallback icon for clients
    if c.icon == nil then
        local i = gears.surface(beautiful.theme_assets.awesome_icon(256, beautiful.xcolor8, beautiful.darker_bg))
        c.icon = i._native
    end
    
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end
    if awesome.startup and not c.size_hints.user_position and
        not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)


-- This should fix Wibar not hiding with fullscreen windows

client.connect_signal("property::fullscreen", function(c)

    if c.fullscreen then
      gears.timer.delayed_call(function()
        if c.valid then
          c:geometry(c.screen.geometry)
        end
      end)
    end
end)
  

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)


client.connect_signal("property::floating", function(c)
    awful.placement.no_offscreen(c)
    awful.placement.centered(c)
end)


client.connect_signal("property::fullscreen", function(c)
    awful.placement.no_offscreen(c)
end)

-- Remember tags after restarts

awesome.connect_signal('exit', function(reason_restart)
    if not reason_restart then return end
 
    local file = io.open('/tmp/awesomewm-last-selected-tags', 'w+')
 
    for s in screen do
       file:write(s.selected_tag.index, '\n') 
    end
 
    file:close()
end)
 

awesome.connect_signal('startup', function()
    local file = io.open('/tmp/awesomewm-last-selected-tags', 'r')
    if not file then return end
 
    local selected_tags = {}
 
    for line in file:lines() do
       table.insert(selected_tags, tonumber(line))
    end
    
    for s in screen do
       local i = selected_tags[s.index]
       local t = s.tags[i]
       t:view_only()
    end
 
    file:close()
end)


-- Enabling Icon packs in tasklist widget


client.connect_signal("manage", function(c)

        if c.instance ~= nil then
            local icon = menubar.utils.lookup_icon(c.instance)
            local lower_icon = menubar.utils.lookup_icon(c.instance:lower())
            if icon ~= nil then
                local new_icon =gears.surface(icon) 
                c.icon = new_icon._native
            elseif lower_icon ~= nil then 
                local new_icon = gears.surface(lower_icon)
                c.icon = new_icon._native
            elseif c.icon == nil then
                local new_icon = gears.surface(menubar.utils.lookup_icon("application-default-icon"))
                c.icon = new_icon._native
            end
        else
            local new_icon = gears.surface(menubar.utils.lookup_icon("application-default-icon"))
            c.icon = new_icon._native
        end

    end
)








