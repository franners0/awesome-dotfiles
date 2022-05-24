---------------------------
-- Default awesome theme --
---------------------------
local gears = require("gears")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
colors = require("themes.chameleon.colors")


local theme = {}

theme.font          = "SF Pro Rounded 8"



theme.bg_normal     = colors.color0
theme.bg_focus      = colors.color9
theme.bg_urgent     = colors.color10
theme.bg_minimize   = colors.color11
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = colors.color15
theme.fg_focus      = theme.bg_normal
theme.fg_urgent     = theme.bg_normal
theme.fg_minimize   = theme.bg_normal

theme.useless_gap   = dpi(5)
theme.border_width  = dpi(1)
theme.border_normal = colors.color2
theme.border_focus  = colors.color1
theme.border_marked = colors.color10

theme.titlebar_bg = colors.color0
theme.titlebar_bg_focus = colors.color0
theme.titlebar_fg = colors.color15
theme.titlebar_fg_focus = colors.color15
theme.tooltip_fg = colors.color15
theme.tooltip_bg = colors.color1

theme.tasklist_fg_minimize = colors.color15
theme.tasklist_bg_minimize = colors.color8
theme.tasklist_shape_border_width = 2
theme.tasklist_shape_border_color = colors.color0
theme.tasklist_plain_task_name = true
theme.tasklist_disable_task_name = false
theme.tasklist_disable_icon = false
theme.tasklist_spacing = 5
theme.tasklist_align = center
theme.tasklist_shape = gears.shape.rounded_bar
theme.widget_border_width = dpi(3)
theme.wibar_ontop = false
theme.wibar_border_width = dpi(3)
theme.wibar_border_color = colors.color0 
theme.wibar_opacity = 0.9 
theme.systray_icon_spacing = 5
theme.wibar_height = dpi(36) + theme.widget_border_width
theme.wibar_margin = dpi(15)
theme.wibar_spacing = dpi(15)
theme.wibar_align = center

-- Try to determine if we are running light or dark colorscheme:
local bg_numberic_value = 0;
for s in theme.bg_normal:gmatch("[a-fA-F0-9][a-fA-F0-9]") do
    bg_numberic_value = bg_numberic_value + tonumber("0x"..s);
end
local is_dark_bg = (bg_numberic_value < 383)

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
theme.notification_margin = dpi(1)
theme.notification_width = dpi(300)
theme.notification_height = dpi(100)
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu = "->"
theme.menu_height = dpi(25)
theme.menu_width  = dpi(130)
theme.menu_border_width = dpi(1)
theme.menu_border_color = colors.color1


-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
-- Define the image to load
--local icon_dir = "/home/fran/.config/awesome/themes/chameleon/icons/titlebar/"
local icon_dir = gfs.get_configuration_dir() .. "/themes/chameleon/icons/titlebar/"

--local icon_dir = .."themes/chameleon/icons/titlebar/"
-- Close Button
theme.titlebar_close_button_normal = icon_dir .. 'normal.svg'
theme.titlebar_close_button_focus  = icon_dir .. 'close_focus.svg'
theme.titlebar_close_button_normal_hover = icon_dir .. 'close_focus_hover.svg'
theme.titlebar_close_button_focus_hover  = icon_dir .. 'close_focus_hover.svg'

-- Minimize Button
theme.titlebar_minimize_button_normal = icon_dir .. 'normal.svg'
theme.titlebar_minimize_button_focus  = icon_dir .. 'minimize_focus.svg'
theme.titlebar_minimize_button_normal_hover = icon_dir .. 'minimize_focus_hover.svg'
theme.titlebar_minimize_button_focus_hover  = icon_dir .. 'minimize_focus_hover.svg'

-- Maximized Button (While Window is Maximized)
theme.titlebar_maximized_button_normal_active = icon_dir .. 'normal.svg'
theme.titlebar_maximized_button_focus_active  = icon_dir .. 'maximized_focus.svg'
theme.titlebar_maximized_button_normal_active_hover = icon_dir .. 'maximized_focus_hover.svg'
theme.titlebar_maximized_button_focus_active_hover  = icon_dir .. 'maximized_focus_hover.svg'

-- Maximized Button (While Window is not Maximized)
theme.titlebar_maximized_button_normal_inactive = icon_dir .. 'normal.svg'
theme.titlebar_maximized_button_focus_inactive  = icon_dir .. 'maximized_focus.svg'
theme.titlebar_maximized_button_normal_inactive_hover = icon_dir .. 'maximized_focus_hover.svg'
theme.titlebar_maximized_button_focus_inactive_hover  = icon_dir .. 'maximized_focus_hover.svg'

theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = icon_dir .. 'normal.svg'
theme.titlebar_floating_button_focus_inactive  = icon_dir .. 'maximized_focus.svg'
theme.titlebar_floating_button_normal_active = icon_dir .. 'normal.svg'
theme.titlebar_floating_button_focus_active  = icon_dir .. 'maximized_focus.svg'


theme = theme_assets.recolor_titlebar(theme, colors.color8, "normal")
theme.titlebar_close_button_focus = gears.color.recolor_image(theme.titlebar_close_button_focus, colors.color9)
theme.titlebar_maximized_button_focus_inactive = gears.color.recolor_image(theme.titlebar_maximized_button_focus_inactive, colors.color11)
theme.titlebar_maximized_button_focus_active = gears.color.recolor_image(theme.titlebar_maximized_button_focus_active, colors.color11)
theme.titlebar_minimize_button_focus = gears.color.recolor_image(theme.titlebar_minimize_button_focus, colors.color13)
theme.titlebar_floating_button_focus_inactive = gears.color.recolor_image(theme.titlebar_floating_button_focus_inactive, colors.color11)
theme.titlebar_floating_button_focus_active = gears.color.recolor_image(theme.titlebar_floating_button_focus_active, colors.color11)


theme.wallpaper = "/home/fran/.config/wpg/.current"

-- You can use your own layout icons like this:
theme = theme_assets.recolor_layout(theme, theme.fg_normal)
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus 
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "Papirus"

theme.window_switcher_widget_bg = colors.color0             -- The bg color of the widget
theme.window_switcher_widget_border_width = 3            -- The border width of the widget
theme.window_switcher_widget_border_radius = 0           -- The border radius of the widget
theme.window_switcher_widget_border_color = colors.color1  -- The border color of the widget
theme.window_switcher_clients_spacing = 20               -- The space between each client item
theme.window_switcher_client_icon_horizontal_spacing = 5 -- The space between client icon and text
theme.window_switcher_client_width = 150                 -- The width of one client widget
theme.window_switcher_client_height = 250                -- The height of one client widget
theme.window_switcher_client_margins = 10                -- The margin between the content and the border of the widget
theme.window_switcher_thumbnail_margins = 10             -- The margin between one client thumbnail and the rest of the widget
theme.thumbnail_scale = true                           -- If set to true, the thumbnails fit policy will be set to "fit" instead of "auto"
theme.window_switcher_name_margins = 10                  -- The margin of one clients title to the rest of the widget
theme.window_switcher_name_valign = "center"             -- How to vertically align one clients title
theme.window_switcher_name_forced_width = 200            -- The width of one title
--             -- The font of all titles
theme.window_switcher_name_normal_color = colors.color15   -- The color of one title if the client is unfocused
theme.window_switcher_name_focus_color = colors.color10    -- The color of one title if the client is focused
theme.window_switcher_icon_valign = "center"             -- How to vertically align the one icon
theme.window_switcher_icon_width = 40                

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
