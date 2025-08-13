return {
 -- From the clangd configuration in <rtp>/lsp/clangd.lua
  cmd = { 'clangd-19' },
  -- From the clangd configuration in <rtp>/lsp/clangd.lua
  -- Overrides the "*" configuration in init.lua
  root_markers = { '.clangd', 'compile_commands.json' },
  -- From the clangd configuration in init.lua
  -- Overrides the clangd configuration in <rtp>/lsp/clangd.lua
  filetypes = { 'c','cpp','h','hpp','tpp'},
  -- From the "*" configuration in init.lua
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      }
    }
  }
}
