local gears = require("gears")
local awful = require("awful")

-- List of apps to run on start-up
local run_on_start_up = {
    "picom -b --experimental-backends ",
    'openrgb --startminimized --profile "boot"',
    'exec /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1'
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
 awful.spawn.with_shell("sh $HOME/.fehbg &")

apps = {
    terminal = "sakura",
    screenshot = "scrot ~/Pictures/Screenshots/%Y-%m-%d_%H%M%S-$wx$h_scr<ot.png",
    screenshot2 = "scrot -u ~/Pictures/Screenshots/%Y-%m-%d_%H%M%S-$wx$h_scr<ot.png",
    filebrowser = "pcmanfm",
    editor_cmd = "nvim<"
}

os.execute("xset s 3600 3600")
