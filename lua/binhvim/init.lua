-- [nfnl] Compiled from fnl/binhvim/init.fnl by https://github.com/Olical/nfnl, do not edit.
vim.uv = (vim.uv or vim.loop)
local function setup(opts)
  local _let_1_ = require("binhvim.config")
  local setup0 = _let_1_["setup"]
  return setup0(opts)
end
local function open_workspace_recent()
  local current_buffer = vim.api.nvim_get_current_buf()
  local current_file = vim.api.nvim_buf_get_name(current_buffer)
  local cwd = vim.loop.cwd()
  local cwd0 = cwd:gsub("\\", "\\\\")
  for _, file in ipairs(vim.v.oldfiles) do
    local file_stat = vim.loop.fs_stat(file)
    if (file_stat and (file_stat.type == "file") and (file ~= current_file) and (file:sub(1, #cwd0) == cwd0)) then
      vim.cmd(("edit " .. file))
      return
    else
    end
  end
  return nil
end
return {setup = setup, open_workspace_recent = open_workspace_recent}
