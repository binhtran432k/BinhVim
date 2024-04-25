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
  vim.g["loaded_2html_plugin"] = 1
  vim.g["loaded_getscript"] = 1
  vim.g["loaded_getscriptPlugin"] = 1
  vim.g["loaded_gzip"] = 1
  vim.g["loaded_logipat"] = 1
  vim.g["loaded_netrw"] = 1
  vim.g["loaded_netrwPlugin"] = 1
  vim.g["loaded_netrwSettings"] = 1
  vim.g["loaded_netrwFileHandlers"] = 1
  vim.g["loaded_tar"] = 1
  vim.g["loaded_tarPlugin"] = 1
  vim.g["loaded_rrhelper"] = 1
  vim.g["loaded_spellfile_plugin"] = 1
  vim.g["loaded_vimball"] = 1
  vim.g["loaded_vimballPlugin"] = 1
  vim.g["loaded_zip"] = 1
  vim.g["loaded_zipPlugin"] = 1
  vim.g["loaded_logipat"] = 1
  vim.g["loaded_matchit"] = 1
  vim.g["loaded_tutor"] = 1
  vim.g["loaded_rplugin"] = 1
  vim.g["loaded_syntax"] = 1
  vim.g["loaded_synmenu"] = 1
  vim.g["loaded_optwin"] = 1
  vim.g["loaded_compiler"] = 1
  vim.g["loaded_bugreport"] = 1
  vim.g["loaded_ftplugin"] = 1
  vim.g["loaded_archlinux"] = 1
  vim.g["loaded_fzf"] = 1
  vim.g["loaded_tutor_mode_plugin"] = 1
  vim.g["loaded_sleuth"] = 1
  vim.g["loaded_vimgrep"] = 1
  do local _ = {nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil} end
  vim.g["loaded_node_provider"] = 0
  vim.g["loaded_perl_provider"] = 0
  vim.g["loaded_python3_provider"] = 0
  vim.g["loaded_ruby_provider"] = 0
  return {nil, nil, nil, nil}
end
return {setup = setup}
