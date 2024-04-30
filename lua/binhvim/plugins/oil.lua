-- [nfnl] Compiled from fnl/binhvim/plugins/oil.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  if (vim.fn.argc(-1) == 1) then
    local stat_3_auto = vim.uv.fs_stat(vim.fn.argv(0))
    if (stat_3_auto and (stat_3_auto.type == "directory")) then
      return vim.cmd("Oil")
    else
      return nil
    end
  else
    return nil
  end
end
return {"stevearc/oil.nvim", keys = {{"-", "<cmd>Oil<cr>", desc = "Open parent directory"}}, cmd = "Oil", init = _1_, opts = {}}
