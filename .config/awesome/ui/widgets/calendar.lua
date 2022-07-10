local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local shape = require("gears.shape")


local calendar = {}

function calendar.popup()
	local popup = awful.popup{
		widget = {
			{
				date = os.date('*t'),
				font = beautiful.font,
				spacing = 11,
				widget = wibox.widget.calendar.month,
			},
			margins = 14,
			widget = wibox.container.margin,
		},
		ontop = true,
		shape = shape.rounded_rect,
		border_color = beautiful.border_focus,
		border_width = beautiful.border_width,
		visible = false,
		placement = awful.placement.bottom,
	}
	return popup
end

function calendar.widget(popup)
	local widget = wibox.widget{
		{
			{
				{
					{
						id = "clock",
						font = beautiful.font,
						format = '%a %d %b, %H:%M',
						buttons = awful.button({ }, 1, function() popup.visible = not popup.visible end),
						widget = wibox.widget.textclock,
					},
					right = 8,
					left = 8,
					top = 7,
					bottom = 7,
					layout = wibox.container.margin,
				},
				shape = function (cr, width, height)
								shape.rounded_rect(cr, width, height, 12) end,
				shape_border_width = beautiful.border_width,
				fg = beautiful.fg_normal,
				shape_border_color = beautiful.widget_border_color1,
				bg = beautiful.bg_normal,
				widget = wibox.container.background,
			},
			top = 3,
			bottom = 3,
			layout = wibox.container.margin,
		},
		layout = wibox.layout.fixed.horizontal
	}
	return widget
end

return calendar
