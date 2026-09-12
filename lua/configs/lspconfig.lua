require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "pyrefly", "tsserver" }
vim.lsp.enable(servers)

vim.lsp.config('tsserver', {
  cmd = {'typescript-language-server', '--stdio'},
  filetypes = { 'typescript' },
  root_dir = vim.fs.root(0, {'package.json', '.git'}),
})


-- read :h vim.lsp.config for changing options of lsp servers 
