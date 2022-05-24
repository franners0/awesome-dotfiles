local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")
local wibox = require("wibox")
local beautiful = require("beautiful")




-- {{{ Signals
-- Signal function to execute when a new client appears.

client.connect_signal("request::manage", function(c, context)

    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end
    if awesome.startup and not c.size_hints.user_position and
        not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)

    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar.enable_tooltip = false
    
    awful.titlebar(c, {size = 22,}) : setup {
        { -- Left
            {
            awful.titlebar.widget.closebutton    (c),
            spacing = 2,
            awful.titlebar.widget.floatingbutton (c),
            spacing = 2,
            awful.titlebar.widget.minimizebutton (c),
            layout  = wibox.layout.fixed.horizontal
            },
            margins = 4,
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
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
client.connect_signal("manage", function (c) c.shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,10) end end)

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
 
 client.connect_signal("property::fullscreen", function(c)
    awful.placement.top(c)
end)
 client.connect_signal("property::floating", function(c)
    awful.placement.no_offscreen(c)
end)




dont_swallow_classname_list = { "firefox", "Gimp", "Brave-browser" }
table_minimize_parent = { "Io.github.celluloid_player.Celluloid" }
table_cannot_swallow = { "Dragon" }

function is_in_Table(table, element)
    for _, value in pairs(table) do
        if element:match(value) then
            return true
        end
    end
    return false
end

function cannot_be_swallowed(class)
    return not is_in_Table(dont_swallow_classname_list, class)
end

function can_swallow(class)
    return not is_in_Table(table_cannot_swallow, class)
end

function is_parent_minimized(class)
    return is_in_Table(table_minimize_parent, class)
end

function copy_size(c, parent_client)
    if (not c or not parent_client) then
        return
    end
    if (not c.valid or not parent_client.valid) then
        return
    end
    c.x=parent_client.x;
    c.y=parent_client.y;
    c.width=parent_client.width;
    c.height=parent_client.height;
end
function check_resize_client(c)
    if(c.child_resize) then
        copy_size(c.child_resize, c)
    end
end

function get_parent_pid(child_ppid, callback)
    local ppid_cmd = string.format("pstree -ps %s", child_ppid)
    awful.spawn.easy_async(ppid_cmd, function(stdout, stderr, reason, exit_code)
        -- primitive error checking
        if stderr and stderr ~= "" then
            callback(stderr)
            return
        end
        local ppid = stdout
        callback(nil, ppid)
    end)
end

client.connect_signal("property::size", check_resize_client)
client.connect_signal("property::position", check_resize_client)
client.connect_signal("manage", function(c)
    local parent_client=awful.client.focus.history.get(c.screen, 1)
    get_parent_pid(c.pid, function(err, ppid)
        if err then
            error(err)
            return
        end
        parent_pid = ppid
        if parent_client and (parent_pid:find("("..parent_client.pid..")")) and can_swallow(c.class) and cannot_be_swallowed(parent_client.class) then
            if is_parent_minimized(c.class) then
                parent_client.child_resize=c
                parent_client.minimized = true
                parent_client.skip_taskbar = not parent_client.skip_taskbar
                c:connect_signal("unmanage", function()
                    parent_client.minimized = false
                    parent_client.skip_taskbar = not parent_client.skip_taskbar
                end)
                copy_size(c, parent_client)
            else
                parent_client.child_resize=c
                c.floating=true
                copy_size(c, parent_client)
            end
        end
    end)


end)


