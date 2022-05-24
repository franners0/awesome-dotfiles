

                                    
--   _______  _______  _______  _______ 
--  |\     /||\     /||\     /||\     /|
--  | +---+ || +---+ || +---+ || +---+ |
--  | |   | || |   | || |   | || |   | |
--  | |K  | || |e  | || |y  | || |s  | |
--  | +---+ || +---+ || +---+ || +---+ |
--  |/_____\||/_____\||/_____\||/_____\|
                                     
 
 

-- ===================================================================
-- Initialization
-- ===================================================================


local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
local dpi = beautiful.xresources.apply_dpi
local menubar = require("menubar")
local lain = require("lain")
-- Define mod keys



-- Mouse Bindings
awful.mouse.append_global_mousebindings({
   awful.button({}, 3, function () mymainmenu:toggle() end)
})

local shot_notify = function(fpath)
   naughty.notification {
       title = "System",
       text = "Screenshot saved",
       app_name = "AwesomeWM",
       image = fpath
   }
end

-- Client and Tabs Bindings
awful.keyboard.append_global_keybindings({
   awful.key({"Mod1"}, "a",
             function() bling.module.tabbed.pick_with_dmenu() end,
             {description = "pick client to add to tab group", group = "tabs"}),
   awful.key({"Mod1"}, "s", function() bling.module.tabbed.iter() end,
             {description = "iterate through tabbing group", group = "tabs"}),
   awful.key({"Mod1"}, "d", function() bling.module.tabbed.pop() end, {
       description = "remove focused client from tabbing group",
       group = "tabs"
   }), awful.key({modkey}, "Down", function()
       awful.client.focus.bydirection("down")
       bling.module.flash_focus.flashfocus(client.focus)
   end, {description = "focus down", group = "client"}),
   awful.key({modkey}, "Up", function()
       awful.client.focus.bydirection("up")
       bling.module.flash_focus.flashfocus(client.focus)
   end, {description = "focus up", group = "client"}),
   awful.key({modkey}, "Left", function()
       awful.client.focus.bydirection("left")
       bling.module.flash_focus.flashfocus(client.focus)
   end, {description = "focus left", group = "client"}),
   awful.key({modkey}, "Right", function()
       awful.client.focus.bydirection("right")
       bling.module.flash_focus.flashfocus(client.focus)
   end, {description = "focus right", group = "client"}),
   awful.key({modkey}, "j", function() awful.client.focus.byidx(1) end,
             {description = "focus next by index", group = "client"}),
   awful.key({modkey}, "k", function() awful.client.focus.byidx(-1) end,
             {description = "focus previous by index", group = "client"}),
   awful.key({modkey, "Shift"}, "j", function() awful.client.swap.byidx(1) end,
             {description = "swap with next client by index", group = "client"}),
   awful.key({modkey, "Shift"}, "k",
             function() awful.client.swap.byidx(-1) end, {
       description = "swap with previous client by index",
       group = "client"
   }), awful.key({modkey}, "u", awful.client.urgent.jumpto,
                 {description = "jump to urgent client", group = "client"}),

                 awful.key({ modkey,           }, "Tab",
                 function ()
                     -- awful.client.focus.history.previous()
                     awful.client.focus.byidx(-1)
                     if client.focus then
                         client.focus:raise()
                     end
                 end),
             
             awful.key({ modkey, "Shift"   }, "Tab",
                 function ()
                     -- awful.client.focus.history.previous()
                     awful.client.focus.byidx(1)
                     if client.focus then
                         client.focus:raise()
                     end
                 end),



})

