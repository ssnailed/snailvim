local M = { "L3MON4D3/LuaSnip" }

M.build = "make install_jsregexp"

local opts = function()
    local luasnip = require('luasnip')
    local f = luasnip.function_node
    return {
        history = true,
        enable_autosnippets = true,
        update_events = { "TextChanged", "TextChangedI" },
        snip_env = {
            s = function(...)
                local snip = luasnip.s(...)
                table.insert(getfenv(2).ls_file_snippets, snip)
            end,
            parse = function(...)
                local snip = luasnip.parser.parse_snippet(...)
                table.insert(getfenv(2).ls_file_snippets, snip)
            end,
            reference = function(node)
                return f(function(args, _) return args[1][1] end, node)
            end,
            capture = function(index)
                return f(function(_, snip, user_arg1) return snip.captures[user_arg1] end, nil, { user_args = { index } })
            end
        },
    }
end

M.config = function()
    require('luasnip').setup(opts())
    require('luasnip.loaders.from_lua').load({ paths = os.getenv("XDG_CONFIG_HOME") .. "/nvim/lua/snippets" })
    --require('luasnip.loaders.from_vscode').load({ paths = os.getenv("XDG_CONFIG_HOME") .. "/nvim/lua/snippets" })
    vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
            local luasnip = require('luasnip')
            if luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
                and not luasnip.session.jump_active
            then
                luasnip.unlink_current()
            end
        end,
    })
end

return M
