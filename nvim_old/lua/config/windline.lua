local wl = require('windline')
local state = _G.WindLine.state
local base = require('windline.components.basic')
local git = require('windline.components.git')
local lsp = require('windline.components.lsp')

local basic = {}

local vi_mode = {
	["NORMAL"] =  { " NORMAL  ", { "black2", "yellow3" } },
	["INSERT"] =  { " INSERT  ", { "black2", "blue3" } },
	["REPLACE"] = { " REPLACE ", { "black2", "orange3" } },
	["VISUAL"] =  { " VISUAL  ", { "black2", "red3" } },
	["V-LINE"] =  { " V-LINE  ", { "black2", "purple3" } },
	["COMMAND"] = { " COMMAND ", { "black2", "green3" } },
}

basic.vi_mode = {
    name = "vi_mode",
    text = function()
        return {
			(vi_mode[state.mode[1]] or
			{ state.mode[1], { "white3", "black1" } }),
			{ " ", { (vi_mode[state.mode[1]] or {_,"white3"})[2][2], "black3" } },
		}
    end
}

basic.filename = {
    name = "filename",
    text = function()
        return {
			{ " %f ", { "yellow2", "black3", "bold" } },
			{ " ", { "black3", "black2", "bold" } },
		}
    end
}

basic.git = {
    width = 90,
    hl_colors = {
        green = { 'green3', 'black2' },
        red = { 'red3', 'black2' },
        blue = { 'blue3', 'black2' },
    },
    text = function(bufnr)
        if git.is_git(bufnr) then
            return {
                { git.diff_added({ format = ' %s' }), 'green' },
                { git.diff_removed({ format = '  %s' }), 'red' },
                { git.diff_changed({ format = '  %s' }), 'blue' },
            }
        end
        return ''
    end
}

basic.click_test = {
    text = function ()
        return "Click me"
    end,
    click = function ()
        print("Do click")
    end
}

basic.rainbow = {
    name = "rainbow",
    text = function()
        return {
			{ " ", { "black1", "black1" } },
			{ " ", { "black2", "black2" } },
			{ " ", { "black3", "black3" } },
			{ " ", { "red1", "red1" } },
			{ " ", { "red2", "red2" } },
			{ " ", { "red3", "red3" } },
			{ " ", { "orange1", "orange1" } },
			{ " ", { "orange2", "orange2" } },
			{ " ", { "orange3", "orange3" } },
			{ " ", { "yellow1", "yellow1" } },
			{ " ", { "yellow2", "yellow2" } },
			{ " ", { "yellow3", "yellow3" } },
			{ " ", { "green1", "green1" } },
			{ " ", { "green2", "green2" } },
			{ " ", { "green3", "green3" } },
			{ " ", { "blue1", "blue1" } },
			{ " ", { "blue2", "blue2" } },
			{ " ", { "blue3", "blue3" } },
			{ " ", { "purple1", "purple1" } },
			{ " ", { "purple2", "purple2" } },
			{ " ", { "purple3", "purple3" } },
			{ " ", { "white1", "white1" } },
			{ " ", { "white2", "white2" } },
			{ " ", { "white3", "white3" } },
		}
	end
}

basic.divider = { base.divider, "" }

basic.percent = {
    name = "percent",
    text = function()
        return {
			{ ' ', { "purple3", "black2" } },
			{ base.line_col_lua, { "black2", "purple3" } },
			{ base.progress_lua, { "black2", "purple3" } },
			{ "  " },
		}
    end
}

basic.lsp = {
    width = 90,
    hl_colors = {
        red = { 'red3', 'black3' },
        yellow = { 'yellow2', 'black3' },
        blue = { 'blue3', 'black3' },
    },
    text = function(bufnr)
        if lsp.check_lsp(bufnr) then
            return {
				{ '', { "black3", "black2" } },
				{ " ", { "black3", "black3"} },
                { lsp.lsp_error({ format = '  %s' }), 'red' },
                { lsp.lsp_warning({ format = '  %s' }), 'yellow' },
                { lsp.lsp_hint({ format = '  %s  ' }), 'blue' },
				{ "", { "black3", "black2" } },
            }
        end
        return ''
    end,
}

local default = {
	filetypes={"default"},
	active={
		basic.vi_mode,
		basic.filename,
		basic.divider,
		basic.lsp,
		basic.divider,
		basic.git,
		basic.percent,
	},
	inactive={
	},
}

wl.setup({
	colors_name = function(colors)
		
		-- 1 is darkest
		colors.red1 = "#4C0E10"
		colors.red2 = "#9B2326"
		colors.red3 = "#FF464B"

		colors.orange1 = "#8F4E1C"
		colors.orange2 = "#B5621F"
		colors.orange3 = "#C47942"

		colors.yellow1 = "#AB841D"
		colors.yellow2 = "#DBA81D"
		colors.yellow3 = "#E9BE62"

		colors.green1 = "#275716"
		colors.green2 = "#3AAB11"
		colors.green3 = "#78C25C"

		colors.blue1 = "#2D4495"
		colors.blue2 = "#3664E3"
		colors.blue3 = "#7082EA"

		colors.purple1 = "#46186D"
		colors.purple2 = "#771AC4"
		colors.purple3 = "#AF75DB"

		colors.black1 = "#000000"
		colors.black2 = "#252525"
		colors.black3 = "#545454"

		colors.white1 = "#B2B2B2"
		colors.white2 = "#E1E1E1"
		colors.white3 = "#FFFFFF"
		
		return colors
	end,
	global_skip_filetypes = {
		"neo-tree",
		"lua",
	},
	statuslines = {
		default,
	},
})

