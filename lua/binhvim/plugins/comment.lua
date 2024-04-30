-- [nfnl] Compiled from fnl/binhvim/plugins/comment.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  return {pre_hook = (require("ts_context_commentstring.integrations.comment_nvim")).create_pre_hook()}
end
return {{"JoosepAlviste/nvim-ts-context-commentstring", lazy = true, opts = {enable_autocmd = false}}, {"numToStr/Comment.nvim", keys = {{"gc", desc = "+comment line", mode = {"n", "x"}}, {"gb", desc = "+comment block", mode = {"n", "x"}}}, opts = _1_}}
