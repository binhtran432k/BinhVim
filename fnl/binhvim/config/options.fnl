(macro set-globals [globals]
  (icollect [key value (pairs globals)]
    `(tset vim.g ,key ,value)))

(macro set-opts [opts]
  (icollect [key value (pairs opts)]
    `(tset vim.opt ,key ,value)))

(macro disable_builtins [builtins]
  (icollect [_ builtin (ipairs builtins)]
    `(tset vim.g ,(.. :loaded_ builtin) 1)))

(macro disable_providers [providers]
  (icollect [_ provider (ipairs providers)]
    `(tset vim.g ,(.. :loaded_ provider :_provider) 0)))

(fn setup []
  (set-globals {
			   	:mapleader " "
				:maplocalleader " "
				:speeddating_no_mappings 1
				:themeCache (.. (vim.fn.stdpath :data) :/colors_data/)
				:transparency false
			   })

  (set-opts {
	:number true
	:relativenumber false
	:ruler false
	:shiftwidth 4
	:tabstop 4
	:softtabstop 4
	:smartindent true
	:smartcase true
	:ignorecase true
	:clipboard "unnamedplus"
	:undofile true
	:swapfile false
	:mouse "a"
	:cursorline true
	:showmode false
	:laststatus 3
	:showtabline 2
	:splitbelow true
	:splitright true
	:termguicolors true
	:timeoutlen 300
	:updatetime 200
	:background "dark"
	:fillchars { :foldopen "" :foldclose "" :fold " " :foldsep " " :diff "╱" :eob " " }
	})

  (vim.opt.shortmess:append :sI)
  (vim.opt.formatoptions:remove :c :r :o)
  (vim.opt.whichwrap:append "<>[]hl")

  (disable_builtins [
		     :2html_plugin
		     :getscript
		     :getscriptPlugin
		     :gzip
		     :logipat
		     :netrw
		     :netrwPlugin
		     :netrwSettings
		     :netrwFileHandlers
		     :tar
		     :tarPlugin
		     :rrhelper
		     :spellfile_plugin
		     :vimball
		     :vimballPlugin
		     :zip
		     :zipPlugin
		     :logipat
		     :matchit
		     :tutor
		     :rplugin
		     :syntax
		     :synmenu
		     :optwin
		     :compiler
		     :bugreport
		     :ftplugin
		     :archlinux
		     :fzf
		     :tutor_mode_plugin
		     :sleuth
		     :vimgrep
		     ])

  (disable_providers [:node :perl :python3 :ruby]))

{: setup}
