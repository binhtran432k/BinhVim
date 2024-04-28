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
  local function _11_(...)
    return (require("binhvim.config.plugins.autopairs")).opts(...)
  end
  local function _12_(...)
    return (require("binhvim.config.plugins.autopairs")).config(...)
  end
  local function _13_(...)
    return (require("binhvim.config.plugins.surround")).keys(...)
  end
  local function _14_(...)
    return (require("binhvim.config.plugins.surround")).opts(...)
  end
  local function _15_()
    return {pre_hook = (require("ts_context_commentstring.integrations.comment_nvim")).create_pre_hook()}
  end
  local function _16_(...)
    return (require("binhvim.config.plugins.ai")).opts(...)
  end
  local function _17_(...)
    return (require("binhvim.config.plugins.ai")).config(...)
  end
  local function _18_(...)
    return (require("binhvim.config.plugins.ai")).wk_opts(...)
  end
  local function _19_(_241, _242)
    return (require("nvim-tree")).setup(_242)
  end
  local function _20_()
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
  local function _23_()
    return (require("spectre")).open()
  end
  local _24_
  if (vim.fn.executable("make") == 1) then
    _24_ = "make"
  else
    _24_ = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
  end
  local function _26_(...)
    return (require("binhvim.config.plugins.telescope")).keys(...)
  end
  local function _27_(...)
    return (require("binhvim.config.plugins.telescope")).opts(...)
  end
  local function _28_(...)
    return (require("binhvim.config.plugins.telescope")).config(...)
  end
  local function _29_(...)
    return (require("binhvim.config.plugins.flash")).keys(...)
  end
  local function _30_(...)
    return (require("binhvim.config.plugins.whichkey")).opts(...)
  end
  local function _31_(...)
    return (require("binhvim.config.plugins.whichkey")).config(...)
  end
  local function _32_(...)
    return (require("binhvim.config.plugins.gitsigns")).opts(...)
  end
  local function _33_(...)
    return (require("binhvim.config.plugins.conform")).keys(...)
  end
  local function _34_(...)
    return (require("binhvim.config.plugins.conform")).opts(...)
  end
  local function _35_(...)
    return (require("binhvim.config.plugins.mason")).init(...)
  end
  local function _36_(...)
    return (require("binhvim.config.plugins.mason")).opts(...)
  end
  return {{"folke/lazy.nvim", version = "*"}, {"binhtran432k/BinhVim", priority = 10000, config = true, cond = true, version = "*", lazy = false}, {"Olical/nfnl", ft = "fennel", event = "LazyFile"}, {"dstein64/vim-startuptime", cmd = "StartupTime", config = _2_}, {"nvim-lua/plenary.nvim", lazy = true}, {"nvim-treesitter/nvim-treesitter", dependencies = {{"nvim-treesitter/nvim-treesitter-textobjects", config = _3_}, {"HiPhish/rainbow-delimiters.nvim"}}, event = {"LazyFile", "VeryLazy"}, cmd = {"TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo", "TSUninstall", "TSUpdate"}, keys = {{"<c-space>", desc = "Increment Selection"}, {"<bs>", desc = "Decrement Selection", mode = "x"}}, build = ":TSUpdate", init = _4_, opts = _5_, config = _6_, version = false}, {"windwp/nvim-ts-autotag", event = "LazyFile", ft = {"html", "javascript", "jsx", "typescript", "tsx", "svelte", "vue", "xml", "markdown"}, opts = {}}, {"hrsh7th/nvim-cmp", event = {"InsertEnter", "CmdlineEnter"}, dependencies = {"hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-nvim-lua", "onsails/lspkind.nvim", {"garymjr/nvim-snippets", dependencies = "rafamadriz/friendly-snippets", keys = _7_, opts = _8_}}, opts = _9_, config = _10_, version = false}, {"windwp/nvim-autopairs", event = "InsertEnter", dependencies = {"nvim-treesitter/nvim-treesitter", opts = {autopairs = {enable = true}}}, opts = _11_, config = _12_}, {"echasnovski/mini.surround", keys = _13_, opts = _14_}, {"JoosepAlviste/nvim-ts-context-commentstring", lazy = true, opts = {enable_autocmd = false}}, {"numToStr/Comment.nvim", keys = {{"gc", desc = "+comment line", mode = {"n", "x"}}, {"gb", desc = "+comment block", mode = {"n", "x"}}}, opts = _15_}, {"echasnovski/mini.ai", event = "VeryLazy", opts = _16_, config = _17_}, {"folke/which-key.nvim", opts = _18_}, {"nvim-tree/nvim-tree.lua", version = "*", keys = {{"<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer"}, {"<leader>fe", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Explorer Focus File"}}, cmd = {"NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeCollapse"}, opts = {}, config = _19_}, {"stevearc/oil.nvim", keys = {{"-", "<cmd>Oil<cr>", desc = "Open parent directory"}}, cmd = "Oil", init = _20_, opts = {}}, {"nvim-pack/nvim-spectre", cmd = "Spectre", opts = {open_cmd = "noswapfile vnew"}, keys = {{"<leader>sr", _23_, desc = "Replace in Files (Spectre)"}}, build = false}, {"nvim-telescope/telescope.nvim", cmd = "Telescope", dependencies = {"nvim-telescope/telescope-symbols.nvim", {"nvim-telescope/telescope-fzf-native.nvim", build = _24_, enabled = ((vim.fn.executable("make") == 1) or (vim.fn.executable("cmake") == 1))}}, keys = _26_, opts = _27_, config = _28_, version = false}, {"folke/flash.nvim", event = "VeryLazy", vscode = true, opts = {}, keys = _29_}, {"folke/which-key.nvim", event = "VeryLazy", cmd = "WhichKey", opts = _30_, config = _31_}, {"lewis6991/gitsigns.nvim", event = "LazyFile", opts = _32_}, {"binhtran432k/dracula.nvim", lazy = true}, {"NvChad/nvim-colorizer.lua", event = "VeryLazy", opts = {user_default_options = {tailwind = true}}}, {"stevearc/conform.nvim", cmd = "ConformInfo", keys = _33_, opts = _34_}, {"williamboman/mason.nvim", cmd = {"Mason"}, keys = {{"<leader>cm", "<cmd>Mason<cr>", desc = "Mason"}}, init = _35_, opts = _36_}}
end