-- Awesomewm
awful.keyboard.append_global_keybindings({
   -- Volume control
   awful.key({}, "XF86AudioRaiseVolume",
             function() awful.spawn("pamixer -i 3") end,
             {description = "increase volume", group = "awesome"}),
   awful.key({}, "XF86AudioLowerVolume",
             function() awful.spawn("pamixer -d 3") end,
             {description = "decrease volume", group = "awesome"}),
   awful.key({}, "XF86AudioMute", function() awful.spawn("pamixer -t") end,
             {description = "mute volume", group = "awesome"}), -- Media Control
   awful.key({}, "XF86AudioPlay",
             function() awful.spawn("playerctl play-pause") end,
             {description = "toggle playerctl", group = "awesome"}),
   awful.key({}, "XF86AudioPrev",
             function() awful.spawn("playerctl previous") end,
             {description = "playerctl previous", group = "awesome"}),
   awful.key({}, "XF86AudioNext", function() awful.spawn("playerctl next") end,
             {description = "playerctl next", group = "awesome"}),

   -- Screen Shots/Vids
   awful.key({}, "Print", function()
       awful.spawn(apps.screenshot
    )
   end, {description = "take a screenshot", group = "awesome"}),
  
   -- Awesome stuff
   awful.key({modkey}, "F1", hotkeys_popup.show_help,
             {description = "show help", group = "awesome"}),

   awful.key({modkey}, "Escape", awful.tag.history.restore,
             {description = "go back", group = "tag"}),

   awful.key({modkey}, "x",
             function() require("ui.pop.exitscreen").exit_screen_show() end,
             {description = "show exit screen", group = "awesome"}),

   awful.key({modkey, "Shift"}, "d",
             function() awesome.emit_signal("panel::open") end,
             {description = "show panel", group = "awesome"}),

   awful.key({modkey, "Control"}, "r", awesome.restart,
             {description = "reload awesome", group = "awesome"}),

})

-- Launcher and screen
awful.keyboard.append_global_keybindings({
    awful.key({modkey}, "r", function() menubar.show() end,
    {description = "application launcher", group = "launcher"}),

   awful.key({modkey, "Control"}, "j",
             function() awful.screen.focus_relative(1) end,
             {description = "focus the next screen", group = "screen"}),

   awful.key({modkey, "Control"}, "k",
             function() awful.screen.focus_relative(-1) end,
             {description = "focus the previous screen", group = "screen"}),

   awful.key({modkey}, "t", function() awful.spawn(apps.terminal) end,
             {description = "open a terminal", group = "launcher"}),

   awful.key({modkey}, "e", function() awful.spawn(apps.filebrowser) end,
             {description = "open file browser", group = "launcher"}),

   awful.key({modkey}, "l", function() awful.tag.incmwfact(0.05) end,
             {description = "increase master width factor", group = "layout"}),
   awful.key({modkey}, "h", function() awful.tag.incmwfact(-0.05) end,
             {description = "decrease master width factor", group = "layout"}),

   awful.key({modkey, "Shift"}, "h",
             function() awful.tag.incnmaster(1, nil, true) end, {
       description = "increase the number of master clients",
       group = "layout"
   }), 
   
   awful.key({modkey, "Shift"}, "l",
                 function() awful.tag.incnmaster(-1, nil, true) end, {
       description = "decrease the number of master clients",
       group = "layout"
   }), 
   
   awful.key({modkey, "Control"}, "h",
                 function() awful.tag.incncol(1, nil, true) end, {
       description = "increase the number of columns",
       group = "layout"
   }), 
   
   
   awful.key({modkey, "Control"}, "l",
                 function() awful.tag.incncol(-1, nil, true) end, {
       description = "decrease the number of columns",
       group = "layout"
   }), 
   
   awful.key({modkey}, "space", function() awful.layout.inc(1) end,
                 {description = "select next", group = "layout"}),

   awful.key({modkey, "Shift"}, "space", function() awful.layout.inc(-1) end,
             {description = "select previous", group = "layout"}),        

   awful.key({modkey, "Control"}, "n", function()
       local c = awful.client.restore()
       -- Focus restored client
       if c then
           c:emit_signal("request::activate", "key.unminimize", {raise = true})
       end
   end, {description = "restore minimized", group = "client"})
})



