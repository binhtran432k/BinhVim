-- [nfnl] Compiled from fnl/binhvim/config/autocmds.fnl by https://github.com/Olical/nfnl, do not edit.
local function setup()
  local function _1_()
    if (vim.o.buftype ~= "nofile") then
      return vim.cmd("checktime | redraw")
    else
      return nil
    end
  end
  vim.api.nvim_create_autocmd({"FocusGained", "TermClose", "TermLeave"}, {callback = _1_, group = vim.api.nvim_create_augroup("binhvim_checktime", {clear = true})})
  local function _3_()
    return vim.highlight.on_yank()
  end
  vim.api.nvim_create_autocmd("TextYankPost", {callback = _3_, group = vim.api.nvim_create_augroup("binhvim_highlight_yank", {clear = true}), pattern = "*"})
  local function _4_()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    return vim.cmd(("tabnext " .. current_tab))
  end
  vim.api.nvim_create_autocmd("VimResized", {callback = _4_, group = vim.api.nvim_create_augroup("binhvim_resize_splits", {clear = true})})
  local function _5_(event)
    local excludes = {"gitcommit", "starter"}
    local buf = event.buf
    local ft = vim.bo[buf].filetype
    local buf_vars = vim.b[buf]
    if not (vim.tbl_contains(excludes, ft) or buf_vars.lazyvim_last_loc) then
      buf_vars.lazyvim_last_loc = true
      local mark = vim.api.nvim_buf_get_mark(buf, "\"")
      local lcount = vim.api.nvim_buf_line_count(buf)
      if ((0 < mark[1]) and (mark[1] <= lcount)) then
        return pcall(vim.api.nvim_win_set_cursor, 0, mark)
      else
        return nil
      end
    else
      return nil
    end
  end
  vim.api.nvim_create_autocmd("BufReadPost", {callback = _5_, group = vim.api.nvim_create_augroup("binhvim_last_loc", {clear = true})})
  local function _10_(_8_)
    local _arg_9_ = _8_
    local buf = _arg_9_["buf"]
    vim.bo[buf]["buflisted"] = false
    return vim.keymap.set("n", "q", "<cmd>close<cr>", {buffer = buf, desc = "Close window", nowait = true, silent = true})
  end
  vim.api.nvim_create_autocmd("FileType", {callback = _10_, group = vim.api.nvim_create_augroup("binhvim_close_with_q_filetype", {clear = true}), pattern = {"help", "PlenaryTestPopup", "lspinfo", "notify", "qf", "query", "spectre_panel", "startuptime", "tsplayground", "neotest-output", "checkhealth", "neotest-summary", "neotest-output-panel"}})
  local function _13_(_11_)
    local _arg_12_ = _11_
    local buf = _arg_12_["buf"]
    local buftype = vim.api.nvim_get_option_value("buftype", {buf = buf})
    local buftype_ignored_3f = (vim.tbl_contains({"nofile", "quickfix", "help"}, buftype) and (vim.fn.maparg("q", "n") == ""))
    if buftype_ignored_3f then
      vim.bo[buf]["buflisted"] = false
      return vim.keymap.set("n", "q", "<cmd>close<cr>", {buffer = buf, desc = "Close window", nowait = true, silent = true})
    else
      return nil
    end
  end
  vim.api.nvim_create_autocmd("BufWinEnter", {callback = _13_, group = vim.api.nvim_create_augroup("binhvim_close_with_q_buftype", {clear = true})})
  local function _15_(event)
    vim.bo[event.buf]["buflisted"] = false
    return nil
  end
  vim.api.nvim_create_autocmd("FileType", {callback = _15_, group = vim.api.nvim_create_augroup("binhvim_man_unlisted", {clear = true}), pattern = {"man"}})
  local function _16_()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    return nil
  end
  vim.api.nvim_create_autocmd("FileType", {callback = _16_, group = vim.api.nvim_create_augroup("binhvim_wrap_spell", {clear = true}), pattern = {"gitcommit", "markdown"}})
  local function _17_()
    vim.opt_local.conceallevel = 0
    return nil
  end
  vim.api.nvim_create_autocmd("FileType", {callback = _17_, group = vim.api.nvim_create_augroup("binhvim_json_conceal", {clear = true}), pattern = {"json", "jsonc", "json5"}})
  local function _18_(event)
    if not (event.match):match("^%w%w+://") then
      return vim.fn.mkdir(vim.fn.fnamemodify((vim.loop.fs_realpath(event.match) or event.match()), ":p:h"), "p")
    else
      return nil
    end
  end
  vim.api.nvim_create_autocmd("BufWritePre", {callback = _18_, group = vim.api.nvim_create_augroup("binhvim_auto_create_dir", {clear = true})})
  local function _20_()
    vim.opt_local.number = false
    vim.opt_local.cursorline = false
    vim.opt_local.foldcolumn = "0"
    vim.opt_local.signcolumn = "no"
    return vim.cmd("startinsert")
  end
  vim.api.nvim_create_autocmd("TermOpen", {callback = _20_, group = vim.api.nvim_create_augroup("binhvim_simplify_terminal", {clear = true}), pattern = "*"})
  local function _21_()
    vim.opt_local.number = false
    vim.opt_local.cursorline = false
    vim.b.miniindentscope_disable = true
    return nil
  end
  vim.api.nvim_create_autocmd("FileType", {callback = _21_, group = vim.api.nvim_create_augroup("binhvim_simplify_ui", {clear = true}), pattern = {"neo-tree", "PlenaryTestPopup", "checkhealth", "fugitive", "git", "gitcommit", "help", "lazy", "lazyterm", "lspinfo", "man", "mason", "notify", "qf", "NvimTree", "query", "spectre_panel", "startuptime", "tsplayground", "Trouble", "trouble", "toggleterm"}})
  local function _22_(opts)
    vim.bo.expandtab = false
    local args_2_auto = opts.args
    local indent_3_auto
    if (args_2_auto ~= "") then
      indent_3_auto = tonumber(args_2_auto)
    else
      indent_3_auto = 4
    end
    vim.bo["shiftwidth"] = indent_3_auto
    vim.bo["softtabstop"] = indent_3_auto
    vim.bo["tabstop"] = indent_3_auto
    return nil
  end
  vim.api.nvim_create_user_command("IndentTab", _22_, {nargs = "?"})
  local function _24_(opts)
    vim.bo.expandtab = true
    local args_2_auto = opts.args
    local indent_3_auto
    if (args_2_auto ~= "") then
      indent_3_auto = tonumber(args_2_auto)
    else
      indent_3_auto = 4
    end
    vim.bo["shiftwidth"] = indent_3_auto
    vim.bo["softtabstop"] = indent_3_auto
    vim.bo["tabstop"] = indent_3_auto
    return nil
  end
  return vim.api.nvim_create_user_command("IndentSpace", _24_, {nargs = "?"})
end
return {setup = setup}
