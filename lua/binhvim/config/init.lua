-- [nfnl] Compiled from fnl/binhvim/config/init.fnl by https://github.com/Olical/nfnl, do not edit.
local function init()
  do end (require("binhvim.config.options")).setup()
  return pcall(require, "config.options")
end
local function setup(opts)
  local lazy_autocmds_3f = (vim.fn.argc(-1) == 0)
  if opts.colorscheme then
    pcall(vim.cmd, ("colorscheme " .. opts.colorscheme))
  else
  end
  if not lazy_autocmds_3f then
    do end (require("binhvim.config.autocmds")).setup()
    pcall(require, "config.autocmds")
  else
  end
  local function _3_()
    if lazy_autocmds_3f then
      do end (require("binhvim.config.autocmds")).setup()
      pcall(require, "config.autocmds")
    else
    end
    do end (require("binhvim.config.keymaps")).setup()
    return pcall(require, "config.keymaps")
  end
  return vim.api.nvim_create_autocmd("User", {callback = _3_, group = vim.api.nvim_create_augroup("binhvim_BinhVim", {clear = true}), pattern = "VeryLazy"})
end
return {init = init, setup = setup}
