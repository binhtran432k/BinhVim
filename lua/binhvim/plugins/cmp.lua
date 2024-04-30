-- [nfnl] Compiled from fnl/binhvim/plugins/cmp.fnl by https://github.com/Olical/nfnl, do not edit.
local function has_words_before()
  local _let_1_ = vim.api.nvim_win_get_cursor(0)
  local line = _let_1_[1]
  local col = _let_1_[2]
  local function _3_()
    local _let_2_ = vim.api.nvim_buf_get_lines(0, (line - 1), line, true)
    local current_line = _let_2_[1]
    local word_before = current_line:sub(col, col)
    return (word_before:match("%s") == nil)
  end
  return ((col ~= 0) and _3_())
end
local function supertab_next(fallback)
  local cmp = require("cmp")
  if cmp.visible() then
    return cmp.select_next_item()
  elseif vim.snippet.jumpable(1) then
    local function _4_()
      return vim.snippet.jump(1)
    end
    return vim.schedule(_4_)
  elseif has_words_before() then
    return cmp.complete()
  else
    return fallback()
  end
end
local function supertab_prev(fallback)
  local cmp = require("cmp")
  if cmp.visible() then
    return cmp.select_prev_item()
  elseif vim.snippet.jumpable(-1) then
    local function _6_()
      return vim.snippet.jump(-1)
    end
    return vim.schedule(_6_)
  else
    return fallback()
  end
end
local function _8_()
  vim.api.nvim_set_hl(0, "CmpGhostText", {link = "Comment", default = true})
  local cmp = require("cmp")
  local defaults = require("cmp.config.default")()
  local lspkind = require("lspkind")
  local cmp_window_opts = cmp.config.window.bordered({winhighlight = "CursorLine:Visual,Search:None"})
  local function _9_()
    if cmp.visible() then
      return cmp.close()
    else
      return cmp.complete()
    end
  end
  local function _11_(fallback)
    cmp.abort()
    return fallback()
  end
  return {auto_brackets = {}, performance = {debounce = 300, throttle = 60, fetching_timeout = 200}, completion = {completeopt = "menu,menuone,noinsert"}, sources = cmp.config.sources({{name = "nvim_lsp"}, {name = "snippets"}, {name = "nvim_lua"}, {name = "buffer"}, {name = "path"}, {name = "calc"}}), window = {completion = cmp_window_opts, documentation = cmp_window_opts}, binh_action = {next = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert}), prev = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Insert}), supertab_next = supertab_next, supertab_prev = supertab_prev, scroll_prev = cmp.mapping.scroll_docs(4), scroll_next = cmp.mapping.scroll_docs(-4), complete = cmp.mapping.complete(), toggle = _9_, abort = cmp.mapping.abort(), select = cmp.mapping.confirm({select = true}), select_replace = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true}), cr = _11_}, binh_key = {["<c-j>"] = "next", ["<c-k>"] = "prev", ["<c-u>"] = "scroll_next", ["<c-d>"] = "scroll_prev", ["<c-space>"] = "toggle", ["<c-e>"] = "abort", ["<c-y>"] = "select", ["<cr>"] = "select", ["<s-cr>"] = "select_replace", ["<c-cr>"] = "cr"}, binh_key_cmdline = {["<c-j>"] = "next", ["<c-k>"] = "prev", ["<c-space>"] = "toggle"}, formatting = {format = lspkind.cmp_format({})}, experimental = {ghost_text = {hl_group = "CmpGhostText"}}, sorting = defaults.sorting}
end
local function _12_(_, opts)
  local cmp = require("cmp")
  for _0, source in ipairs(opts.sources) do
    source.group_index = (source.group_index or 1)
  end
  local function _13_()
    local tbl_14_auto = {}
    for key, action in pairs(opts.binh_key) do
      local k_15_auto, v_16_auto = key, opts.binh_action[action]
      if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
        tbl_14_auto[k_15_auto] = v_16_auto
      else
      end
    end
    return tbl_14_auto
  end
  opts.mapping = cmp.mapping.preset.insert(_13_())
  local Kind = cmp.lsp.CompletionItemKind
  local on_confirm
  local function _15_(event)
    if vim.tbl_contains((opts.auto_brackets or {}), vim.bo.filetype) then
      local entry = event.entry
      local item = entry:get_completion_item()
      local keys = vim.api.nvim_replace_termcodes("()<left>", false, false, true)
      if vim.tbl_contains({Kind.Function, Kind.Method}, item.kind) then
        return vim.api.nvim_feedkeys(keys, "i", true)
      else
        return nil
      end
    else
      return nil
    end
  end
  on_confirm = _15_
  local cmdline_mapping
  local function _18_()
    local tbl_14_auto = {}
    for key, action in pairs(opts.binh_key_cmdline) do
      local k_15_auto, v_16_auto = key, {c = opts.binh_action[action]}
      if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
        tbl_14_auto[k_15_auto] = v_16_auto
      else
      end
    end
    return tbl_14_auto
  end
  cmdline_mapping = cmp.mapping.preset.cmdline(_18_())
  cmp.setup(opts)
  do end (cmp.event):on("confirm_done", on_confirm)
  cmp.setup.cmdline(":", {mapping = cmdline_mapping, sources = {{name = "cmdline", group_index = 1}, {name = "buffer", group_index = 2}}})
  for _0, cmd_key in ipairs({"/", "?"}) do
    cmp.setup.cmdline(cmd_key, {mapping = cmdline_mapping, sources = {{name = "buffer", group_index = 1}}})
  end
  return nil
end
return {"hrsh7th/nvim-cmp", event = {"InsertEnter", "CmdlineEnter"}, dependencies = {"hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline", "hrsh7th/cmp-nvim-lsp", {"binhtran432k/cmp-nvim-lua", branch = "feature/fennel"}, "hrsh7th/cmp-calc", "onsails/lspkind.nvim"}, opts = _8_, config = _12_, version = false}
