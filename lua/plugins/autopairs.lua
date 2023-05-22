local M = { "windwp/nvim-autopairs" }

M.event = { "BufReadPre", "BufNewFile" }

M.opts = {
    check_ts = true,
    disable_filetype = { "TelescopePrompt", "vim" },
    ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
    },
}

return M
