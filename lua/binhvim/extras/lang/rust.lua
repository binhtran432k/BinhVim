-- [nfnl] Compiled from fnl/binhvim/extras/lang/rust.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  return true
end
local function _2_(_, bufnr)
  local function _3_()
    return vim.cmd.RustLsp("codeAction")
  end
  return vim.keymap.set("n", "<leader>cR", _3_, {desc = "Code Action", buffer = bufnr})
end
local function _4_(_, opts)
  vim.g.rustaceanvim = vim.tbl_deep_extend("keep", (vim.g.rustaceanvim or {}), (opts or {}))
  return nil
end
return {{"nvim-treesitter/nvim-treesitter", opts = {binh_ensure_installed = {ron = true, rust = true, toml = true}}}, {"neovim/nvim-lspconfig", opts = {servers = {rust_analyzer = {}}, setup = {rust_analyzer = _1_}}}, {"mrcjkb/rustaceanvim", version = "^4", ft = {"rust"}, opts = {server = {on_attach = _2_, default_settings = {["rust-analyzer"] = {cargo = {allFeatures = true, loadOutDirsFromCheck = true, buildScripts = {enable = true}}, checkOnSave = {allFeatures = true, command = "clippy", extraArgs = {"--no-deps"}}, procMacro = {enable = true, ignored = {["async-trait"] = {"async_trait"}, ["napi-derive"] = {"napi"}, ["async-recursion"] = {"async_recursion"}}}}}}}, config = _4_}}
