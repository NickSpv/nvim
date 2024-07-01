require('bufferline').setup {
    options = {
        tag='v4.5.2',
        buffer_close_icon = '',
        mode = 'buffers',
        offsets = {
            {
                filetype = "neo-tree",
                text = "FileExplorer",
                separator = true,
                padding = 1
            }
        },
        diagnostics = "nvim_lsp",
        indicator = {
            icon = '  ',
            style = 'icon'
        },
        separator_style = "slope"
    }
}
