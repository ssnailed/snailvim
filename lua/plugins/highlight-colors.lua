local status_ok, highlight = pcall(require, "nvim-highlight-colors")
if not status_ok then
    return
end

highlight.setup({
    render = 'background'
})
