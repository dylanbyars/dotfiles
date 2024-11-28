local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Fonts
config.font = wezterm.font("Hasklug Nerd Font")
config.font_size = 14.0
config.line_height = 1.05
config.harfbuzz_features = { "calt=1", "clig=1", "liga=1" }

-- Window
config.window_decorations = "RESIZE"
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_max_width = 25
config.enable_scroll_bar = false
config.audible_bell = "Disabled"
config.check_for_updates = false
-- config.window_padding = {
-- 	left = 50,
-- 	right = 50,
-- 	top = 50,
-- 	bottom = 50,
-- }

-- Pane
local function rename_tab(window, pane)
	window:perform_action(
		wezterm.action.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
		pane
	)
end

-- Key bindings
config.keys = {
	-- go to tab
	{ key = "1", mods = "CMD", action = wezterm.action({ ActivateTab = 0 }) },
	{ key = "2", mods = "CMD", action = wezterm.action({ ActivateTab = 1 }) },
	{ key = "3", mods = "CMD", action = wezterm.action({ ActivateTab = 2 }) },
	{ key = "4", mods = "CMD", action = wezterm.action({ ActivateTab = 3 }) },
	{ key = "5", mods = "CMD", action = wezterm.action({ ActivateTab = 4 }) },
	{ key = "6", mods = "CMD", action = wezterm.action({ ActivateTab = 5 }) },
	{ key = "7", mods = "CMD", action = wezterm.action({ ActivateTab = 6 }) },
	{ key = "8", mods = "CMD", action = wezterm.action({ ActivateTab = 7 }) },
	{ key = "9", mods = "CMD", action = wezterm.action({ ActivateTab = 8 }) },
	-- split window
	{ key = "-", mods = "CTRL", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{ key = "\\", mods = "CTRL", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },

	{ key = "]", mods = "ALT", action = wezterm.action({ RotatePanes = "Clockwise" }) },

	{ key = "h", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
	{ key = "l", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
	{ key = "k", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
	{ key = "j", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Down" }) },

	-- toggle pane zoom
	{ key = ";", mods = "CTRL", action = wezterm.action.TogglePaneZoomState },

	-- New key binding for renaming tab
	{ key = "I", mods = "CTRL|SHIFT", action = wezterm.action_callback(rename_tab) },

	{ key = "LeftArrow", mods = "SHIFT|ALT", action = wezterm.action.MoveTabRelative(-1) },
	{ key = "RightArrow", mods = "SHIFT|ALT", action = wezterm.action.MoveTabRelative(1) },
}

-- Color scheme (Tokyo Night)
config.color_scheme = "Tokyo Night"

return config
