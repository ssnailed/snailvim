local g          = vim.g
local o          = vim.opt
local d          = vim.diagnostic.config

g.mapleader      = " "
g.maplocalleader = "	"

o.undodir        = vim.fn.stdpath "cache" .. "/undo"
o.clipboard      = "unnamedplus"
o.conceallevel   = 0
o.numberwidth    = 3
o.hlsearch       = true
o.ignorecase     = true
o.showmode       = false
o.smartindent    = true
o.splitbelow     = true
o.splitbelow     = true
o.splitbelow     = true
o.updatetime     = 250
o.writebackup    = false
o.expandtab      = true
o.shiftwidth     = 4
o.tabstop        = 4
o.cursorline     = true
o.signcolumn     = "yes"
o.wrap           = false
o.scrolloff      = 8
o.sidescrolloff  = 8
o.undofile       = true
o.title          = true

o.termguicolors  = true
o.timeoutlen     = 500
o.foldmethod     = "expr"
o.foldlevelstart = 99
o.foldexpr       = "nvim_treesitter#foldexpr()"
o.number         = true
o.relativenumber = true
o.laststatus     = 3
o.modeline       = true
o.modelines      = 3
o.listchars      = "eol:$,tab:>-,trail:~,extends:>,precedes:<"

d({ virtual_text = false })
