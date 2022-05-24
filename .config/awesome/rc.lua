
pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/chameleon/theme.lua")


modkey = "Mod4"
altkey = "Mod1"
shift = "Shift"
ctrl = "Control"


if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

apps = {
    terminal = "sakura",
    screenshot = "scrot ~/Pictures/Screenshots/%Y-%m-%d_%H%M%S-$wx$h_scr<ot.png",
    filebrowser = "nautilus",
    editor_cmd = "nano"
}

require("configuration.keys")
require("configuration.signals")
require("configuration.ruled")

require("configuration.layouts")
require("configuration.menu")
require("configuration.desktop")

screen_width = awful.screen.focused().geometry.width
screen_height = awful.screen.focused().geometry.height


-- List of apps to run on start-up
local run_on_start_up = {
    "picom --experimental-backends -b",
    "wal -R -n",
    "openrgb --startminimized"
 }
 
 
 -- ===================================================================
 -- Initialization
 -- ===================================================================
 

 
 -- Run all the apps listed in run_on_start_up
 for _, app in ipairs(run_on_start_up) do
    local findme = app
    local firstspace = app:find(" ")
    if firstspace then
       findme = app:sub(0, firstspace - 1)
    end
    -- pipe commands to bash to allow command to be shell agnostic
    awful.spawn.with_shell(string.format("echo 'pgrep -u $USER -x %s > /dev/null || (%s)' | bash -", findme, app), false)
end

collectgarbage("setpause", 160)
collectgarbage("setstepmul", 400)

gears.timer.start_new(10, function()
  collectgarbage("step", 20000)
  return true
end)