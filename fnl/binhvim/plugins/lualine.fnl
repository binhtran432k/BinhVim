;; statusline
{1 :nvim-lualine/lualine.nvim
 :event :VeryLazy
 :init (fn []
         (set vim.g.lualine_laststatus vim.o.laststatus)
         (if (< 0 (vim.fn.argc -1))
             ;; set an empty statusline till lualine loads
             (set vim.o.statusline " ")
             ;; hide the statusline on the starter page
             (set vim.o.laststatus 0)))
 :opts (fn []
         ;; PERF: we don't need this lualine require madness 🤷
         (let [lualine_require (require :lualine_require)]
           (set lualine_require.require require))
         (set vim.o.laststatus vim.g.lualine_laststatus)
         (local debug-color (string.format "#%06x" (. (vim.api.nvim_get_hl_by_name :Debug true) :foreground)))
         (local special-color (string.format "#%06x" (. (vim.api.nvim_get_hl_by_name :Special true) :foreground)))
         {:options {:theme :auto
                    :globalstatus true
                    :component_separators {:left "|" :right "|"}
                    :section_separators {:left "" :right ""}
                    :disabled_filetypes {:statusline [:dashboard
                                                      :alpha
                                                      :starter]}}
          :sections {:lualine_a [:mode]
                     :lualine_b [:branch]
                     :lualine_c [:diagnostics
                                 {1 :filetype :icon_only true :separator ""}
                                 {1 :filename :padding {:left 0 :right 0}}]
                     :lualine_x [{1 #(.. "  " ((. (require :dap) :status)))
                                  :cond #(and (. package.loaded :dap)
                                              (not= ((. (require :dap) :status))
                                                    ""))
                                  :color {:fg debug-color}}
                                 {1 (. (require :lazy.status) :updates)
                                  :cond (. (require :lazy.status) :has_updates)
                                  :color {:fg special-color}}
                                 {1 :diff
                                  :source (fn []
                                            (let [gitsigns vim.b.gitsigns_status_dict]
                                              (when gitsigns
                                                {:added gitsigns.added
                                                 :modified gitsigns.changed
                                                 :removed gitsigns.removed})))}]
                     :lualine_y [:progress :location]
                     :lualine_z [#(.. " " (os.date "%R"))]}
          :extensions [:neo-tree :nvim-tree :lazy]})}

