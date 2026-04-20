
local v = vim
local o = v.opt
local keymap = v.keymap.set

v.pack.add({
	-- Dependency for Neotree, Telescope
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	-- Dependency for Neotree
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	-- Dependency for Neotree
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	-- Colorscheme
	{ src = "https://github.com/Mofiqul/adwaita.nvim" },
	-- Bottom Line
	{ src = "https://github.com/windwp/windline.nvim" },
	-- LSP config
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	-- Typst Preview
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	-- Git Gutter Bar
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	-- File tree
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
	-- Telescope
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	-- Python linter
	{ src = "https://github.com/tell-k/vim-autopep8" },
})

v.lsp.enable({
	"clangd", -- C
	"lua_ls", -- Lua
	"pylsp", -- Python
	"qmlls", -- qml
	"tinymist", -- Typst
	"zls",   -- Zig
})

v.lsp.config("qmlls", {
	cmd = { "qmlls6" },
	filetypes = { "qml" },
})



-- set pretext files to highlight as html
v.filetype.add({
	extension = {
		ptx = 'html',
	},
})

-- Options!
o.number = true
o.relativenumber = true
o.mouse = 'a'
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = false
o.smartindent = true
o.clipboard = 'unnamedplus'
o.undofile = true
o.list = true
o.colorcolumn = "81"
o.signcolumn = "yes"
o.listchars = {
	tab = '  ',
	multispace = '··',
	extends = '⟩',
	precedes = '⟨',
	trail = '·',
}

-- Space as leader
keymap("", "<Space>", "<Nop>")
v.g.mapleader = " "
v.g.maplocalleader = " "

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- Easuer recording playing
keymap("n", "<leader>q", "@")

-- Remove highlights
keymap("n", "<leader>n", ":nohl<cr>")

-- Open Neotree
keymap("n", "<leader>e", ":Neotree toggle<cr>")

-- Telescope commands
keymap("n", "<leader>g", ":Telescope live_grep<cr>")
keymap("n", "<leader>f", ":Telescope find_files<cr>")

-- Quick normal (change to using capslock)
keymap("i", "jk", "<ESC>")

-- Hold onto shifts
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Ctrl + L in insert opens up brackets
keymap("i", "<C-l>", "<ESC>O")

-- LSP commands all start with Space + l
-- R for Refactor
keymap("n", "<leader>lr", v.lsp.buf.rename)
-- F for reFerences
keymap("n", "<leader>lf", v.lsp.buf.references)
-- H for hover
keymap("n", "<leader>lh", v.lsp.buf.hover)
-- Diagnostics
keymap("n", "<leader>ld", v.diagnostic.open_float)

keymap("i", "<A-m>", "<lt>m><lt>/m><Left><Left><Left><Left>")

-- Special function to replace all double spaces with tabs
v.cmd("command Tab2 %s/  /\t/g")

-- Switch Colorscheme
v.cmd("colorscheme adwaita")

-- Setup Windline
require("windline_conf")



