local M = { "folke/which-key.nvim" }

local icons = require('config.icons')

M.lazy = false

M.init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
end

local opts = {
    plugins = {
        marks = false,
        registers = false,
        presets = {
            operators = false,
            motions = false,
            text_objects = false,
            windows = false,
            nav = false,
            z = false,
            g = false,
        }
    },
    spelling = {
        enabled = false,
        suggestions = 20,
    },
    icons = {
        breadcrumb = icons.ui.DoubleChevronRight,
        separator = icons.ui.BoldArrowRight,
        group = icons.ui.Plus,
    },
    popup_mappings = {
        scroll_down = "<c-d>",
        scroll_up = "<c-u>",
    },
    window = {
        border = "none",
        position = "bottom",
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "left",
    },
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
    triggers = "auto",
    triggers_blacklist = {
        i = { "j", "k" },
        v = { "j", "k", "y" },
    },
    defaults = {
        ["<leader>u"] = { name = "Utility" },
        ["<leader>p"] = { name = "Plugins" },
    }
}

M.keys = {
    { "<leader>w",  "<cmd>w!<CR>",                           desc = "Save" },
    { "<leader>q",  require('funcs').buf_kill,               desc = "Close" },
    { "<leader>h",  "<cmd>nohlsearch<CR>",                   desc = "Clear Highlights" },
    { "<leader>n",  "<cmd>ene<CR>",                          desc = "New File" },
    { "<leader>uc", "<cmd>w!<CR><cmd>!compiler \"%:p\"<CR>", desc = "Compile" },
}

return M
