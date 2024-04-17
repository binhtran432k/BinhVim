-- [nfnl] Compiled from fnl/binhvim/config/init.fnl by https://github.com/Olical/nfnl, do not edit.
local function init()
  do end (require("binhvim.config.options")).setup()
  return pcall(require, "config.options")
end
local function setup(opts)
  local lazy_autocmds_3f = (vim.fn.argc(-1) == 0)
  local lazy_group = vim.api.nvim_create_augroup("BinhVim", {clear = true})
  if not lazy_autocmds_3f then
    do end (require("binhvim.config.autocmds")).setup()
    pcall(require, "config.autocmds")
  else
  end
  local function _2_()
    if lazy_autocmds_3f then
      do end (require("binhvim.config.autocmds")).setup()
      pcall(require, "config.autocmds")
    else
    end
    do end (require("binhvim.config.keymaps")).setup()
    return pcall(require, "config.keymaps")
  end
  return vim.api.nvim_create_autocmd("User", {group = lazy_group, pattern = "VeryLazy", callback = _2_})
end
return {init = init, setup = setup}
