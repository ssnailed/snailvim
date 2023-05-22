local maps = {
    n = {
        -- Navigate buffers
        { "<C-l>", ":bnext<CR>" },
        { "<C-h>", ":bprevious<CR>" },
        -- lsp
        { "gD", vim.lsp.buf.declaration },
        { "gd", vim.lsp.buf.definition },
        { "K",  vim.lsp.buf.hover },
        { "gI", vim.lsp.buf.implementation },
        { "gr", vim.lsp.buf.references },
        { "gl", vim.diagnostic.open_float },
    },
    i = {
        -- Delete last word with ctrl + del
        { "<C-BS>", "<C-W>" },
    },
    v = {
        -- Better paste
        { "p", '"_dP' },
        -- Stay in indent mode
        { "<", "<gv" },
        { ">", ">gv" },
    },
}

local wkmaps = {
    n = {
        ["w"] = { "<cmd>w!<CR>", "Save" },
        ["q"] = { require("funcs").buf_kill, "Close" },
        ["h"] = { "<cmd>nohlsearch<CR>", "Clear Highlights" },
        ["n"] = { "<cmd>ene<CR>", "New File" },
        u = {
            name = "Utility",
            c = { "<cmd>w!<CR><cmd>!compiler \"%:p\"<CR>", "Compile" },
        },
        l = {
            name = "LSP",
            a = { vim.lsp.buf.code_action, "Code Action" },
            f = { function() require("funcs").format({ async = true }) end, "Format" },
            j = { vim.diagnostic.goto_next, "Next Diagnostic" },
            k = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
            l = { vim.lsp.codelens.run, "CodeLens Action" },
            q = { vim.diagnostic.setloclist, "Quickfix" },
            r = { vim.lsp.buf.rename, "Rename" },
        },
    },
}

local whichkey = require('which-key')

for mode, binds in pairs(maps) do
    for _, bind in pairs(binds) do
        local key = bind[1]
        local cmd = ""
        local opt = { silent = true, noremap = true }
        if type(bind[2]) == "string" then
            cmd = bind[2]
        elseif type(bind[2]) == "function" then
            opt["callback"] = bind[2]
        end
        vim.api.nvim_set_keymap(mode, key, cmd, opt)
    end
end

for mode, binds in pairs(wkmaps) do
    whichkey.register(binds, {
        mode = mode,
        prefix = "<leader>",
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = true,
    })
end
