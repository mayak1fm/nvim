local function find_clangd()
  local candidates = { "clangd", "clangd-20", "clangd-19", "clangd-18", "clangd-17", "clangd-16" }
  for _, bin in ipairs(candidates) do
    if vim.fn.executable(bin) == 1 then
      return bin
    end
  end
  return nil
end

local clangd_bin = find_clangd()

if not clangd_bin then
  vim.notify("clangd not found — install clangd or clangd-XX", vim.log.levels.WARN)
  return {}
end

return {
  cmd = {
    clangd_bin,
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
  root_markers = { ".clangd", "compile_commands.json" },
  filetypes = { "c", "cpp", "cuda" },
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      },
    },
  },
}
