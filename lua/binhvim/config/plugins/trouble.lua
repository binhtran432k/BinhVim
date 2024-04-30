-- [nfnl] Compiled from fnl/binhvim/config/plugins/trouble.fnl by https://github.com/Olical/nfnl, do not edit.
local function opts()
  return {use_diagnostic_signs = true}
end
local function keys()
  local function _1_()
    local _let_2_ = require("trouble")
    local is_open = _let_2_["is_open"]
    local previous = _let_2_["previous"]
    if is_open() then
      return previous({skip_groups = true, jump = true})
    else
      local ok, err = pcall(vim.cmd.cprev)
      if not ok then
        return vim.notify(err, vim.log.levels.ERROR)
      else
        return nil
      end
    end
  end
  local function _5_()
    local _let_6_ = require("trouble")
    local is_open = _let_6_["is_open"]
    local next = _let_6_["next"]
    if is_open() then
      return next({skip_groups = true, jump = true})
    else
      local ok, err = pcall(vim.cmd.cnext)
      if not ok then
        return vim.notify(err, vim.log.levels.ERROR)
      else
        return nil
      end
    end
  end
  return {{"<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)"}, {"<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)"}, {"<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)"}, {"<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)"}, {"[q", _1_, desc = "Previous Trouble/Quickfix Item"}, {"]q", _5_, desc = "Next Trouble/Quickfix Item"}}
end
return {keys = keys, opts = opts}
