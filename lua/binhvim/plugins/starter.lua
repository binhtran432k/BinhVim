-- [nfnl] Compiled from fnl/binhvim/plugins/starter.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local logo = table.concat({"oooooooooo  o88               oooo     ooooo  oooo o88                 ", " 888    888 oooo  oo oooooo    888ooooo 888    88  oooo  oo ooo oooo   ", " 888oooo88   888   888   888   888   888 888  88    888   888 888 888  ", " 888    888  888   888   888   888   888  88888     888   888 888 888  ", "o888ooo888  o888o o888o o888o o888o o888o  888     o888o o888o888o888o "}, "\n")
  local pad = string.rep(" ", 16)
  local starter = require("mini.starter")
  local opts = {evaluate_single = true, header = logo, items = {{action = "Telescope find_files", name = "Find file", section = "                Telescope"}, {action = "Telescope oldfiles only_cwd=true", name = "Recent files", section = "                Telescope"}, {action = "Telescope live_grep", name = "Grep text", section = "                Telescope"}, {action = "Lazy", name = "Lazy", section = "                Config"}, {action = "ene | startinsert", name = "New file", section = "                Built-in"}, {action = "qa", name = "Quit", section = "                Built-in"}, {action = "lua require('binhvim').open_workspace_recent()", name = "Session restore", section = "                Session"}}, content_hooks = {starter.gen_hook.adding_bullet((pad .. "\226\150\145 "), false), starter.gen_hook.aligning("center", "center")}}
  return opts
end
local function _2_(_, opts)
  if (vim.o.filetype == "lazy") then
    vim.cmd.close()
    local function _3_()
      return (require("lazy")).show()
    end
    vim.api.nvim_create_autocmd("User", {pattern = "MiniStarterOpened", callback = _3_})
  else
  end
  local starter = require("mini.starter")
  local load_footer
  local function _5_()
    local lazy = require("lazy")
    local stats = lazy.stats()
    local ms = (math.floor(((stats.startuptime * 100) + 0.5)) / 100)
    local pad_footer = string.rep(" ", 8)
    starter.config.footer = (pad_footer .. "\226\154\161 Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms")
    return pcall(starter.refresh)
  end
  load_footer = _5_
  starter.setup(opts)
  return vim.api.nvim_create_autocmd("User", {pattern = "LazyVimStarted", callback = load_footer})
end
return {"echasnovski/mini.starter", event = "VimEnter", opts = _1_, config = _2_, version = false}
