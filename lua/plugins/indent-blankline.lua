local M = { "lukas-reineke/indent-blankline.nvim" }

M.event = { "BufReadPre", "BufNewFile" }

M.keys = {
    {
        "<c-c>",
        function()
            local ok, start = require("indent_blankline.utils").get_current_context(
                vim.g.indent_blankline_context_patterns,
                vim.g.indent_blankline_use_treesitter_scope
            )
            if ok then
                vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
                vim.cmd [[normal! _]]
            end
        end,
        desc = "Jump to context",
    },
}


M.dependencies = {
    "nvim-treesitter",
}

M.opts = {
    char = "▏",
    context_char = "▏",
    show_trailing_blankline_indent = false,
    show_first_indent_level = true,
    use_treesitter = true,
    show_current_context = false,
    show_end_of_line = false,
    buftype_exclude = { "terminal", "nofile" },
    filetype_exclude = {
        "help",
        "packer",
        "NvimTree",
    },
}

return M
