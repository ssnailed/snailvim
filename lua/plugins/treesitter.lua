local M = { "nvim-treesitter/nvim-treesitter" }

M.event = { "BufReadPre", "BufNewFile" }

M.build = ":TSUpdate"

M.opts = {
    ensure_installed = { "lua", "bash", "c" },
    auto_install = true,
    autopairs = {
        enable = false,
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
}

M.keys = {
    { "<leader>T", "<cmd>TSConfigInfo<cr>", desc = "Treesitter Info" }
}

return M
