-- [nfnl] Compiled from fnl/binhvim/extras/lang/go.fnl by https://github.com/Olical/nfnl, do not edit.
return {{"nvim-treesitter/nvim-treesitter", opts = {binh_ensure_installed = {go = true, gomod = true, gowork = true, gosum = true}}}, {"neovim/nvim-lspconfig", opts = {servers = {gopls = {settings = {gopls = {gofumpt = true, codelenses = {generate = true, regenerate_cgo = true, run_govulncheck = true, test = true, tidy = true, upgrade_dependency = true, vendor = true, gc_details = false}, hints = {assignVariableTypes = true, compositeLiteralFields = true, compositeLiteralTypes = true, constantValues = true, functionTypeParameters = true, parameterNames = true, rangeVariableTypes = true}, analyses = {fieldalignment = true, nilness = true, unusedparams = true, unusedwrite = true, useany = true}, usePlaceholders = true, completeUnimported = true, staticcheck = true, directoryFilters = {"-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules"}, semanticTokens = true}}}}}}}
