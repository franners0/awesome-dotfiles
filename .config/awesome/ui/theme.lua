-- This file will declare the colors and geometry for various UI elements across AwesomeWM, it also depends on WPG for generating the colors from your wallpaper,
-- dont forget to symlink the "colors.lua" file to your WPG template folder ($HOME/.config/wpg/templates/)

local gears = require("gears")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local gtk = require("beautiful.gtk")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local math = math



helpers = require("ui.helpers")

local theme = dofile(themes_path .. "default/theme.lua")

theme.gtk = gtk.get_theme_variables()



theme.icon_theme = "Papirus"

theme.font          = "SF Pro Rounded 8"

theme.gtk.button_border_radius = dpi(theme.gtk.button_border_radius or 0)
theme.gtk.button_border_width = dpi(theme.gtk.button_border_width or 1)

theme.bg_normal     = theme.gtk.base_color
theme.bg_focus      = theme.gtk.bg_color
theme.bg_urgent     = theme.gtk.error_bg_color
theme.bg_minimize   = helpers.blend(theme.bg_normal, theme.bg_focus)
theme.bg_systray    = theme.wibar_bg

theme.fg_normal     = theme.gtk.fg_color
theme.fg_focus      = theme.gtk.selected_fg_color
theme.fg_urgent     = theme.gtk.error_fg_color
theme.fg_minimize   = theme.bg_normal

theme.useless_gap   = dpi(6)
theme.border_width  = dpi(1.3)
theme.border_normal = helpers.lighten(theme.bg_normal, 5)
theme.border_focus  = helpers.lighten(theme.bg_normal, 15)
theme.border_marked = theme.widget_border_color1

theme.titlebar_bg = theme.gtk.wm_bg_color
theme.titlebar_bg_focus = theme.gtk.wm_bg_color
theme.titlebar_fg = helpers.darken(theme.gtk.fg_color, 60)
theme.titlebar_fg_focus = theme.gtk.fg_color
theme.tooltip_fg = theme.gtk.tooltip_fg_color
theme.tooltip_bg = theme.gtk.tooltip_bg_color




theme.tasklist_plain_task_name = true
theme.tasklist_disable_task_name = true
theme.tasklist_disable_icon = false
theme.tasklist_spacing = 5

theme.tasklist_bg_normal = theme.bg_normal
theme.tasklist_shape_border_color = theme.border_focus

theme.tasklist_shape_border_color_minimized = helpers.darken(theme.tasklist_shape_border_color, 40)
theme.tasklist_fg_minimize = helpers.darken(theme.fg_normal, 40)
theme.tasklist_bg_minimize = helpers.darken(theme.tasklist_bg_normal, 40)

theme.tasklist_bg_focus = helpers.darken(theme.gtk.selected_bg_color, 60)
theme.tasklist_shape_border_color_focus = theme.gtk.selected_bg_color




theme.wibar_bg = theme.bg_normal .. "00"
theme.wibar_border_width = dpi(0)
theme.wibar_border_color = theme.border_focus
theme.wibar_opacity = 0.87
theme.systray_icon_spacing = 5
theme.wibar_height = dpi(33)

theme.widget_border_color1 = theme.gtk.selected_bg_color
theme.widget_border_color2 = helpers.darken(theme.gtk.selected_bg_color, 15)
theme.widget_border_color3 = helpers.lighten(theme.gtk.selected_bg_color, 15)

theme.taglist_bg_focus = theme.gtk.base_color
theme.taglist_fg_focus = theme.gtk.fg_color
theme.taglist_spacing = dpi(4)
theme.taglist_margin = dpi(4)
theme.taglist_font = theme.font
theme.taglist_disable_icon = true
theme.taglist_shape_focus = gears.shape.rounded_rect
theme.taglist_shape_border_width_focus = theme.border_width
theme.taglist_shape_border_color_focus =  theme.widget_border_color1

theme.notification_shape = function(cr,w,h)
    gears.shape.rounded_rect(cr,w,h, 12)
end
theme.notification_icon_size = dpi(90)
theme.notification_opacity = 0.8
theme.notification_border_color = theme.bg_normal
theme.notification_border_width = 0

theme.menu_submenu_icon = nil

theme.menu_submenu = "> "
theme.menu_height = dpi(35)
theme.menu_width  = dpi(135)
theme.menu_border_width = theme.border_width
theme.menu_margin = dpi(8)
theme.menu_border_color = theme.border_normal
theme.menu_opacity = 0.9


theme.menubar_bg_normal = theme.bg_normal
theme.menubar_bg_focus = theme.gtk.selected_bg_color
theme.menubar_border_width = dpi(3)
theme.menubar_border_color = theme.menubar_bg_normal

theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)




