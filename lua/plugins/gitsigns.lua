local M = { "lewis6991/gitsigns.nvim" }

M.event = { "BufReadPre", "BufNewFile" }

M.keys = {
    { "<leader>gj", function() require("gitsigns").next_hunk() end, desc = "Next Hunk" },
    { "<leader>gk", function() require("gitsigns").prev_hunk() end, desc = "Prev Hunk" },
    { "<leader>gb", function() require("gitsigns").blame_line() end, desc = "Blame" },
    { "<leader>gp", function() require("gitsigns").preview_hunk() end, desc = "Preview Hunk" },
    { "<leader>gr", function() require("gitsigns").reset_hunk() end, desc = "Reset Hunk" },
    { "<leader>gR", function() require("gitsigns").reset_buffer() end, desc = "Reset Buffer" },
    { "<leader>gs", function() require("gitsigns").stage_hunk() end, desc = "Stage Hunk" },
    { "<leader>gu", function() require("gitsigns").undo_stage_hunk() end, desc = "Undo Stage Hunk" },
    { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Git Diff" },
}

M.ft = { "gitcommit" }

local opts = {
    signs = {
        add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
        change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
        delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    watch_gitdir = {
        interval = 1000,
        follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
    },
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    preview_config = {
        -- Options passed to nvim_open_win
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
    },
}

M.config = function()
    require('gitsigns').setup(opts)
    require('which-key').register({
        g = {
            name = "Git",
        },
    }, { prefix = "<leader>" })
end

return M
