-- This file will generate the appmenu and appmenu widget.

local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local wibox = require("wibox")
local menubar = require("menubar")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local hotkeys_popup = require("awful.hotkeys_popup")
local freedesktop = require("ui.freedesktop")

-- {{{ Menu
-- Create a launcher widget and a main menu


myawesomemenu = {
    { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual", apps.terminal .. " -e man awesome" },
    { "restart", awesome.restart },
    { "log out", function() awesome.quit() end },
    { "shutdown", function() awful.spawn.with_shell("poweroff") end },
    { "reboot", function() awful.spawn.with_shell("reboot") end },
 }
 
 mymainmenu = freedesktop.menu.build({

    before = {
    
        -- other triads can be put here
    },
    after = {
      { "Session", myawesomemenu, beautiful.awesome_icon },
        -- other triads can be put here
    }
    
      
})
 
mymainmenu.wibox.shape = function (cr, w, h)
    gears.shape.rounded_rect(cr, w, h, 12)
  end

local awful = require("awful")
  awful.menu.original_new = awful.menu.new
  function awful.menu.new(...)
local ret= awful.menu.original_new(...)
    ret.wibox.shape = function (cr, w, h)
      gears.shape.rounded_rect(cr, w, h, 12)
    end
    return ret
  end

 mylauncher = awful.widget.launcher({ image = beautiful.menu_icon,
                                      menu = mymainmenu,
                                      resize = true,
                                      downscale = true,
                                    })
 



 -- Menubar configuration
 menubar.utils.terminal = terminal -- Set the terminal for applications that require it
 -- }}}