-- Client management keybinds
client.connect_signal("request::default_keybindings", function()
   awful.keyboard.append_client_keybindings({
    awful.key({ modkey}, "m",
    function (c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end,
    {description = "toggle fullscreen", group = "client"}),
       awful.key({modkey}, "q", function(c) c:kill() end,
                 {description = "close", group = "client"}),
       awful.key({modkey}, "f", awful.client.floating.toggle,
                 {description = "toggle floating", group = "client"}),

        awful.key({modkey,"Shift"}, "m", lain.util.magnify_client,
                 {description = "magnify client", group = "client"}),
       
       awful.key({modkey, "Control"}, "Return",
                 function(c) c:swap(awful.client.getmaster()) end,
                 {description = "move to master", group = "client"}),
       awful.key({modkey}, "o", function(c) c:move_to_screen() end,
                 {description = "move to screen", group = "client"}),
       --  awful.key({ modkey, "Shift"   }, "t",      function (c) c.ontop = not c.ontop            end,
       --            {description = "toggle keep on top", group = "client"}),
       awful.key({modkey, shift}, "b", function(c)
           c.floating = not c.floating
           c.width = 400
           c.height = 200
           awful.placement.bottom_right(c)
           c.sticky = not c.sticky
       end, {description = "toggle keep on top", group = "client"}),

       awful.key({modkey}, "n", function(c)
           -- The client currently has the input focus, so it cannot be
           -- minimized, since minimized clients can't have the focus.
           c.minimized = true
       end, {description = "minimize", group = "client"}),

       -- On the fly padding change
       awful.key({modkey, shift}, "=",
                 function() helpers.resize_padding(5) end,
                 {description = "add padding", group = "screen"}),
       awful.key({modkey, shift}, "-",
                 function() helpers.resize_padding(-5) end,
                 {description = "subtract padding", group = "screen"}),

       -- On the fly useless gaps change
       awful.key({modkey}, "=", function() helpers.resize_gaps(5) end,
                 {description = "add gaps", group = "screen"}),

       awful.key({modkey}, "-", function() helpers.resize_gaps(-5) end,
                 {description = "subtract gaps", group = "screen"}),
       -- Single tap: Center client 
       -- Double tap: Center client + Floating + Resize

    -- Show/hide wibox
    awful.key({ modkey }, "b", function ()
        for s in screen do
            s.mywibox.visible = not s.mywibox.visible
            if s.mybottomwibox then
                s.mybottomwibox.visible = not s.mybottomwibox.visible
            end
        end
    end,
    {description = "toggle wibox", group = "awesome"}),
   })
end)

-- Num row keybinds
awful.keyboard.append_global_keybindings({
   awful.key {
       modifiers = {modkey},
       keygroup = "numrow",
       description = "only view tag",
       group = "tag",
       on_press = function(index)
           local screen = awful.screen.focused()
           local tag = screen.tags[index]
           if tag then tag:view_only() end
       end
   }, awful.key {
       modifiers = {modkey, "Control"},
       keygroup = "numrow",
       description = "toggle tag",
       group = "tag",
       on_press = function(index)
           local screen = awful.screen.focused()
           local tag = screen.tags[index]
           if tag then awful.tag.viewtoggle(tag) end
       end
   }, awful.key {
       modifiers = {modkey, "Shift"},
       keygroup = "numrow",
       description = "move focused client to tag",
       group = "tag",
       on_press = function(index)
           if client.focus then
               local tag = client.focus.screen.tags[index]
               if tag then client.focus:move_to_tag(tag) end
           end
       end
   }, awful.key {
       modifiers = {modkey, "Control", "Shift"},
       keygroup = "numrow",
       description = "toggle focused client on tag",
       group = "tag",
       on_press = function(index)
           if client.focus then
               local tag = client.focus.screen.tags[index]
               if tag then client.focus:toggle_tag(tag) end
           end
       end
   }, awful.key {
       modifiers = {modkey},
       keygroup = "numpad",
       description = "select layout directly",
       group = "layout",
       on_press = function(index)
           local t = awful.screen.focused().selected_tag
           if t then t.layout = t.layouts[index] or t.layout end
       end
   }
})

client.connect_signal("request::default_mousebindings", function()
   awful.mouse.append_client_mousebindings({
       awful.button({}, 1, function(c)
           c:activate{context = "mouse_click"}
       end), 
       

       awful.button({modkey}, 1, function(c)
           c:activate{context = "mouse_click", action = "mouse_move"}
       end), 
       awful.button({modkey}, 3, function(c)
           c:activate{context = "mouse_click", action = "mouse_resize"}
       end)
   })
end)


