local lspconfig = require('lspconfig')
lspconfig.ccls.setup {
  init_options = {
    cache = {
      directory = ".ccls-cache";
    };
  }
}
