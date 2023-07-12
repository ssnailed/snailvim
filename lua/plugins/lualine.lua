local M = { "nvim-lualine/lualine.nvim" }
M.opts = function()
    local colors = require('tokyonight.colors').setup({ transform = true })
    local icons = require('config.icons')
    local conditions = {
        buffer_not_empty = function()
            return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
        end,
        hide_in_width = function()
            return vim.fn.winwidth(0) > 80
        end,
        check_git_workspace = function()
            local filepath = vim.fn.expand('%:p:h')
            local gitdir = vim.fn.finddir('.git', filepath .. ';')
            return gitdir and #gitdir > 0 and #gitdir < #filepath
        end,
    }

    local function search_result()
        if vim.v.hlsearch == 0 then
            return ''
        end
        local last_search = vim.fn.getreg('/')
        if not last_search or last_search == '' then
            return ''
        end
        local searchcount = vim.fn.searchcount { maxcount = 9999 }
        return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
    end

    local config = {
        options = {
            component_separators = '',
            section_separators = '',
            -- theme = {
            --   normal = { c = { fg = colors.fg, bg = colors.bg } },
            --   inactive = { c = { fg = colors.fg, bg = colors.bg } },
            -- },
            disabled_filetypes = {
                statusline = { 'alpha' }
            },
            ignore_focus = { 'toggleterm', 'NvimTree' },
            globalstatus = true,
        },
        sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_y = {},
            lualine_z = {},
            lualine_c = {},
            lualine_x = {},
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_y = {},
            lualine_z = {},
            lualine_c = {},
            lualine_x = {},
        }
    }

    local function ins_left(component)
        table.insert(config.sections.lualine_c, component)
    end

    local function ins_right(component)
        table.insert(config.sections.lualine_x, component)
    end

    local function mode_color()
        local color = {
            n = colors.red,
            i = colors.green,
            v = colors.magenta,
            [''] = colors.magenta,
            V = colors.magenta,
            c = colors.blue,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [''] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ['r?'] = colors.cyan,
            ['!'] = colors.red,
            t = colors.red,
        }
        return { fg = color[vim.fn.mode()] }
    end

    ins_left {
        function()
            return '▊'
        end,
        color = function()
            return mode_color()
        end,
        padding = { right = 1 },
    }

    ins_left {
        'filename',
        cond = conditions.buffer_not_empty,
        color = { fg = colors.magenta, gui = 'bold' },
    }

    ins_left {
        'fileformat',
        fmt = string.upper,
        icons_enabled = false,
        color = { fg = colors.green },
    }

    ins_left {
        'o:encoding',
        fmt = string.upper,
        cond = conditions.hide_in_width,
        color = { fg = colors.green },
    }

    ins_left {
        'filesize',
        fmt = string.upper,
        icons_enabled = false,
        color = { fg = colors.green },
    }

    ins_left {
        '%04l:%04c',
    }

    -- NOTE: My beloved :(

    -- ins_left {
    --     function()
    --         local current_line = vim.fn.line "."
    --         local total_lines = vim.fn.line "$"
    --         local chars = icons.progress
    --         local line_ratio = current_line / total_lines
    --         local index = math.ceil(line_ratio * #chars)
    --         return chars[index]
    --     end,
    --     color = { fg = colors.yellow }
    -- }

    ins_right {
        search_result,
        color = { fg = colors.white },
        padding = { left = 1 },
    }

    ins_right {
        function()
            local msg = ''
            local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
            local clients = vim.lsp.get_active_clients()
            if next(clients) == nil then
                return 'No LSP'
            end
            for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    msg = msg .. ", " .. client.name
                end
            end
            return msg:sub(3)
        end,
        color = { fg = colors.blue, gui = 'bold' },
    }

    ins_right {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = {
            error = icons.diagnostics.BoldError .. ' ',
            warn = icons.diagnostics.BoldWarning .. ' ',
            info = icons.diagnostics.BoldInformation
        },
        diagnostics_color = {
            color_error = { fg = colors.red },
            color_warn = { fg = colors.yellow },
            color_info = { fg = colors.cyan },
        },
    }

    ins_right {
        'filetype',
        color = { fg = colors.green, gui = 'bold' },
        padding = { left = 1 },
    }

    ins_right {
        function()
            return '▊'
        end,
        color = function()
            return mode_color()
        end,
        padding = { left = 1 },
    }

    return config
end

return M
