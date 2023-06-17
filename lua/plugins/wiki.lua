local M = { "lervag/wiki.vim" }

M.cmd = {
    "WikiIndex",
    "WikiJournal",
    "WikiPages",
    "WikiTags",
    "WikiToc",
    "WikiTocGenerate",
}

M.init = function()
   vim.g.wiki_root = "~/Documents/wiki"
end

return M
