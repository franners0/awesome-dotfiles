local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local wibox = require("wibox")
local menubar = require("menubar")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local hotkeys_popup = require("awful.hotkeys_popup")
local freedesktop = require("configuration.freedesktop")

-- {{{ Menu
-- Create a launcher widget and a main menu


myawesomemenu = {
    { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual", apps.terminal .. " -e man awesome" },
    { "edit config", apps.editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    { "log out", function() awesome.quit() end },
    { "shutdown", function() awful.spawn.with_shell("poweroff") end },
    { "reboot", function() awful.spawn.with_shell("reboot") end },
 }
 
 mymainmenu = freedesktop.menu.build({
    style = {shape  = gears.shape.rounded_bar,},
    before = {
        { "Awesome", myawesomemenu, beautiful.awesome_icon },
        -- other triads can be put here
    },
    after = {

        -- other triads can be put here
    }
    
})
 
 mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                      menu = mymainmenu,
                                      resize = true,
                                      style = {shape  = gears.shape.rounded_bar,},
                                      downscale = true,
                                    })
 
 -- Menubar configuration
 menubar.utils.terminal = terminal -- Set the terminal for applications that require it
 -- }}}
