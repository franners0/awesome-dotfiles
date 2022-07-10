local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi       = require("beautiful").xresources.apply_dpi
local shape = require("gears.shape")
local utils = require("ui.widgets.utils")


local cmd_usg = "top -bn1 | awk '/Cpu/ { print $2 }'"
local cmd_temp = "sensors | grep 'Tccd2' | awk '{ print $2 }'"

local cpu_widget = wibox.widget{
	{
		{	
			{
			{	
				{
				id = "icon",
				image = beautiful.widget_cpu,
				widget = wibox.widget.imagebox,
				},
				top = 2,
				bottom = 2,
				left = 6,
				layout = wibox.container.margin,
			},
			{
				{
					id = "text",
					font = beautiful.font,
					markup = '0%',
					widget = wibox.widget.textbox,
				},
				right = 6,
				layout = wibox.container.margin,
				
			},
			layout = wibox.layout.fixed.horizontal
			},
			shape = function (cr, width, height)
							shape.rounded_rect(cr, width, height, 12) end,
			shape_border_width = beautiful.border_width,
			shape_border_color = beautiful.widget_border_color1,
			widget = wibox.container.background,

		},
		top = 3,
		bottom = 3,
		layout = wibox.container.margin,
	},
	layout = wibox.layout.align.horizontal
}

local cpu_tt = awful.tooltip{
	shape = function (cr, width, height) shape.rounded_rect(cr, width, height, 10) end,
	border_color = beautiful.border_focus,
	border_width = beautiful.border_width,
	bg = beautiful.bg_normal,
	objects = { cpu_widget },
	mode = "outside",
}


awful.widget.watch("sh -c \"" .. cmd_usg .. " ; " .. cmd_temp .. "\"", 2, function(widget, stdout)
	local split_stdout = utils.split_str(stdout, "\n")
	cpu_widget:get_children_by_id("text")[1].markup = '<span foreground="' .. beautiful.fg_focus .. '"> </span> ' .. utils.split_str(split_stdout[1], ".")[1] .. '%'
	cpu_tt.text = "Usg: " .. split_stdout[1] .. "%\nTemp: " .. split_stdout[2]
end, cpu_widget)


return cpu_widget
