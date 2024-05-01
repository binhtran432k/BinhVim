-- [nfnl] Compiled from fnl/binhvim/plugins/init.fnl by https://github.com/Olical/nfnl, do not edit.
if (vim.fn.has("nvim-0.9.0") == 0) then
  vim.api.nvim_echo({{"BinhVim requires Neovim >= 0.9.0\n", "ErrorMsg"}, {"Press any key to exit", "MoreMsg"}}, true, {})
  vim.fn.getchar()
  vim.cmd("quit")
  return {}
else
  local _let_1_ = require("binhvim.config")
  local init = _let_1_["init"]
  init()
  local function _2_()
    vim.g.startuptime_tries = 10
    return nil
  end
  return {{"folke/lazy.nvim", version = "*"}, {"binhtran432k/BinhVim", priority = 10000, config = true, cond = true, version = "*", lazy = false}, {"Olical/nfnl", ft = "fennel", event = "LazyFile"}, {"dstein64/vim-startuptime", cmd = "StartupTime", config = _2_}, {"nvim-lua/plenary.nvim", lazy = true}, {"binhtran432k/dracula.nvim", lazy = true}, {"nvim-tree/nvim-web-devicons", lazy = true}}
end
