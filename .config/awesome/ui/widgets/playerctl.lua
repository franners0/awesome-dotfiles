local wibox = require("wibox")
local gears     = require("gears")
local lgi = require("lgi")

local playerctl = require("modules.bling").signal.playerctl.lib()


local title_widget = wibox.widget {
    markup = '',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local artist_widget = wibox.widget {
    markup = '',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}


local media = wibox.widget({
	layout = wibox.layout.align.horizontal,
	expand = "none",
	nil,
	{
		layout = wibox.layout.fixed.horizontal,
        artist_widget,
		title_widget,
	},
	nil,
})



playerctl:connect_signal("metadata",
function(_, title, artist, player_name)

    title_widget:set_markup_silently(title)
    if title == "" then
        title_widget:set_markup_silently("")
    else
        title_widget:set_markup_silently(title .. " ")
    end

    if artist == "" then
        artist_widget:set_markup_silently("")
    else
        artist_widget:set_markup_silently(" " .. artist .. " - ")
    end
    
end)

playerctl:connect_signal("no_players",
function(_)
    title_widget:set_markup_silently("")
    artist_widget:set_markup_silently("")
end)

return media