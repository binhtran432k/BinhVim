-- [nfnl] Compiled from fnl/binhvim/plugins/lspconfig.fnl by https://github.com/Olical/nfnl, do not edit.
local function attach_keys(_, buffer)
  vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>", {buffer = buffer, desc = "Lsp Info"})
  local function _1_()
    return (require("telescope.builtin")).lsp_definitions({reuse_win = true})
  end
  vim.keymap.set("n", "gd", _1_, {buffer = buffer, desc = "Goto Definition"})
  vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", {buffer = buffer, desc = "References"})
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {buffer = buffer, desc = "Goto Declaration"})
  local function _2_()
    return require["telescope.builtin"]("lsp_implementations", {reuse_win = true})
  end
  vim.keymap.set("n", "gI", _2_, {buffer = buffer, desc = "Goto Implementation"})
  local function _3_()
    return require["telescope.builtin"]("lsp_type_definitions", {reuse_win = true})
  end
  vim.keymap.set("n", "gy", _3_, {buffer = buffer, desc = "Goto T[y]pe Definition"})
  vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer = buffer, desc = "Hover", silent = true})
  vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, {buffer = buffer, desc = "Signature Help"})
  vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, {buffer = buffer, desc = "Signature Help"})
  vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, {buffer = buffer, desc = "Code Action"})
  vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, {buffer = buffer, desc = "Rename"})
  vim.keymap.set({"n", "v"}, "<leader>cc", vim.lsp.codelens.run, {buffer = buffer, desc = "Run Codelens"})
  vim.keymap.set("n", "<leader>cC", vim.lsp.codelens.refresh, {buffer = buffer, desc = "Refresh & Display Codelens"})
  local function _4_()
    return vim.lsp.buf.code_action({context = {only = {"source"}, diagnostics = {}}})
  end
  return vim.keymap.set("n", "<leader>cA", _4_, {buffer = buffer, desc = "Source Action"})
end
local function _5_(_, opts)
  do
    local lazy_config = require("lazy.core.config")
    local plugin = lazy_config.spec.plugins["neoconf.nvim"]
    if (plugin ~= nil) then
      local neoconf = require("neoconf")
      local lazy_plugin = require("lazy.core.plugin")
      neoconf.setup(lazy_plugin.values(plugin, "opts", false))
    else
    end
  end
  local on_attachs = {}
  table.insert(on_attachs, attach_keys)
  do
    local handler = "client/registerCapability"
    local register_capability = vim.lsp.handlers[handler]
    local function _7_(err, res, ctx)
      local ret = register_capability(err, res, ctx)
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      local buffer = vim.api.nvim_get_current_buf()
      attach_keys(client, buffer)
      return ret
    end
    vim.lsp.handlers[handler] = _7_
  end
  do
    local border = "rounded"
    local function _8_(_nil, result, ctx, config)
      if result then
        return vim.lsp.handlers.hover(_nil, result, ctx, config)
      else
        return nil
      end
    end
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(_8_, {border = border})
    do end (vim.lsp.handlers)["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = border})
  end
  if (vim.fn.has("nvim-0.10.0") == 0) then
    for severity, icon in pairs(opts.diagnostics.signs.text) do
      local severity_sub = (vim.diagnostic.severity[severity]):lower():gsub()
      local name = severity_sub("^%l", string.upper)
      local name0 = ("DiagnosticSign" .. name)
      vim.fn.sign_define(name0, {text = icon, texthl = name0, numhl = ""})
    end
  else
  end
  if (opts.codelens.enabled and vim.lsp.codelens) then
    local function _11_(client, buffer)
      if client.supports_method["textDocument/codeLens"] then
        vim.lsp.codelens.refresh()
        return vim.api.nvim_create_autocmd({"BufEnter", "CursorHold", "InsertLeave"}, {buffer = buffer, callback = vim.lsp.codelens.refresh})
      else
        return nil
      end
    end
    table.insert(on_attachs, _11_)
  else
  end
  vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
  do
    local servers = opts.servers
    local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    local capabilities
    local _14_
    if has_cmp then
      _14_ = cmp_nvim_lsp.default_capabilities()
    else
      _14_ = {}
    end
    capabilities = vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), _14_, (opts.capabilities or {}))
    local function setup(server)
      local server_opts = vim.tbl_deep_extend("force", {capabilities = vim.deepcopy(capabilities)}, (servers[server] or {}))
      local server_setup = (opts.setup[server] or opts.setup["*"])
      local add_on_attach
      local function _16_(on_attach)
        return table.insert(on_attachs, on_attach)
      end
      add_on_attach = _16_
      local server_setup0
      if server_setup then
        server_setup0 = server_setup(server, server_opts, add_on_attach)
      else
        server_setup0 = nil
      end
      if not server_setup0 then
        local lspconfig = require("lspconfig")
        local _let_18_ = lspconfig[server]
        local setup0 = _let_18_["setup"]
        return setup0(server_opts)
      else
        return nil
      end
    end
    do
      local lazy_config = require("lazy.core.config")
      local plugin = lazy_config.spec.plugins["typescript-tools.nvim"]
      if (plugin ~= nil) then
        local typescript = require("typescript-tools")
        local lazy_plugin = require("lazy.core.plugin")
        local plugin_opts = lazy_plugin.values(plugin, "opts", false)
        typescript.setup(plugin_opts)
      else
      end
    end
    for server, server_opts in pairs(servers) do
      if server_opts then
        setup(server)
      else
      end
    end
  end
  local function _22_(args)
    local buffer = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    for _0, on_attach in ipairs(on_attachs) do
      on_attach(client, buffer)
    end
    return nil
  end
  return vim.api.nvim_create_autocmd("LspAttach", {callback = _22_})
end
return {{"neovim/nvim-lspconfig", event = "LazyFile", dependencies = {{"folke/neoconf.nvim", cmd = "Neoconf", dependencies = {"nvim-lspconfig"}, config = false}, "mason.nvim"}, opts = {diagnostics = {underline = true, float = {border = "rounded"}, virtual_text = {spacing = 4, source = "if_many", prefix = "\226\151\143"}, severity_sort = true, signs = {text = {}}, update_in_insert = false}, inlay_hints = {enabled = false}, codelens = {enabled = false}, capabilities = {}, servers = {lua_ls = {settings = {Lua = {workspace = {checkThirdParty = false}, codeLens = {enable = true}, completion = {callSnippet = "Replace"}}}}}, setup = {}}, config = _5_}}
