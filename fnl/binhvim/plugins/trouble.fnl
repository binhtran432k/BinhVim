;; better diagnostics list and others
{1 :folke/trouble.nvim
 :cmd [:TroubleToggle :Trouble]
 :opts {:use_diagnostic_signs true}
 :keys [{1 :<leader>xx
         2 "<cmd>TroubleToggle document_diagnostics<cr>"
         :desc "Document Diagnostics (Trouble)"}
        {1 :<leader>xX
         2 "<cmd>TroubleToggle workspace_diagnostics<cr>"
         :desc "Workspace Diagnostics (Trouble)"}
        {1 :<leader>xL
         2 "<cmd>TroubleToggle loclist<cr>"
         :desc "Location List (Trouble)"}
        {1 :<leader>xQ
         2 "<cmd>TroubleToggle quickfix<cr>"
         :desc "Quickfix List (Trouble)"}
        {1 "[q"
         2 (fn []
             (let [{: is_open : previous} (require :trouble)]
               (if (is_open)
                   (previous {:skip_groups true :jump true})
                   (let [(ok err) (pcall vim.cmd.cprev)]
                     (when (not ok)
                       (vim.notify err vim.log.levels.ERROR))))))
         :desc "Previous Trouble/Quickfix Item"}
        {1 "]q"
         2 (fn []
             (let [{: is_open : next} (require :trouble)]
               (if (is_open)
                   (next {:skip_groups true :jump true})
                   (let [(ok err) (pcall vim.cmd.cnext)]
                     (when (not ok)
                       (vim.notify err vim.log.levels.ERROR))))))
         :desc "Next Trouble/Quickfix Item"}]}

