-- [nfnl] Compiled from fnl/binhvim/config/plugins/mason.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local mason_path = table.concat({vim.fn.stdpath("data"), "mason", "bin"}, "/")
  local os_uname = vim.uv.os_uname()
  local window_3f = (os_uname.version):match("Windows")
  local path_sep
  if window_3f then
    path_sep = ";"
  else
    path_sep = ":"
  end
  vim.env.PATH = table.concat({mason_path, vim.env.PATH}, path_sep)
  return nil
end
local function _3_()
  return {}
end
return {init = _1_, opts = _3_}
