-- Copied from Gilles Castel (R.I.P.)
-- https://castel.dev/post/lecture-notes-1/

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet

local function has_value(tab, val)
    for _, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

local function cond_space(args, _)
    print(args[1][1]:sub(1, 1))
    if (args[1][1] and has_value({ ',', '.', '?', '-', ' ' }, args[1][1]:sub(1, 1))) then
        return ''
    end
    return ' '
end

local function sub_capture(index, first, last)
    return f(function(_, snip, user_arg1) return snip.captures[user_arg1]:sub(first, last) end, nil,
        { user_args = { index } })
end

local function in_comment()
    return vim.fn['vimtex#syntax#in_comment']() == 1
end

local function in_math()
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

local function in_env(name)
    local x, y = vim.fn['vimtex#env#is_inside'](name)
    return (x ~= '0' and y ~= '0')
end

return {
}, {
    s({ trig = "^(%s*)beg", regTrig = true, wordTrig = false, name = "begin{} / end{}" }, fmt([[
    {}\begin{{{}}}
    {}    {}
    {}\end{{{}}}
    ]], { capture(1), i(1), capture(1), i(0), capture(1), reference(1) })),
    s({ trig = "mk", name = "Inline Math" }, fmt([[
        ${}${}{}
    ]], { i(1), f(cond_space, 2), i(2) })),
    s({ trig = "dm", name = "Display Math" }, fmt([[
        \[
            {}
        .\]
    ]], { i(1) })),
    s({ trig = "([A-Za-z])(%d)", regTrig = true, name = "Subscript" }, fmt([[
        {}_{}
    ]], { capture(1), capture(2) })),
    s({ trig = "([A-Za-z])_(%d)", regTrig = true, name = "Subscript" }, fmt([[
        {}_{{{}}}
    ]], { capture(1), capture(2) })),
    s({ trig = " td", wordTrig = false, name = "Superscript" }, fmt([[
        ^{{{}}}
    ]], { i(1) })),
    s({ trig = " sr", wordTrig = false, name = "Square" }, fmt([[
        ^2
    ]], {})),
    s({ trig = " cb", wordTrig = false, name = "Cube" }, fmt([[
        ^3
    ]], {})),
    s({ trig = " cl", wordTrig = false, name = "Complement" }, fmt([[
        ^{{c}}
    ]], {})),
    s({ trig = "//", wordTrig = false, name = "Fraction" }, fmt([[
        \\frac{{{}}}{{{}}}
    ]], { i(1), i(2) })),
    -- if lua patterns had conditionals this would be less of a mess
    -- unfortunately this also expands on incomplete ^{} superscripts e.g. 4\pi^2}/
    ms({
        { trig = "(%d+)/" },
        { trig = "(%d*\\?[A-Za-z]+[%^_]{?%d+}?)/", priority = 1001 },
        common = { regTrig = true, name = "Fraction" }
    }, fmt([[
        \\frac{{{}}}{{{}}}
    ]], { capture(1), i(1) })),
    s({ trig = "(%b())/", name = "Fraction", regTrig = true }, fmt([[
        \\frac{{{}}}{{{}}}
    ]], { sub_capture(1, 2, -2), i(1) })),
    s({ trig = "([A-Za-z])bar", regTrig = true, name = "Overline" }, fmt([[
        \overline{{{}}}
    ]], { capture(1) })),
    s({ trig = "bar", name = "Overline" }, fmt([[
        \overline{{{}}}
    ]], { i(1) })),
    s({ trig = "([A-Za-z])hat", regTrig = true, name = "Hat" }, fmt([[
        \hat{{{}}}
    ]], { capture(1) })),
    s({ trig = "hat", name = "Hat" }, fmt([[
        \hat{{{}}}
    ]], { i(1) })),
    -- TODO: continue porting these snippets: https://castel.dev/post/lecture-notes-1/#fractions
}
