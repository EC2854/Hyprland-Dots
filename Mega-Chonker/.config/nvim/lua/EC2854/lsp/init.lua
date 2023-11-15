local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "EC2854.lsp.lsp-installer"
require("EC2854.lsp.handlers").setup()
require "EC2854.lsp.null-ls"
