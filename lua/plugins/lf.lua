local M = { "lmburns/lf.nvim" }

-- M.commit = "383429497292dd8a84271e74a81c6db6993ca7ab"

M.cmd = { "Lf" }

M.opts = {
    mappings = false,
    winblend = 0,
    border = "rounded",
}

M.keys = {
    { "<leader>e", function() require('lf').start() end, "File Picker" },
}

return M
