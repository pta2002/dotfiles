local api = vim.api

-- LSP
require('nvim_lsp').clangd.setup{
    on_attach = require('completion').on_attach
}

require('nvim_lsp').rls.setup{
    on_attach = require('completion').on_attach
}

-- Treesitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    highlight = {
        enable = true,
    },
}
