local M = { "numToStr/Comment.nvim" }

M.event = { "BufReadPre", "BufNewFile" }

M.keys = {
    { "<leader>/", "<Plug>(comment_toggle_linewise_current)", desc = "Comment toggle current line", },
    { "<leader>/", "<Plug>(comment_toggle_linewise_visual)",  desc = "Comment toggle linewise",     mode = { "v" }, },
}

M.opts = {
    mappings = {
        basic = false,
        extra = false
    }
}

return M
