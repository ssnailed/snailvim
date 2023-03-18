local status_ok, luasnip = pcall(require, "luasnip")
if not status_ok then
    return
end

local f = luasnip.function_node

luasnip.setup({
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
})

local _, lloader = pcall(require, "luasnip.loaders.from_lua")
if status_ok then
    lloader.load({ paths = os.getenv("XDG_CONFIG_HOME") .. "/nvim/lua/snippets" })
end

local _, vloader = pcall(require, "luasnip.loaders.from_vscode")
if status_ok then
    vloader.lazy_load({ paths = os.getenv("XDG_CONFIG_HOME") .. "/nvim/lua/snippets" })
end

vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
        if luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
            and not luasnip.session.jump_active
        then
            luasnip.unlink_current()
        end
    end,
})
