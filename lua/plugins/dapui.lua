local dap_ui_status_ok, dapui = pcall(require, 'nvim-dap-ui')
if not dap_ui_status_ok then
    return
end

dapui.setup {
    layouts = {
        {
            elements = {
                'scopes',
                'breakpoints',
                'stacks',
                'watches',
            },
            size = 40,
            position = 'left',
        },
        {
            elements = {
                'repl',
                'console',
            },
            size = 10,
            position = 'bottom',
        },
    },
}
