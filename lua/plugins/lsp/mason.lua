local M = { "williamboman/mason.nvim" }

local icons = require('config.icons')

M.keys = { { "<leader>lI", "<cmd>Mason<cr>", desc = "Mason" } }

M.opts = {
    ui = {
        border = "none",
        icons = {
            package_installed = icons.ui.Check,
            package_pending = icons.ui.BoldArrowRight,
            package_uninstalled = icons.ui.BoldClose,
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
}

return M
