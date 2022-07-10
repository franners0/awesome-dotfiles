local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local shape = require("gears.shape")
local utils = require("ui.widgets.utils")


local cmd_ram_total = "top -b -n 1 | awk '/MiB Mem/ { print $4 }'"
local cmd_ram_used = "top -b -n 1 | awk '/MiB Mem/ { print $8 }'"
local cmd_swap_used = "top -b -n 1 | awk '/MiB Swap/ { print $7 }'"

local ram_widget = wibox.widget{
	{
		{	

			{
			{	
				{
				id = "icon",
				image = beautiful.widget_mem,
				widget = wibox.widget.imagebox,
				},
				top = 2,
				bottom = 2,
				left = 7,
				layout = wibox.container.margin,
			},
			{
				{
					id = "text",
					font = beautiful.font,
					markup = '0/0GBs',
					widget = wibox.widget.textbox,
				},
				right = 8,
				left = 0,
				layout = wibox.container.margin,
			},
			layout = wibox.layout.fixed.horizontal
			},
			shape = function (cr, width, height)
							shape.rounded_rect(cr, width, height, 12) end,
			shape_border_width = beautiful.border_width,
			shape_border_color = beautiful.widget_border_color2,
			widget = wibox.container.background,
		},
		top = 3,
		bottom = 3,

		layout = wibox.container.margin,
	},
	layout = wibox.layout.align.horizontal
}

local ram_tt = awful.tooltip{
	objects = { ram_widget },
	shape = function (cr, width, height) shape.rounded_rect(cr, width, height, 10) end,
	border_color = beautiful.border_focus,
	border_width = beautiful.border_width,
	bg = beautiful.bg_normal,
	mode = "outside",
}

local total_ram = string.format("%.1f", tostring(tonumber(utils.os_output(cmd_ram_total)) / 1000))

awful.widget.watch("sh -c \"" .. cmd_ram_used .. " ; " .. cmd_swap_used .. "\"", 4, function(widget, stdout)
	local split_stdout = utils.split_str(stdout, "\n")
	ram_widget:get_children_by_id("text")[1].markup = '<span foreground="' .. beautiful.fg_focus .. '"> </span> ' ..
		string.format("%.1f", tostring((tonumber(split_stdout[1]) / 1000))) .. '/' .. total_ram .. 'Gbs'
	ram_tt.text = "RAM: " .. split_stdout[1] .. "\nSwap: " .. split_stdout[2]
end, ram_widget)

return ram_widget
