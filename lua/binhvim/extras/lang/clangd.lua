-- [nfnl] Compiled from fnl/binhvim/extras/lang/clangd.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  return nil
end
local function _2_(fname)
  local lspconfig_util = require("lspconfig.util")
  local patterns = {"Makefile", "configure.ac", "configure.in", "config.h.in", "meson.build", "meson_options.txt", "build.ninja"}
  local alt_patterns = {"compile_commands.json", "compile_flags.txt"}
  return (lspconfig_util.root_pattern(unpack(patterns))(fname) or lspconfig_util.root_pattern(unpack(alt_patterns))(fname) or lspconfig_util.find_git_ancestor(fname))
end
local function _3_(_, opts)
  local clangd_ext_opts
  do
    local lazy_config_4_auto = require("lazy.core.config")
    local plugin_5_auto = (lazy_config_4_auto.spec.plugins)["clangd_extensions.nvim"]
    local lazy_plugin_6_auto = require("lazy.core.plugin")
    local opts_7_auto = lazy_plugin_6_auto.values(plugin_5_auto, "opts", false)
    clangd_ext_opts = opts_7_auto
  end
  local clangd_ext_opts0 = vim.tbl_deep_extend("force", (clangd_ext_opts or {}), {server = opts})
  local clangd_ext = require("clangd_extensions")
  clangd_ext.setup(clangd_ext_opts0)
  return false
end
local function _4_(_, opts)
  return table.insert(opts.sorting.comparators, 1, require("clangd_extensions.cmp_scores"))
end
return {{"nvim-treesitter/nvim-treesitter", opts = {binh_ensure_installed = {c = true, cpp = true}}}, {"p00f/clangd_extensions.nvim", lazy = true, config = _1_, opts = {inlay_hints = {inline = false}, ast = {role_icons = {type = "\238\173\163", declaration = "\238\170\140", expression = "\238\169\177", specifier = "\238\174\134", statement = "\238\170\134", ["template argument"] = "\238\170\146"}, kind_icons = {Compound = "\238\170\139", Recovery = "\238\170\135", TranslationUnit = "\238\171\169", PackExpansion = "\238\169\188", TemplateTypeParm = "\238\170\146", TemplateTemplateParm = "\238\170\146", TemplateParamObject = "\238\170\146"}}}}, {"neovim/nvim-lspconfig", opts = {servers = {clangd = {keys = {{"<leader>cR", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)"}}, root_dir = _2_, capabilities = {offsetEncoding = {"utf-16"}}, cmd = {"clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu", "--completion-style=detailed", "--function-arg-placeholders", "--fallback-style=llvm"}, init_options = {usePlaceholders = true, completeUnimported = true, clangdFileStatus = true}}}, setup = {clangd = _3_}}}, {"nvim-cmp", opts = _4_}}
