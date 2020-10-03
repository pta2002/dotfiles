local api = vim.api

local function lsp_attach(...)
    require('completion').on_attach(...)
    require('diagnostic').on_attach(...)
end

-- LSP
require('nvim_lsp').clangd.setup{
    on_attach = lsp_attach
}

require('nvim_lsp').rls.setup{
    on_attach = lsp_attach
}

-- Treesitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    highlight = {
        enable = true,
    },
}
