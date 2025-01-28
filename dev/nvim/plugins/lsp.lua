-- For ease of adding servers
local servers = {
  'pyright',
  'clangd',
  'html',
  'cssls',
  'ts_ls',
  'emmet_ls',
  'rust_analyzer',
  'nushell',
}

local capabilities = require'cmp_nvim_lsp'.default_capabilities()

for i, name in ipairs(servers) do
  require'lspconfig'[name].setup { 
    -- Enable completion
    capabilities = capabilities,
  }
end
