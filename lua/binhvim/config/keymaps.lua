-- [nfnl] Compiled from fnl/binhvim/config/keymaps.fnl by https://github.com/Olical/nfnl, do not edit.
local function setup()
  local vscode_3f
  if vim.g.vscode then
    vscode_3f = true
  else
    vscode_3f = false
  end
  local nu = {number = true, relativenumber = true}
  local function toggle_number()
    local number = (vim.opt_local.number):get()
    local relativenumber = (vim.opt_local.relativenumber):get()
    if (number or relativenumber) then
      nu.number = number
      nu.relativenumber = relativenumber
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      return nil
    else
      vim.opt_local.number = nu.number
      vim.opt_local.relativenumber = nu.relativenumber
      return nil
    end
  end
  local diagnostics_3f = true
  local function toggle_diagnostic()
    if vim.diagnostic.is_disabled then
      __fnl_global__diagnostic_3f = not vim.diagnostic.is_disabled()
    else
      __fnl_global__diagnostic_3f = not __fnl_global__diagnostic_3f
    end
    if __fnl_global__diagnostic_3f then
      return vim.diagnostic.enable()
    else
      return vim.diagnostic.disable()
    end
  end
  vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", {desc = "Move Cursor Down (Allow Wrapped)", expr = true, silent = true})
  vim.keymap.set("n", "<down>", "v:count == 0 ? 'gj' : 'j'", {desc = "Move Cursor Down (Allow Wrapped)", expr = true, silent = true})
  vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", {desc = "Move Cursor Up (Allow Wrapped)", expr = true, silent = true})
  vim.keymap.set("n", "<up>", "v:count == 0 ? 'gk' : 'k'", {desc = "Move Cursor Up (Allow Wrapped)", expr = true, silent = true})
  vim.keymap.set("n", "<c-h>", "<c-w>h", {desc = "Move Cursor Left Window", remap = vscode_3f, silent = true})
  vim.keymap.set("n", "<c-j>", "<c-w>j", {desc = "Move Cursor Down Window", remap = vscode_3f, silent = true})
  vim.keymap.set("n", "<c-k>", "<c-w>k", {desc = "Move Cursor Up Window", remap = vscode_3f, silent = true})
  vim.keymap.set("n", "<c-l>", "<c-w>l", {desc = "Move Cursor Right Window", remap = vscode_3f, silent = true})
  vim.keymap.set("n", "<c-up>", "<cmd>resize +2<cr>", {desc = "Increase Window Height", silent = true})
  vim.keymap.set("n", "<c-down>", "<cmd>resize -2<cr>", {desc = "Decrease Window Height", silent = true})
  vim.keymap.set("n", "<c-left>", "<cmd>vertical resize +2<cr>", {desc = "Increase Window Width", silent = true})
  vim.keymap.set("n", "<c-right>", "<cmd>vertical resize -2<cr>", {desc = "Decrease Window Width", silent = true})
  vim.keymap.set("n", "<a-j>", "<cmd>m .+1<cr>", {desc = "Move Down", silent = true})
  vim.keymap.set("n", "<a-k>", "<cmd>m .-2<cr>", {desc = "Move Up", silent = true})
  vim.keymap.set("i", "<a-j>", "<esc><cmd>m .+1<cr>gi", {desc = "Move Down", silent = true})
  vim.keymap.set("i", "<a-k>", "<esc><cmd>m .-2<cr>gi", {desc = "Move Up", silent = true})
  vim.keymap.set("v", "<a-j>", ":m '>+1<cr>gvgv", {desc = "Move Down", silent = true})
  vim.keymap.set("v", "<a-k>", ":m '<-2<cr>gvgv", {desc = "Move Up", silent = true})
  do
    local lazy_config = require("lazy.core.config")
    local plugin = lazy_config.spec.plugins["bufferline.nvim"]
    if (plugin == nil) then
      vim.keymap.set("n", "<s-h>", "<cmd>bprevious<cr>", {desc = "Prev Buffer", silent = true})
      vim.keymap.set("n", "<s-l>", "<cmd>bnext<cr>", {desc = "Next Buffer", silent = true})
      vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", {desc = "Prev Buffer", silent = true})
      vim.keymap.set("n", "]b", "<cmd>bnext<cr>", {desc = "Next Buffer", silent = true})
    else
    end
  end
  vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>", {desc = "Switch to Other Buffer", silent = true})
  vim.keymap.set("n", "<leader>`", "<cmd>e #<cr>", {desc = "Switch to Other Buffer", silent = true})
  vim.keymap.set({"i", "n"}, "<esc>", "<cmd>noh<cr><esc>", {desc = "Escape and Clear hlsearch", silent = true})
  vim.keymap.set("n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", {desc = "Redraw / Clear hlsearch / Diff Update", silent = true})
  vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", {desc = "Next Search Result", expr = true, silent = true})
  vim.keymap.set("x", "n", "'Nn'[v:searchforward]", {desc = "Next Search Result", expr = true, silent = true})
  vim.keymap.set("o", "n", "'Nn'[v:searchforward]", {desc = "Next Search Result", expr = true, silent = true})
  vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", {desc = "Prev Search Result", expr = true, silent = true})
  vim.keymap.set("x", "N", "'nN'[v:searchforward]", {desc = "Prev Search Result", expr = true, silent = true})
  vim.keymap.set("o", "N", "'nN'[v:searchforward]", {desc = "Prev Search Result", expr = true, silent = true})
  vim.keymap.set("i", ",", ",<c-g>u", {silent = true})
  vim.keymap.set("i", ".", ".<c-g>u", {silent = true})
  vim.keymap.set("i", ";", ";<c-g>u", {silent = true})
  vim.keymap.set({"i", "x", "n", "s"}, "<C-s>", "<cmd>silent! update | redraw<cr><esc>", {desc = "Save File", silent = true})
  vim.keymap.set("n", "<leader>K", "<cmd>norm! K<cr>", {desc = "Keywordprg", silent = true})
  vim.keymap.set("v", "<", "<gv", {silent = true})
  vim.keymap.set("v", ">", ">gv", {silent = true})
  vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", {desc = "Lazy", silent = true})
  vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", {desc = "New File", silent = true})
  vim.keymap.set("n", "<leader>xl", "<cmd>lopen<cr>", {desc = "Location List", silent = true})
  vim.keymap.set("n", "<leader>xq", "<cmd>copen<cr>", {desc = "Quickfix List", silent = true})
  vim.keymap.set("n", "[q", vim.cmd.cprev, {desc = "Previous Quickfix", silent = true})
  vim.keymap.set("n", "]q", vim.cmd.cnext, {desc = "Next Quickfix", silent = true})
  vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, {desc = "Line Diagnostics", silent = true})
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {desc = "Next Diagnostic", silent = true})
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {desc = "Prev Diagnostic", silent = true})
  local function _6_()
    return vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})
  end
  vim.keymap.set("n", "]e", _6_, {desc = "Next Error", silent = true})
  local function _7_()
    return vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})
  end
  vim.keymap.set("n", "[e", _7_, {desc = "Prev Error", silent = true})
  local function _8_()
    return vim.diagnostic.goto_next({severity = vim.diagnostic.severity.WARN})
  end
  vim.keymap.set("n", "]w", _8_, {desc = "Next Warning", silent = true})
  local function _9_()
    return vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.WARN})
  end
  vim.keymap.set("n", "[w", _9_, {desc = "Prev Warning", silent = true})
  local function _10_()
    vim.opt_local["spell"] = not (vim.opt_local.spell):get()
    return nil
  end
  vim.keymap.set("n", "<leader>us", _10_, {desc = "Toggle Spelling", silent = true})
  local function _11_()
    vim.opt_local["wrap"] = not (vim.opt_local.wrap):get()
    return nil
  end
  vim.keymap.set("n", "<leader>uw", _11_, {desc = "Toggle Word Wrap", silent = true})
  local function _12_()
    vim.opt_local["relativenumber"] = not (vim.opt_local.relativenumber):get()
    return nil
  end
  vim.keymap.set("n", "<leader>uL", _12_, {desc = "Toggle Relative Line Numbers", silent = true})
  vim.keymap.set("n", "<leader>ul", toggle_number, {desc = "Toggle Line Numbers", silent = true})
  vim.keymap.set("n", "<leader>ud", toggle_diagnostic, {desc = "Toggle Diagnostics", silent = true})
  local conceallevel
  if (0 < vim.o.conceallevel) then
    conceallevel = vim.o.conceallevel
  else
    conceallevel = 3
  end
  local function _14_()
    local _15_
    if ((vim.opt_local.conceallevel):get() == 0) then
      _15_ = conceallevel
    else
      _15_ = 0
    end
    vim.opt_local["conceallevel"] = _15_
    return nil
  end
  vim.keymap.set("n", "<leader>uc", _14_, {desc = "Toggle Conceal", silent = true})
  local function _17_()
    if vim.b.ts_highlight then
      return vim.treesitter.stop()
    else
      return vim.treesitter.start()
    end
  end
  vim.keymap.set("n", "<leader>uT", _17_, {desc = "Toggle Treesitter Highlight", silent = true})
  local function _19_()
    local _20_
    if ((vim.opt_local.background):get() == "light") then
      _20_ = "dark"
    else
      _20_ = "light"
    end
    vim.opt_local["background"] = _20_
    return nil
  end
  vim.keymap.set("n", "<leader>ub", _19_, {desc = "Toggle Background", silent = true})
  vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", {desc = "Quit All", silent = true})
  vim.keymap.set("n", "<leader>ui", vim.show_pos, {desc = "Inspect Pos", silent = true})
  vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", {desc = "Enter Normal Mode", silent = true})
  vim.keymap.set("t", "<C-h>", "<cmd>wincmd h<cr>", {desc = "Go to Left Window", silent = true})
  vim.keymap.set("t", "<C-j>", "<cmd>wincmd j<cr>", {desc = "Go to Lower Window", silent = true})
  vim.keymap.set("t", "<C-k>", "<cmd>wincmd k<cr>", {desc = "Go to Upper Window", silent = true})
  vim.keymap.set("t", "<C-l>", "<cmd>wincmd l<cr>", {desc = "Go to Right Window", silent = true})
  vim.keymap.set("t", "<C-/>", "<cmd>close<cr>", {desc = "Hide Terminal", silent = true})
  vim.keymap.set("t", "<c-_>", "<cmd>close<cr>", {desc = "which_key_ignore", silent = true})
  vim.keymap.set("n", "<leader>ww", "<C-W>p", {desc = "Other Window", remap = vscode_3f, silent = true})
  vim.keymap.set("n", "<leader>wd", "<C-W>c", {desc = "Delete Window", remap = vscode_3f, silent = true})
  vim.keymap.set("n", "<leader>w-", "<C-W>s", {desc = "Split Window Below", remap = vscode_3f, silent = true})
  vim.keymap.set("n", "<leader>w|", "<C-W>v", {desc = "Split Window Right", remap = vscode_3f, silent = true})
  vim.keymap.set("n", "<leader>-", "<C-W>s", {desc = "Split Window Below", remap = vscode_3f, silent = true})
  vim.keymap.set("n", "<leader>|", "<C-W>v", {desc = "Split Window Right", remap = vscode_3f, silent = true})
  vim.keymap.set("n", "<leader><tab>l", "<cmd>tablast<cr>", {desc = "Last Tab", silent = true})
  vim.keymap.set("n", "<leader><tab>f", "<cmd>tabfirst<cr>", {desc = "First Tab", silent = true})
  vim.keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", {desc = "New Tab", silent = true})
  vim.keymap.set("n", "<leader><tab>]", "<cmd>tabnext<cr>", {desc = "Next Tab", silent = true})
  vim.keymap.set("n", "<leader><tab>d", "<cmd>tabclose<cr>", {desc = "Close Tab", silent = true})
  return vim.keymap.set("n", "<leader><tab>[", "<cmd>tabprevious<cr>", {desc = "Previous Tab", silent = true})
end
return {setup = setup}
