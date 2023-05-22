local M = { "folke/tokyonight.nvim" }

M.priority = 1000

local opts = {
    style = "night",
    transparent = true,
    terminal_colors = true,
    dim_inactive = true,
}

M.config = function()
    require('tokyonight').setup(opts)
    vim.cmd [[colorscheme tokyonight]]
end

return M
