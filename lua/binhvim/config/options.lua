-- [nfnl] Compiled from fnl/binhvim/config/options.fnl by https://github.com/Olical/nfnl, do not edit.
local function setup()
  vim.g["mapleader"] = " "
  vim.g["maplocalleader"] = " "
  vim.g["speeddating_no_mappings"] = 1
  vim.g["themeCache"] = (vim.fn.stdpath("data") .. "/colors_data/")
  do end (vim.g)["transparency"] = false
  do local _ = {nil, nil, nil, nil, nil} end
  vim.opt["number"] = true
  vim.opt["shiftwidth"] = 4
  vim.opt["tabstop"] = 4
  vim.opt["softtabstop"] = 4
  vim.opt["smartindent"] = true
  vim.opt["smartcase"] = true
  vim.opt["ignorecase"] = true
  vim.opt["clipboard"] = "unnamedplus"
  vim.opt["undofile"] = true
  vim.opt["mouse"] = "a"
  vim.opt["cursorline"] = true
  vim.opt["laststatus"] = 3
  vim.opt["showtabline"] = 2
  vim.opt["splitbelow"] = true
  vim.opt["splitright"] = true
  vim.opt["termguicolors"] = true
  vim.opt["timeoutlen"] = 300
  vim.opt["updatetime"] = 200
  vim.opt["background"] = "dark"
  vim.opt["fillchars"] = {foldopen = "\239\145\188", foldclose = "\239\145\160", fold = " ", foldsep = " ", diff = "\226\149\177", eob = " "}
  vim.opt["relativenumber"] = false
  vim.opt["ruler"] = false
  vim.opt["swapfile"] = false
  vim.opt["showmode"] = false
  do local _ = {nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil} end
  do end (vim.opt.shortmess):append("sI")
  do end (vim.opt.formatoptions):remove("c", "r", "o")
  do end (vim.opt.whichwrap):append("<>[]hl")
  do end (vim.g)["loaded_2html_plugin"] = 1
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
