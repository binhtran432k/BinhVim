-- [nfnl] Compiled from fnl/binhvim/config/options.fnl by https://github.com/Olical/nfnl, do not edit.
local function setup()
  vim.g.mapleader = " "
  vim.g.maplocalleader = "\\"
  vim.opt.autowrite = true
  if not vim.env.SSH_TTY then
    vim.opt.clipboard = "unnamedplus"
  else
  end
  vim.opt.completeopt = "menu,menuone,noselect"
  vim.opt.conceallevel = 2
  vim.opt.confirm = true
  vim.opt.cursorline = true
  vim.opt.expandtab = true
  vim.opt.formatoptions = "jcroqlnt"
  vim.opt.grepformat = "%f:%l:%c:%m"
  vim.opt.grepprg = "rg --vimgrep"
  vim.opt.ignorecase = true
  vim.opt.inccommand = "nosplit"
  vim.opt.laststatus = 3
  vim.opt.list = true
  vim.opt.mouse = "a"
  vim.opt.number = true
  vim.opt.pumblend = 10
  vim.opt.pumheight = 10
  vim.opt.relativenumber = true
  vim.opt.scrolloff = 4
  vim.opt.sessionoptions = {"buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds"}
  vim.opt.shiftround = true
  vim.opt.shiftwidth = 2
  do end (vim.opt.shortmess):append({W = true, I = true, c = true, C = true})
  vim.opt.showmode = false
  vim.opt.sidescrolloff = 8
  vim.opt.signcolumn = "yes"
  vim.opt.smartcase = true
  vim.opt.smartindent = true
  vim.opt.spelllang = {"en"}
  vim.opt.splitbelow = true
  vim.opt.splitkeep = "screen"
  vim.opt.splitright = true
  vim.opt.tabstop = 2
  vim.opt.termguicolors = true
  if not vim.g.vscode then
    vim.opt.timeoutlen = 300
  else
  end
  vim.opt.undofile = true
  vim.opt.undolevels = 10000
  vim.opt.updatetime = 200
  vim.opt.virtualedit = "block"
  vim.opt.wildmode = "longest:full,full"
  vim.opt.winminwidth = 5
  vim.opt.wrap = false
  vim.opt.fillchars = {foldopen = "\239\145\188", foldclose = "\239\145\160", fold = " ", foldsep = " ", diff = "\226\149\177", eob = " "}
  if (vim.fn.has("nvim-0.10") == 1) then
    vim.opt.smoothscroll = true
  else
  end
  vim.g["loaded_node_provider"] = 0
  vim.g["loaded_perl_provider"] = 0
  vim.g["loaded_python3_provider"] = 0
  vim.g["loaded_ruby_provider"] = 0
  return {nil, nil, nil, nil}
end
return {setup = setup}
