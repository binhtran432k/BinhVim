-- [nfnl] Compiled from fnl/binhvim/config/init.fnl by https://github.com/Olical/nfnl, do not edit.
local function lazy_file()
  local lazy_file_3f = (0 < vim.fn.argc(-1))
  local event_plug = require("lazy.core.handler.event")
  if lazy_file_3f then
    event_plug.mappings.LazyFile = {id = "LazyFile", event = "User", pattern = "LazyFile"}
    event_plug.mappings["User LazyFile"] = event_plug.mappings.LazyFile
  else
    event_plug.mappings.LazyFile = {id = "LazyFile", event = {"BufReadPost", "BufNewFile", "BufWritePre"}}
    event_plug.mappings["User LazyFile"] = event_plug.mappings.LazyFile
  end
  if lazy_file_3f then
    local events = {}
    local done = false
    local function load_event()
      if not ((#events == 0) or done) then
        done = true
        vim.api.nvim_del_augroup_by_name("lazy_file")
        local skips = {}
        for _, _2_ in ipairs(events) do
          local _each_3_ = _2_
          local event = _each_3_["event"]
          skips[event] = (skips[event] or event_plug.get_augroups(event))
        end
        vim.api.nvim_exec_autocmds("User", {pattern = "LazyFile", modeline = false})
        for _, _4_ in ipairs(events) do
          local _each_5_ = _4_
          local event = _each_5_["event"]
          local data = _each_5_["data"]
          local buf = _each_5_["buf"]
          if vim.api.nvim_buf_is_valid(buf) then
            event_plug.trigger({event = event, exclude = skips[event], data = data, buf = buf})
            if vim.bo[buf].filetype then
              event_plug.trigger({event = "FileType", buf = buf})
            else
            end
          else
          end
        end
        vim.api.nvim_exec_autocmds("CursorMoved", {modeline = false})
        events = {}
        return nil
      else
        return nil
      end
    end
    local load_event_async = vim.schedule_wrap(load_event)
    local group = vim.api.nvim_create_augroup("lazy_file", {clear = true})
    local function _9_(event)
      table.insert(events, event)
      return load_event_async()
    end
    return vim.api.nvim_create_autocmd({"BufReadPost", "BufNewFile", "BufWritePre"}, {group = group, callback = _9_})
  else
    return nil
  end
end
local init_3f = false
local function init()
  if init_3f then
    return
  else
  end
  init_3f = true
  do
    local lazy_config = require("lazy.core.config")
    local plugin = lazy_config.spec.plugins.LazyVim
    if plugin then
      do end (vim.opt.rtp):append(plugin.dir)
    else
    end
  end
  do
    do end (require("binhvim.config.options")).setup()
    pcall(require, "config.options")
  end
  return lazy_file()
end
local function setup(opts)
  local colorscheme = (opts.colorscheme or "dracula")
  local lazy_autocmds_3f = (vim.fn.argc(-1) == 0)
  pcall(vim.cmd, ("colorscheme " .. colorscheme))
  if not lazy_autocmds_3f then
    do end (require("binhvim.config.autocmds")).setup()
    pcall(require, "config.autocmds")
  else
  end
  local function _14_()
    if lazy_autocmds_3f then
      do end (require("binhvim.config.autocmds")).setup()
      pcall(require, "config.autocmds")
    else
    end
    do end (require("binhvim.config.keymaps")).setup()
    return pcall(require, "config.keymaps")
  end
  return vim.api.nvim_create_autocmd("User", {callback = _14_, group = vim.api.nvim_create_augroup("binhvim_BinhVim", {clear = true}), pattern = "VeryLazy"})
end
return {init = init, setup = setup}
