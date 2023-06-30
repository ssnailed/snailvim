local autocmds = {
    { -- Handles the automatic line numeration changes
        { "BufEnter", "FocusGained", "InsertLeave", "WinEnter" },
        {
            pattern = "*",
            command = "if &nu && mode() != \"i\" | set rnu | endif"
        }
    },
    { -- Handles the automatic line numeration changes
        { "BufLeave", "FocusLost", "InsertEnter", "WinLeave" },
        {
            pattern = "*",
            command = "if &nu | set nornu | endif"
        }
    },
    {
        "BufWritePost",
        {
            pattern = { "*/bookmarks/files", "*/bookmarks/directories" },
            command = "!shortcuts"
        }
    },
    {
        { "BufRead", "BufNewFile" },
        {
            pattern = { "Xresources", "Xdefaults", "xresources", "xdefaults" },
            command = "set filetype=xdefaults"
        }
    },
    {
        "BufWritePost",
        {
            pattern = { "Xresources", "Xdefaults", "xresources", "xdefaults" },
            command = "!xrdb %"
        }
    },
    {
        "BufWritePost",
        {
            pattern = "*/dwmblocks/config.h",
            command = "!cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }"
        }
    },
    {
        "BufWritePost",
        {
            pattern = "*.java",
            callback = function()
                vim.lsp.codelens.refresh()
            end
        }
    },
    -- {
    --     { "BufDelete", "VimLeave" },
    --     {
    --         pattern = "*.tex",
    --         command = "!texclear \"%:p\""
    --     }
    -- },
    { -- Use 'q' to quit from common plugins
        'FileType',
        {
            pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
            callback = function()
                vim.cmd [[
                  nnoremap <silent> <buffer> q :close<CR> 
                  set nobuflisted 
                ]]
            end
        }
    },
    {
        'Filetype',
        {
            pattern = { "gitcommit", "markdown" },
            callback = function()
                vim.opt_local.wrap = true
                vim.opt_local.spell = true
            end,
        }
    },
    { -- Fix auto comment
        'BufWinEnter',
        {
            command = "set formatoptions-=cro"
        }
    },
    { -- Highlight yanked text
        'TextYankPost',
        {
            callback = function()
                vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
            end
        }
    }
}

vim.api.nvim_create_augroup('user_config', { clear = true })
for _, entry in ipairs(autocmds) do
local event = entry[1]
local opts = entry[2]
if type(opts.group) == "string" and opts.group ~= "" then
    local exists, _ = pcall(vim.api.nvim_get_autocmds, { group = opts.group })
    if not exists then
	vim.api.nvim_create_augroup(opts.group, {})
    end
end
vim.api.nvim_create_autocmd(event, opts)
end
