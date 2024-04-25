-- [nfnl] Compiled from fnl/binhvim/plugins.fnl by https://github.com/Olical/nfnl, do not edit.
if (vim.fn.has("nvim-0.9.0") == 0) then
  vim.api.nvim_echo({{"BinhVim requires Neovim >= 0.9.0\n", "ErrorMsg"}, {"Press any key to exit", "MoreMsg"}}, true, {})
  vim.fn.getchar()
  vim.cmd("quit")
  return {}
else
  local _let_1_ = require("binhvim.config")
  local init = _let_1_["init"]
  init()
  local function _2_(...)
    return (require("binhvim.config.plugins.treesitter")).init(...)
  end
  local function _3_(...)
    return (require("binhvim.config.plugins.treesitter")).opts(...)
  end
  local function _4_(...)
    return (require("binhvim.config.plugins.treesitter")).config(...)
  end
  local function _5_(...)
    return (require("binhvim.config.plugins.cmp")).opts(...)
  end
  local function _6_(...)
    return (require("binhvim.config.plugins.cmp")).config(...)
  end
  local function _7_()
    return {pre_hook = (require("ts_context_commentstring.integrations.comment_nvim")).create_pre_hook()}
  end
  local function _8_(...)
    return (require("binhvim.config.plugins.conform")).keys(...)
  end
  local function _9_(...)
    return (require("binhvim.config.plugins.conform")).opts(...)
  end
  local function _10_(...)
    return (require("binhvim.config.plugins.mason")).init(...)
  end
  local function _11_(...)
    return (require("binhvim.config.plugins.mason")).opts(...)
  end
  local function _12_(...)
    return (require("binhvim.config.plugins.whichkey")).opts(...)
  end
  local function _13_(_241, _242)
    return (require("nvim-tree")).setup(_242)
  end
  return {{"folke/lazy.nvim", version = "*"}, {"binhtran432k/BinhVim", priority = 10000, config = true, cond = true, version = "*", lazy = false}, {"Olical/nfnl", ft = "fennel", event = "VeryLazy"}, {"nvim-lua/plenary.nvim"}, {"nvim-treesitter/nvim-treesitter", event = "VeryLazy", cmd = {"TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo", "TSUninstall", "TSUpdate"}, keys = {{"<c-space>", desc = "Increment Selection"}, {"<bs>", desc = "Decrement Selection", mode = "x"}}, build = ":TSUpdate", init = _2_, opts = _3_, config = _4_}, {"hrsh7th/nvim-cmp", event = {"InsertEnter", "CmdlineEnter"}, dependencies = {"hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-nvim-lua", "saadparwaiz1/cmp_luasnip", "onsails/lspkind.nvim"}, opts = _5_, config = _6_}, {"windwp/nvim-ts-autotag", event = "VeryLazy", ft = {"html", "javascript", "jsx", "typescript", "tsx", "svelte", "vue", "xml", "markdown"}, opts = {}}, {"numToStr/Comment.nvim", dependencies = {{"JoosepAlviste/nvim-ts-context-commentstring", opts = {enable_autocmd = false}}}, keys = {{"gc", desc = "+comment line", mode = {"n", "x"}}, {"gb", desc = "+comment block", mode = {"n", "x"}}}, opts = _7_}, {"NvChad/nvim-colorizer.lua", event = "VeryLazy", opts = {user_default_options = {tailwind = true}}}, {"stevearc/conform.nvim", cmd = "ConformInfo", keys = _8_, opts = _9_}, {"williamboman/mason.nvim", cmd = {"Mason"}, init = _10_, opts = _11_}, {"folke/which-key.nvim", keys = {"<leader>", " ", "'", "`", "\"", "g", "v", "c", "d"}, cmd = "WhichKey", opts = _12_}, {"stevearc/oil.nvim", keys = {{"-", "<cmd>Oil<cr>", desc = "Open parent directory"}}, cmd = "Oil", opts = {}}, {"nvim-tree/nvim-tree.lua", keys = {{"<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer"}}, cmd = {"NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeCollapse"}, opts = {}, config = _13_}}
end
