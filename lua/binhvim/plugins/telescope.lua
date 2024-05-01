-- [nfnl] Compiled from fnl/binhvim/plugins/telescope.fnl by https://github.com/Olical/nfnl, do not edit.
local _1_
if (vim.fn.executable("make") == 1) then
  _1_ = "make"
else
  _1_ = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
end
local function _3_()
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local open_with_trouble
  local function _4_(...)
    return (require("trouble.providers.telescope")).open_with_trouble(...)
  end
  open_with_trouble = _4_
  local open_selected_with_trouble
  local function _5_(...)
    return (require("trouble.providers.telescope")).open_selected_with_trouble(...)
  end
  open_selected_with_trouble = _5_
  local find_files_no_ignore
  local function _6_()
    local action_state_2_auto = require("telescope.actions.state")
    local line_3_auto = action_state_2_auto.get_current_line()
    local _let_7_ = require("telescope.builtin")
    local find_4_auto = _let_7_["find_files"]
    return find_4_auto({no_ignore = true, default_text = line_3_auto})
  end
  find_files_no_ignore = _6_
  local find_files_with_hidden
  local function _8_()
    local action_state_2_auto = require("telescope.actions.state")
    local line_3_auto = action_state_2_auto.get_current_line()
    local _let_9_ = require("telescope.builtin")
    local find_4_auto = _let_9_["find_files"]
    return find_4_auto({hidden = true, default_text = line_3_auto})
  end
  find_files_with_hidden = _8_
  local function _10_()
    return telescope.load_extension("fzf")
  end
  local function _11_()
    local wins = vim.api.nvim_list_wins()
    local current_win = vim.api.nvim_get_current_win()
    table.insert(wins, 1, current_win)
    local found_win_3f = false
    local found_win = 0
    for _, win in ipairs(wins) do
      if found_win_3f then break end
      local buf = vim.api.nvim_win_get_buf(win)
      local buf_opt = vim.bo[buf]
      if (buf_opt.buftype == "") then
        found_win_3f = true
        found_win = win
      else
      end
    end
    return found_win
  end
  return {binh_onload = {fzf = _10_}, defaults = {get_selection_window = _11_, mappings = {i = {["<c-t>"] = open_with_trouble, ["<a-t>"] = open_selected_with_trouble, ["<a-i>"] = find_files_no_ignore, ["<a-h>"] = find_files_with_hidden, ["<c-down>"] = actions.cycle_history_next, ["<c-up>"] = actions.cycle_history_prev, ["<c-j>"] = actions.move_selection_next, ["<c-k>"] = actions.move_selection_previous, ["<c-d>"] = actions.preview_scrolling_down, ["<c-u>"] = actions.preview_scrolling_up}, n = {q = actions.close, ["<c-j>"] = actions.move_selection_next, ["<c-k>"] = actions.move_selection_previous}}}}
end
local function _13_(_, opts)
  do
    local _let_14_ = require("telescope")
    local setup = _let_14_["setup"]
    setup(opts)
  end
  for _0, onload in pairs(opts.binh_onload) do
    onload()
  end
  return nil
end
return {"nvim-telescope/telescope.nvim", cmd = "Telescope", dependencies = {"nvim-telescope/telescope-symbols.nvim", {"nvim-telescope/telescope-fzf-native.nvim", build = _1_, enabled = ((vim.fn.executable("make") == 1) or (vim.fn.executable("cmake") == 1))}}, keys = {{"<leader>,", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Switch Buffer"}, {"<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep"}, {"<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History"}, {"<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files"}, {"<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers"}, {"<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)"}, {"<leader>fr", "<cmd>Telescope oldfiles only_cwd=true<cr>", desc = "Recent"}, {"<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits"}, {"<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status"}, {"<leader>s\"", "<cmd>Telescope registers<cr>", desc = "Registers"}, {"<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands"}, {"<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer"}, {"<leader>s*", "<cmd>Telescope symbols<cr>", desc = "Command Symbols"}, {"<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History"}, {"<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands"}, {"<leader>sd", "<cmd>Telescope diagnostics bufnr0<cr>", desc = "Document Diagnostics"}, {"<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics"}, {"<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages"}, {"<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups"}, {"<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps"}, {"<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages"}, {"<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark"}, {"<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options"}, {"<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume"}}, opts = _3_, config = _13_, version = false}
