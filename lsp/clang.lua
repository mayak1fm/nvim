return {
 -- From the clangd configuration in <rtp>/lsp/clangd.lua
  cmd = { 'clangd-19',
    "--pch-storage=memory",
    "--background-index",
    "--background-index-priority=low",
    "--clang-tidy=false",
    "--header-insertion=never",
    "--completion-style=bundled",
    "--malloc-trim",
    "--limit-results=50",
    "-j=4",
  },
  -- From the clangd configuration in <rtp>/lsp/clangd.lua
  -- Overrides the "*" configuration in init.lua
  root_markers = { '.clangd', 'compile_commands.json' },
  -- From the clangd configuration in init.lua
  -- Overrides the clangd configuration in <rtp>/lsp/clangd.lua
  filetypes = { 'c','cpp','h','hpp','tpp','cu',"cuda"},
  -- From the "*" configuration in init.lua
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      }
    }
  }
}
