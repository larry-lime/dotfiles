---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

theme.font = "FiraSans 8"

-- Pop!_OS colors
local colors = {
	black = "#333333",
	red = "#CC0000",
	green = "#4E9A06",
	yellow = "#C4A000",
	blue = "#3465A4",
	magenta = "#75507B",
	cyan = "#06989A",
	white = "#D3D7CF",
	bright_black = "#88807C",
	bright_red = "#F15D22",
	bright_green = "#73C48F",
	bright_yellow = "#FFCE51",
	bright_blue = "#48B9C7",
	bright_magenta = "#AD7FA8",
	bright_cyan = "#34E2E2",
	bright_white = "#EEEEEC",
}

-- Get Pop!_OS color theme
theme.bg_normal = colors.black
theme.bg_focus = colors.bright_black
theme.bg_urgent = colors.bright_cyan
theme.bg_minimize = "#3B4252"
theme.bg_systray = theme.bg_normal

theme.fg_normal = colors.white
theme.fg_focus = colors.bright_white
theme.fg_urgent = colors.bright_white
theme.fg_minimize = colors.white

theme.border_width = dpi(2)
theme.useless_gap = dpi(3)
theme.border_normal = colors.bright_black
theme.border_focus = colors.cyan
theme.border_marked = "#BF616A"

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
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path .. "default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
local function get_wallpaper()
	local wallpaper_dir = os.getenv("HOME") .. "/.config/awesome/images/"
	local wallpaper_list = {}
	local wallpaper = nil

	for file in io.popen("ls -A " .. wallpaper_dir):lines() do
		table.insert(wallpaper_list, file)
	end

	math.randomseed(os.time())

	if #wallpaper_list > 0 then
		wallpaper = wallpaper_dir .. wallpaper_list[math.random(#wallpaper_list)]
	end

	return wallpaper
end

-- theme.wallpaper = "~/.dotfiles/awesome/images/kate-hazen-pop-m3lvin.png"
theme.wallpaper = "/home/larrylime/.dotfiles/awesome/images/nasa-53884.jpg"
-- theme.wallpaper = get_wallpaper()

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path .. "default/layouts/fairhw.png"
theme.layout_fairv = themes_path .. "default/layouts/fairvw.png"
theme.layout_floating = themes_path .. "default/layouts/floatingw.png"
theme.layout_magnifier = themes_path .. "default/layouts/magnifierw.png"
theme.layout_max = themes_path .. "default/layouts/maxw.png"
theme.layout_fullscreen = themes_path .. "default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path .. "default/layouts/tilebottomw.png"
theme.layout_tileleft = themes_path .. "default/layouts/tileleftw.png"
theme.layout_tile = themes_path .. "default/layouts/tilew.png"
theme.layout_tiletop = themes_path .. "default/layouts/tiletopw.png"
theme.layout_spiral = themes_path .. "default/layouts/spiralw.png"
theme.layout_dwindle = themes_path .. "default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path .. "default/layouts/cornernww.png"
theme.layout_cornerne = themes_path .. "default/layouts/cornernew.png"
theme.layout_cornersw = themes_path .. "default/layouts/cornersww.png"
theme.layout_cornerse = themes_path .. "default/layouts/cornersew.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
