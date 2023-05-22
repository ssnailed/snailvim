local M = { "RRethy/vim-illuminate" }

M.event = { "BufReadPre", "BufNewFile" }

local opts = {
    providers = {
        "lsp",
        "treesitter",
        "regex",
    },
    delay = 200,
    filetypes_denylist = {
        "dirvish",
        "fugitive",
        "alpha",
        "NvimTree",
        "packer",
        "neogitstatus",
        "Trouble",
        "lir",
        "Outline",
        "spectre_panel",
        "toggleterm",
        "DressingSelect",
        "TelescopePrompt",
    },
    filetypes_allowlist = {},
    modes_denylist = {},
    modes_allowlist = {},
    providers_regex_syntax_denylist = {},
    providers_regex_syntax_allowlist = {},
    under_cursor = true,
}

M.init = function()
    vim.g.Illuminate_ftblacklist = { 'alpha', 'NvimTree' }
end

M.config = function()
    require('illuminate').configure(opts)
end

return M
