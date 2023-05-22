local M = { "williamboman/mason-lspconfig.nvim" }

local global_capabilities = {
    textDocument = {
        completion = {
            completionItem = {
                documentationFormat = { "markdown", "plaintext" },
                snippetSupport = true,
                preselectSupport = true,
                insertReplaceSupport = true,
                labelDetailsSupport = true,
                deprecatedSupport = true,
                commitCharactersSupport = true,
                tagSupport = { valueSet = { 1 } },
                resolveSupport = {
                    properties = {
                        "documentation",
                        "detail",
                        "additionalTextEdits",
                    },
                },
            },
        },
    },
}

local capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), global_capabilities)

M.dependencies = { "mason.nvim" }

M.event = { "BufReadPre", "BufNewFile" }

M.keys = {
    { "<leader>li", "<cmd>LspInfo<cr>",      desc = "LSP Info" },
    { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action" },
    {
        "<leader>lf",
        function()
            require("funcs").format({ async = true })
        end,
        desc = "Format",
    },
    { "<leader>lj", vim.diagnostic.goto_next,  desc = "Next Diagnostic" },
    { "<leader>lk", vim.diagnostic.goto_prev,  desc = "Prev Diagnostic" },
    { "<leader>ll", vim.lsp.codelens.run,      desc = "CodeLens Action" },
    { "<leader>lq", vim.diagnostic.setloclist, desc = "Quickfix" },
    { "<leader>lr", vim.lsp.buf.rename,        desc = "Rename" },
}

local opts = {
    ensure_installed = { "lua_ls" },
    handlers = {
        function(server_name)
            require("lspconfig")[server_name].setup({})
        end,
        ["intelephense"] = function()
            local intelephense_opts = {
                capabilities = capabilities,
                init_options = {
                    storagePath = vim.fn.expand("$XDG_CACHE_HOME") .. "/intelephense",
                    globalStoragePath = vim.fn.expand("$XDG_DATA_HOME") .. "/intelephense",
                },
                settings = {
                    intelephense = {
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            }
            require("lspconfig")["intelephense"].setup(intelephense_opts)
        end,
        ["lua_ls"] = function()
            local lua_opts = {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                            },
                        },
                        telemetry = {
                            enable = false,
                        },
                        maxPreload = 100000,
                        preloadFileSize = 10000,
                    },
                },
            }
            require("lspconfig")["lua_ls"].setup(lua_opts)
        end,
    },
}

M.config = function()
    local icons = require("config.icons").diagnostics
    local signs = {
        DiagnosticSignError = icons.BoldError,
        DiagnosticSignWarn = icons.BoldWarning,
        DiagnosticSignHint = icons.BoldHint,
        DiagnosticSignInfo = icons.BoldInformation,
    }
    for type, icon in pairs(signs) do
        local hl = type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    local mlsp = require('mason-lspconfig')
    mlsp.setup({ ensure_installed = opts.ensure_installed })
    mlsp.setup_handlers(opts.handlers)
end

return M
