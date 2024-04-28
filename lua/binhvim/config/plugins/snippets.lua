-- [nfnl] Compiled from fnl/binhvim/config/plugins/snippets.fnl by https://github.com/Olical/nfnl, do not edit.
local function keys()
  local function _1_()
    if vim.snippet.jumpable(1) then
      local function _2_()
        return vim.snippet.jump(1)
      end
      return vim.schedule(_2_)
    else
      return "<tab>"
    end
  end
  local function _4_()
    local function _5_()
      return vim.snippet.jump(1)
    end
    return vim.schedule(_5_)
  end
  local function _6_()
    if vim.snippet.jumpable(-1) then
      local function _7_()
        return vim.snippet.jump(-1)
      end
      return vim.schedule(_7_)
    else
      return "<s-tab>"
    end
  end
  return {{"<tab>", _1_, expr = true, silent = true, mode = "i"}, {"<tab>", _4_, expr = true, silent = true, mode = "s"}, {"<s-tab>", _6_, expr = true, silent = true, mode = {"i", "s"}}}
end
local function opts()
  return {friendly_snippets = true}
end
return {keys = keys, opts = opts}
