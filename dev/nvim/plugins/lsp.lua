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
  'svelte',
}

local capabalities = require'blink.cmp'.get_lsp_capabilities() 

for i, name in ipairs(servers) do
  require'lspconfig'[name].setup { 
    -- Enable completion
    capabilities = capabilities,
  }
end
