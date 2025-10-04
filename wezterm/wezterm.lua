local wezterm = require 'wezterm'

local config = wezterm.config_builder()

local act = wezterm.action

config.color_scheme = 'Breeze (Gogh)'
-- config.color_scheme = 'Chalk'
-- config.color_scheme = 'DimmedMonokai'
-- config.color_scheme = 'Firewatch'
-- config.color_scheme = 'Glacier'
-- config.color_scheme = 'GruvboxDark'
-- config.color_scheme = 'MaterialDark'
-- Good colors @ spacedust
-- config.color_scheme = 'Violet Dark'

config. window_background_opacity = 0.95

config.font = wezterm.font 'FiracodeNerdFont'
config.font_size = 10.0

config.max_fps = 80

config.default_prog = { 'fish' }
config.default_cwd = "/home/jonasc/Desktop/Desktop/"

local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

local function line_leader(window)
    if window:leader_is_active() then
        return ' LEADER '
    end
    return ' leader '
end

tabline.setup({
  options = {
    icons_enabled = true,
    tabs_enabled = true,
    theme_overrides = {
        normal_mode = {
            a = { fg = "252525", bg = "#a0b7ec" },
            b = { fg = "252525", bg = "#6182d7" },
            c = { fg = "e1e1e1", bg = "#3e4739" },
            z = { fg = "252525", bg = "#a0b7ec" },
            y = { fg = "252525", bg = "#6182d7" },
            x = { fg = "e1e1e1", bg = "#3e4739" },
        },
        tab = {
            active = { fg = "#252525", bg = "#ffcf23" },
            inactive = { fg = "#e1e1e1", bg = "#3e4739" },
            inactive_hover = { fg = "#ffcf23", bg = "#273022" },
        },
    },
    section_separators = {
      left = wezterm.nerdfonts.pl_left_hard_divider,
      right = wezterm.nerdfonts.pl_right_hard_divider,
    },
    component_separators = {
      left = wezterm.nerdfonts.pl_left_soft_divider,
      right = wezterm.nerdfonts.pl_right_soft_divider,
    },
    tab_separators = {
      left = wezterm.nerdfonts.pl_left_hard_divider,
      right = wezterm.nerdfonts.pl_right_hard_divider,
    },
  },
  sections = {
    tabline_a = { line_leader },
    tabline_b = { 'workspace' },
    tabline_c = { ' ' },
    tab_active = {
      'index',
      { 'parent', padding = 0 },
      '/',
      { 'cwd', padding = { left = 0, right = 1 } },
      { 'zoomed', padding = { left = 0, right = 1 } },
    },
    tab_inactive = { 'index', { 'process', padding = { left = 0, right = 1 } } },
    tabline_x = { ' ' },
    tabline_y = { 'cpu' },
    tabline_z = { 'battery' },
    --tabline_z = { ' ' },
  },
  extensions = {},
})
config.tab_bar_at_bottom = true

tabline.apply_to_config(config)
-- config.window_decorations = "TITLE | RESIZE"
config.window_decorations = "NONE"

config.leader = { key = ' ', mods = 'CTRL', timeout_milliseconds = 60000 }
config.keys = {
	{
		mods = 'LEADER',
		key = 'c',
		action = act.SpawnTab 'CurrentPaneDomain'
	},
	{
		mods = 'LEADER | SHIFT',
		key = '<',
		action = act.MoveTabRelative(-1)
	},
	{
		mods = 'LEADER | SHIFT',
		key = '>',
		action = act.MoveTabRelative(1)
	},
	{
		mods = 'LEADER | SHIFT',
		key = '|',
		action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }
	},
	{
		mods = 'LEADER',
		key = '-',
		action = act.SplitVertical { domain = 'CurrentPaneDomain' }
	},
	{
		mods = 'LEADER',
		key = 'm',
		action = act.TogglePaneZoomState
	},
	{
		mods = 'LEADER',
		key = ',',
		action = act.RotatePanes 'Clockwise'
	},
	{
		mods = 'LEADER',
		key = '.',
		action = act.PaneSelect { mode = 'SwapWithActive' }
	},
	{
		mods = 'CTRL | SHIFT',
		key = 'h',
		action = act.AdjustPaneSize({ 'Left', 5})
	},
	{
		mods = 'CTRL | SHIFT',
		key = 'j',
		action = act.AdjustPaneSize({ 'Down', 5})
	},
	{
		mods = 'CTRL | SHIFT',
		key = 'k',
		action = act.AdjustPaneSize({ 'Up', 5})
	},
	{
		mods = 'CTRL | SHIFT',
		key = 'l',
		action = act.AdjustPaneSize({ 'Right', 5})
	},
	{
		mods = 'CTRL | ALT',
		key = 'h',
		action = act.ActivatePaneDirection 'Left'
	},
	{
		mods = 'CTRL | ALT',
		key = 'j',
		action = act.ActivatePaneDirection 'Down'
	},
	{
		mods = 'CTRL | ALT',
		key = 'k',
		action = act.ActivatePaneDirection 'Up'
	},
	{
		mods = 'CTRL | ALT',
		key = 'l',
		action = act.ActivatePaneDirection 'Right'
	},
	{
    	mods = 'LEADER',
    	key = 'w',
    	action = act.ShowLauncherArgs { flags = 'WORKSPACES' },
    },
    {
        mods = 'LEADER | SHIFT',
        key = 'W',
        action = act.PromptInputLine {
            description = 'Enter name for new workspace',
            action = wezterm.action_callback(function(window, pane, line)
                if line then
                    window:perform_action(
                        act.SwitchToWorkspace {
                            name = line,
                        },
                        pane
                   )
                end
            end),
        },
    },
}
for i = 1, 9 do
	table.insert(config.keys, {
    	mods = 'CTRL',
    	key = tostring(i),
    	action = act.ActivateTab(i-1),
	})
	table.insert(config.keys, {
    	mods = 'LEADER',
    	key = tostring(i),
    	action = act.MoveTab(i-1),
	})
end

return config
