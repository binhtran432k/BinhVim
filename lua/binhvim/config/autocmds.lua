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
    local excludes = {"gitcommit"}
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
  local function _8_(event)
    local buftype = vim.api.nvim_get_option_value("buftype", {buf = event.buf})
    if (vim.tbl_contains({"nofile", "quickfix", "PlenaryTestPopup", "help", "lspinfo", "notify", "qf", "query", "spectre_panel", "startuptime", "tsplayground", "neotest-output", "checkhealth", "neotest-summary", "neotest-output-panel"}, buftype) and (vim.fn.maparg("q", "n") == "")) then
      vim.bo[event.buf]["buflisted"] = false
      return vim.keymap.set("n", "q", "<cmd>close<cr>", {desc = "Close window", buffer = event.buf, silent = true, nowait = true})
    else
      return nil
    end
  end
  vim.api.nvim_create_autocmd("BufWinEnter", {callback = _8_, group = vim.api.nvim_create_augroup("binhvim_close_with_q", {clear = true})})
  local function _10_(event)
    vim.bo[event.buf]["buflisted"] = false
    return nil
  end
  vim.api.nvim_create_autocmd("FileType", {callback = _10_, group = vim.api.nvim_create_augroup("binhvim_man_unlisted", {clear = true}), pattern = {"man"}})
  local function _11_()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    return nil
  end
  vim.api.nvim_create_autocmd("FileType", {callback = _11_, group = vim.api.nvim_create_augroup("binhvim_wrap_spell", {clear = true}), pattern = {"gitcommit", "markdown"}})
  local function _12_()
    vim.opt_local.conceallevel = 0
    return nil
  end
  vim.api.nvim_create_autocmd("FileType", {callback = _12_, group = vim.api.nvim_create_augroup("binhvim_json_conceal", {clear = true}), pattern = {"json", "jsonc", "json5"}})
  local function _13_(event)
    if not (event.match):match("^%w%w+://") then
      return vim.fn.mkdir(vim.fn.fnamemodify((vim.loop.fs_realpath(event.match) or event.match()), ":p:h"), "p")
    else
      return nil
    end
  end
  vim.api.nvim_create_autocmd("BufWritePre", {callback = _13_, group = vim.api.nvim_create_augroup("binhvim_auto_create_dir", {clear = true})})
  local function _15_()
    vim.opt_local.number = false
    vim.opt_local.cursorline = false
    vim.opt_local.foldcolumn = "0"
    vim.opt_local.signcolumn = "no"
    return vim.cmd("startinsert")
  end
  vim.api.nvim_create_autocmd("TermOpen", {callback = _15_, group = vim.api.nvim_create_augroup("binhvim_simplify_terminal", {clear = true}), pattern = "*"})
  local function _16_()
    vim.opt_local.number = false
    vim.opt_local.cursorline = false
    vim.b.miniindentscope_disable = true
    return nil
  end
  return vim.api.nvim_create_autocmd("FileType", {callback = _16_, group = vim.api.nvim_create_augroup("binhvim_simplify_ui", {clear = true}), pattern = {"neo-tree", "PlenaryTestPopup", "checkhealth", "fugitive", "git", "gitcommit", "help", "lazy", "lazyterm", "lspinfo", "man", "mason", "notify", "qf", "query", "spectre_panel", "startuptime", "tsplayground", "Trouble", "trouble", "toggleterm"}})
end
return {setup = setup}
