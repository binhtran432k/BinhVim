-- [nfnl] Compiled from fnl/binhvim/config/autocmds.fnl by https://github.com/Olical/nfnl, do not edit.
local function setup()
  local function _1_(args)
    if not (args.match):match("^%w%w+://") then
      return vim.fn.mkdir(vim.fn.fnamemodify((vim.loop.fs_realpath(args.match) or args.match()), ":p:h"), "p")
    else
      return nil
    end
  end
  vim.api.nvim_create_autocmd("BufWritePre", {callback = _1_, desc = "Automatically create parent directories if they don't exist when saving a file", group = vim.api.nvim_create_augroup("auto_create_dir", {clear = true})})
  local function _3_()
    return vim.highlight.on_yank()
  end
  vim.api.nvim_create_autocmd("TextYankPost", {callback = _3_, desc = "Highlight yanked text", group = vim.api.nvim_create_augroup("highlight_yank", {clear = true}), pattern = "*"})
  local function _4_()
    vim.opt_local.number = false
    vim.opt_local.cursorline = false
    vim.opt_local.foldcolumn = "0"
    vim.opt_local.signcolumn = "no"
    return vim.cmd("startinsert")
  end
  vim.api.nvim_create_autocmd("TermOpen", {callback = _4_, desc = "Disable number and cursorline in terminal", pattern = "*"})
  local function _5_()
    vim.opt_local.number = false
    vim.opt_local.cursorline = false
    vim.b.miniindentscope_disable = true
    return nil
  end
  vim.api.nvim_create_autocmd("FileType", {callback = _5_, desc = "Disable miniindentscope, number, and cursorline in specific filetypes", pattern = {"neo-tree", "PlenaryTestPopup", "checkhealth", "fugitive", "git", "gitcommit", "help", "lazy", "lazyterm", "lspinfo", "man", "mason", "notify", "qf", "query", "spectre_panel", "startuptime", "tsplayground", "Trouble", "trouble", "toggleterm"}})
  local function _6_(args)
    local buftype = vim.api.nvim_get_option_value("buftype", {buf = args.buf})
    if (vim.tbl_contains({"help", "nofile", "quickfix"}, buftype) and (vim.fn.maparg("q", "n") == "")) then
      return vim.keymap.set("n", "q", "<cmd>close<cr>", {desc = "Close window", buffer = args.buf, silent = true, nowait = true})
    else
      return nil
    end
  end
  return vim.api.nvim_create_autocmd("BufWinEnter", {callback = _6_, desc = "Make q close help, man, quickfix, dap floats", group = vim.api.nvim_create_augroup("q_close_windows", {clear = true})})
end
return {setup = setup}
