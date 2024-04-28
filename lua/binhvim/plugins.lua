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
  local function _2_()
    vim.g.startuptime_tries = 10
    return nil
  end
  local function _3_(...)
    return (require("binhvim.config.plugins.treesitter")).textobjects_config(...)
  end
  local function _4_(...)
    return (require("binhvim.config.plugins.treesitter")).init(...)
  end
  local function _5_(...)
    return (require("binhvim.config.plugins.treesitter")).opts(...)
  end
  local function _6_(...)
    return (require("binhvim.config.plugins.treesitter")).config(...)
  end
  local function _7_(...)
    return (require("binhvim.config.plugins.snippets")).keys(...)
  end
  local function _8_(...)
    return (require("binhvim.config.plugins.snippets")).opts(...)
  end
  local function _9_(...)
    return (require("binhvim.config.plugins.cmp")).opts(...)
  end
  local function _10_(...)
    return (require("binhvim.config.plugins.cmp")).config(...)
  end
  local function _11_()
    return {pre_hook = (require("ts_context_commentstring.integrations.comment_nvim")).create_pre_hook()}
  end
  local function _12_(_241, _242)
    return (require("nvim-tree")).setup(_242)
  end
  local function _13_()
    if (vim.fn.argc(-1) == 1) then
      local stat_2_auto = vim.uv.fs_stat(vim.fn.argv(0))
      if (stat_2_auto and (stat_2_auto.type == "directory")) then
        return vim.cmd("Oil")
      else
        return nil
      end
    else
      return nil
    end
  end
  local function _16_(...)
    return (require("binhvim.config.plugins.whichkey")).opts(...)
  end
  local function _17_(...)
    return (require("binhvim.config.plugins.whichkey")).config(...)
  end
  local function _18_(...)
    return (require("binhvim.config.plugins.conform")).keys(...)
  end
  local function _19_(...)
    return (require("binhvim.config.plugins.conform")).opts(...)
  end
  local function _20_(...)
    return (require("binhvim.config.plugins.mason")).init(...)
  end
  local function _21_(...)
    return (require("binhvim.config.plugins.mason")).opts(...)
  end
  return {{"folke/lazy.nvim", version = "*"}, {"binhtran432k/BinhVim", priority = 10000, config = true, cond = true, version = "*", lazy = false}, {"Olical/nfnl", ft = "fennel", event = "VeryLazy"}, {"dstein64/vim-startuptime", cmd = "StartupTime", config = _2_}, {"nvim-lua/plenary.nvim", lazy = true}, {"nvim-treesitter/nvim-treesitter", dependencies = {{"nvim-treesitter/nvim-treesitter-textobjects", config = _3_}, {"HiPhish/rainbow-delimiters.nvim"}}, event = {"LazyFile", "VeryLazy"}, cmd = {"TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo", "TSUninstall", "TSUpdate"}, keys = {{"<c-space>", desc = "Increment Selection"}, {"<bs>", desc = "Decrement Selection", mode = "x"}}, build = ":TSUpdate", init = _4_, opts = _5_, config = _6_, version = false}, {"windwp/nvim-ts-autotag", event = "LazyFile", ft = {"html", "javascript", "jsx", "typescript", "tsx", "svelte", "vue", "xml", "markdown"}, opts = {}}, {"hrsh7th/nvim-cmp", event = {"InsertEnter", "CmdlineEnter"}, dependencies = {"hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-nvim-lua", "onsails/lspkind.nvim", {"garymjr/nvim-snippets", dependencies = "rafamadriz/friendly-snippets", keys = _7_, opts = _8_}}, opts = _9_, config = _10_, version = false}, {"numToStr/Comment.nvim", dependencies = {{"JoosepAlviste/nvim-ts-context-commentstring", opts = {enable_autocmd = false}}}, keys = {{"gc", desc = "+comment line", mode = {"n", "x"}}, {"gb", desc = "+comment block", mode = {"n", "x"}}}, opts = _11_}, {"nvim-tree/nvim-tree.lua", version = "*", keys = {{"<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer"}, {"<leader>fe", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Explorer Focus File"}}, cmd = {"NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeCollapse"}, opts = {}, config = _12_}, {"stevearc/oil.nvim", keys = {{"-", "<cmd>Oil<cr>", desc = "Open parent directory"}}, cmd = "Oil", init = _13_, opts = {}}, {"folke/which-key.nvim", event = "VeryLazy", cmd = "WhichKey", opts = _16_, config = _17_}, {"NvChad/nvim-colorizer.lua", event = "VeryLazy", opts = {user_default_options = {tailwind = true}}}, {"stevearc/conform.nvim", cmd = "ConformInfo", keys = _18_, opts = _19_}, {"williamboman/mason.nvim", cmd = {"Mason"}, keys = {{"<leader>cm", "<cmd>Mason<cr>", desc = "Mason"}}, init = _20_, opts = _21_}}
end
