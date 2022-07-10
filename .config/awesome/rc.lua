--      ▄████████  ▄█     █▄     ▄████████    ▄████████  ▄██████▄     ▄▄▄▄███▄▄▄▄      ▄████████  ▄█     █▄     ▄▄▄▄███▄▄▄▄
--      ███    ███ ███     ███   ███    ███   ███    ███ ███    ███  ▄██▀▀▀███▀▀▀██▄   ███    ███ ███     ███  ▄██▀▀▀███▀▀▀██▄
--      ███    ███ ███     ███   ███    █▀    ███    █▀  ███    ███  ███   ███   ███   ███    █▀  ███     ███  ███   ███   ███
--      ███    ███ ███     ███  ▄███▄▄▄       ███        ███    ███  ███   ███   ███  ▄███▄▄▄     ███     ███  ███   ███   ███
--    ▀███████████ ███     ███ ▀▀███▀▀▀     ▀███████████ ███    ███  ███   ███   ███ ▀▀███▀▀▀     ███     ███  ███   ███   ███
--      ███    ███ ███     ███   ███    █▄           ███ ███    ███  ███   ███   ███   ███    █▄  ███     ███  ███   ███   ███
--      ███    ███ ███ ▄█▄ ███   ███    ███    ▄█    ███ ███    ███  ███   ███   ███   ███    ███ ███ ▄█▄ ███  ███   ███   ███
--      ███    █▀   ▀███▀███▀    ██████████  ▄████████▀   ▀██████▀    ▀█   ███   █▀    ██████████  ▀███▀███▀    ▀█   ███   █▀


local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
beautiful.init(gears.filesystem.get_configuration_dir() .. "ui/theme.lua")
local bling = require("modules.bling")



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




require("configuration.user_vars")
require("configuration.keys")
require("configuration.rules")
require("configuration.signals")
require('ui.notification')
require("ui.layouts")
require("ui.menu")
require("ui.desktop")
require("ui.decorations")



collectgarbage("setpause", 160)
collectgarbage("setstepmul", 400)

gears.timer.start_new(10, function()
  collectgarbage("step", 20000)
  return true
end)
