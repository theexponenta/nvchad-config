local lspconfig = require("nvchad.configs.lspconfig")
lspconfig.defaults()

local on_attach = lspconfig.on_attach
local capabilities = lspconfig.capabilities

local servers = { "html", "cssls", "pyrefly", "tsserver", "clangd" }
vim.lsp.enable(servers)

vim.lsp.config('tsserver', {
  cmd = {'typescript-language-server', '--stdio'},
  filetypes = { 'typescript' },
  root_dir = vim.fs.root(0, {'package.json', '.git'}),
})

vim.lsp.config("clangd", {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
})

-- read :h vim.lsp.config for changing options of lsp servers 
