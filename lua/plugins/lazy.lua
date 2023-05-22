local M = { "folke/lazy.nvim" }

local icons = require('config.icons')

M.opts = {
    ui = {
        border = "single",
        icons = {
            cmd = icons.ui.CMD .. " ",
            config = icons.ui.Gear,
            event = icons.misc.Bolt,
            ft = icons.ui.File .. " ",
            init = icons.ui.Gear .. " ",
            import = icons.ui.Import .. " ",
            keys = icons.ui.Keyboard .. " ",
            lazy = icons.ui.Sleep .. " ",
            loaded = icons.ui.CircleFull,
            not_loaded = icons.ui.CircleEmpty,
            plugin = icons.misc.Package,
            runtime = icons.misc.Vim .. " ",
            source = icons.ui.Code .. " ",
            start = icons.ui.Start,
            task = icons.ui.Check .. " ",
            list = {
                icons.ui.CircleFull,
                icons.ui.BoldArrowRight,
                icons.misc.Star,
                icons.ui.LineHorizontal,
            },
        },
    },
}

M.keys = {
    { "<leader>pu", require("lazy").check,                   desc = "Check for updates" },
    { "<leader>pc", require("lazy").clear,                   desc = "Clear finished tasks" },
    { "<leader>pd", require("lazy").debug,                   desc = "Show debug information" },
    { "<leader>pp", require("lazy").profile,                 desc = "Show profiling information" },
    { "<leader>ps", require("lazy").sync,                    desc = "Install, clean and update plugins" },
}


return M