local icon_dir = gfs.get_configuration_dir() .. "/ui/icons/"

-- Titlebar

-- Titlebar button
theme.titlebar_button = icon_dir .. 'circle.svg'

-- Unfocused window buttons
theme.titlebar_close_button_normal = gears.color.recolor_image(theme.titlebar_button, helpers.darken(helpers.blend(theme.gtk.selected_bg_color, "#E74C3C"), 50))

theme.titlebar_minimize_button_normal = gears.color.recolor_image(theme.titlebar_button, helpers.darken(helpers.blend(theme.gtk.selected_bg_color, "#1ABC9C"), 50))

theme.titlebar_floating_button_normal_active = gears.color.recolor_image(theme.titlebar_button, helpers.darken(helpers.blend(theme.gtk.selected_bg_color, "#F4D03F"), 50))
theme.titlebar_floating_button_normal_inactive = gears.color.recolor_image(theme.titlebar_button, helpers.darken(helpers.blend(theme.gtk.selected_bg_color, "#F4D03F"), 50))

-- Focused window buttons
theme.titlebar_close_button_focus = gears.color.recolor_image(theme.titlebar_button, helpers.blend(theme.gtk.selected_bg_color, "#E74C3C"))

theme.titlebar_minimize_button_focus = gears.color.recolor_image(theme.titlebar_button, helpers.blend(theme.gtk.selected_bg_color, "#1ABC9C"))

theme.titlebar_floating_button_focus_inactive = gears.color.recolor_image(theme.titlebar_button, helpers.blend(theme.gtk.selected_bg_color, "#F4D03F"))
theme.titlebar_floating_button_focus_active = gears.color.recolor_image(theme.titlebar_button, helpers.blend(theme.gtk.selected_bg_color, "#F4D03F"))


-- Color when hovering on window buttons
theme.titlebar_close_button_focus_hover = gears.color.recolor_image(theme.titlebar_button, helpers.darken(helpers.blend(theme.gtk.selected_bg_color, "#E74C3C"), 20))

theme.titlebar_minimize_button_focus_hover = gears.color.recolor_image(theme.titlebar_button, helpers.darken(helpers.blend(theme.gtk.selected_bg_color, "#1ABC9C"), 20))

theme.titlebar_floating_button_focus_inactive_hover = gears.color.recolor_image(theme.titlebar_button, helpers.darken(helpers.blend(theme.gtk.selected_bg_color, "#F4D03F"), 20))
theme.titlebar_floating_button_focus_active_hover = gears.color.recolor_image(theme.titlebar_button, helpers.darken(helpers.blend(theme.gtk.selected_bg_color, "#F4D03F"), 20))



-- Menu

theme.menu_icon = icon_dir .. "arch.svg"
theme.menu_icon = gears.color.recolor_image(theme.menu_icon, theme.gtk.fg_color)


theme = theme_assets.recolor_layout(theme, theme.widget_border_color1)


theme.wallpaper = nil



theme.widget_mem                                = icon_dir .. "mem.svg"
theme.widget_mem = gears.color.recolor_image(theme.widget_mem, theme.gtk.fg_color)
theme.widget_cpu                                = icon_dir .. "cpu.svg"
theme.widget_cpu = gears.color.recolor_image(theme.widget_cpu, theme.gtk.fg_color)
theme.widget_temp                               = icon_dir .. "temp.svg"
theme.widget_temp = gears.color.recolor_image(theme.widget_temp, theme.gtk.fg_color)
theme.widget_net                                = icon_dir .. "net.svg"
theme.widget_net = gears.color.recolor_image(theme.widget_net, theme.gtk.fg_color)
theme.widget_hdd                                = icon_dir .. "hdd.svg"
theme.widget_hdd = gears.color.recolor_image(theme.widget_hdd, theme.gtk.fg_color)
theme.widget_vol                                = icon_dir.."vol.svg"
theme.widget_vol_low                            = icon_dir .. "vol_low.svg"
theme.widget_vol_no                             = icon_dir .. "vol_no.svg"
theme.widget_vol_mute                           = icon_dir .. "vol_mute.svg"
theme.widget_vol = gears.color.recolor_image(theme.widget_vol, theme.gtk.fg_color)
theme.widget_vol_mute = gears.color.recolor_image(theme.widget_vol_mute, theme.gtk.fg_color)
theme.widget_vol_low = gears.color.recolor_image(theme.widget_vol_low, theme.gtk.fg_color)
theme.widget_vol_no = gears.color.recolor_image(theme.widget_vol_no, theme.gtk.fg_color)
theme.tray_icon = icon_dir .. "tray.svg"
theme.tray_icon = gears.color.recolor_image(theme.tray_icon, theme.gtk.fg_color)




return theme
