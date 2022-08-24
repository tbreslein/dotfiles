(let [reg (. (require :which-key) :register)]
  (reg {:w {:name :save
            :w [:<cmd>update!<cr> "force update"]
            :q [:<cmd>wq<cr> "save and quit"]
            :a [:<cmd>wqa<cr> "save and quit all"]}
        :q {:name :quit
            :q [:<cmd>q<cr> :quit]
            :f [:<cmd>q!<cr> "force quit"]
            :a [:<cmd>qa!<cr> "force quit all"]}
        :J ["<cmd>resize -2<cr>" "resize down"]
        :K ["<cmd>resize +2<cr>" "resize up"]
        :H ["<cmd>vertical resize -2<cr>" "resize left"]
        :L ["<cmd>vertical resize +2<cr>" "resize right"]
        :g [:<cmd>Neogit<cr> :Neogit]
        :f {:name :Telescope
            :b ["<cmd>Telescope current_burrer_fuzzy_find<cr>" "buffer fzf"]
            :f ["<cmd>Telescope find_files hidden=true<cr>" "file finder"]
            :g ["<cmd>Telescope live_grep<cr>" "live grep"]
            :h ["<cmd>Telescope notify<cr>" "notify history"]
            :p ["<cmd>Telescope projects<cr>" :projects]
            :t [":lua require('telescope').extensions.git_worktree.git_worktrees()<cr>"
                "git worktrees"]}
        :l {:name :Lsp
            "[" ["<cmd>lua vim.lsp.buf.definition()<cr>" :definition]
            "]" ["<cmd>lua vim.lsp.buf.declaration()<cr>" :declaration]
            "{" ["<cmd>lua vim.lsp.buf.hover()<cr>" "buffer hover"]
            "}" ["<cmd>lua vim.lsp.buf.implementation()<cr>" :implementation]
            :rr ["<cmd>lua vim.lsp.buf.references()<cr>" :references]
            :rn ["<cmd>lua vim.lsp.buf.rename()<cr>" :rename]
            :ca ["<cmd>lua vim.lsp.buf.code_action()<cr>" "code action"]
            :sh ["<cmd>lua vim.lsp.diagnostics.show_line_diagnostics()<cr>"
                 "show line diagnostics"]
            :n ["<cmd>lua vim.diagnostic.goto_next()<cr>"
                "go to next warning/error"]
            :N ["<cmd>lua vim.diagnostic.goto_prev()<cr>"
                "go to prev warning/error"]
            :t {:name :Trouble
                :t [:<cmd>TroubleToggle<cr> "toggle trouble"]
                :w ["<cmd>TroubleToggle workspace_diagnostics<cr>"
                    "toggle trouble workspace_diagnostics"]
                :d ["<cmd>TroubleToggle document_diagnostics<cr>"
                    "toggle trouble document_diagnostics"]
                :l ["<cmd>TroubleToggle loclist<cr>" "toggle trouble loclist"]
                :q ["<cmd>TroubleToggle quickfix<cr>"
                    "toggle trouble quickfix"]
                :r ["<cmd>TroubleToggle lsp_references<cr>"
                    "toggle trouble lsp_references"]}}
        :n {:name "neogen ++ neotest"
            :d ["<cmd>lua require('neogen').generate()<cr>"
                "generate docstring"]
            :t {:name :neotest
                :a ["<cmd>lua require('neotest').run.attach()<cr>" :Attach]
                :f ["<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>"
                    "Run File"]
                :F ["<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>"
                    "Debug File"]
                :l ["<cmd>lua require('neotest').run.run_last()<cr>"
                    "Run Last"]
                :L ["<cmd>lua require('neotest').run.run_last({ strategy = 'dap' })<cr>"
                    "Debug Last"]
                :n ["<cmd>lua require('neotest').run.run()<cr>" "Run Nearest"]
                :N ["<cmd>lua require('neotest').run.run({ strategy = 'dap' })<cr>"
                    "Debug Nearest"]
                :o ["<cmd>lua require('neotest').output.open({enter = true})<cr>"
                    :Output]
                :q ["<cmd>lua require('neotest').run.stop()<cr>" :Stop]
                :s ["<cmd>lua require('neotest').summary.toggle()<cr>"
                    :Summary]}}
        :p {:name "File explorer"
            :v ["<cmd>Neotree filesystem reveal float<cr>"
                "file browser as float"]
            :p ["<cmd>Neotree filesystem reveal left<cr>"
                "file browser on the left"]}
        :r {:name "refac ++ spectre"
            :r ["<esc><cmd>lua require('telescope').extensions.refactoring.refactors()<cr>"
                "open refactorin in telescope"]
            :e ["<esc><cmd>lua require('refactoring').refactor('Extract Function')<cr>"
                "extract function"]
            :f ["<esc><cmd>lua require('refactoring').refactor('Extract Function to file')<cr>"
                "extract function to file"]
            :v ["<esc><cmd>lua require('refactoring').refactor('Extract Variables')<cr>"
                "extract variable"]
            :i ["<esc><cmd>lua require('refactoring').refactor('Inline Variables')<cr>"
                "inline variable"]
            :b ["<esc><cmd>lua require('refactoring').refactor('Extract Block')<cr>"
                "extract block"]
            :n ["<esc><cmd>lua require('refactoring').refactor('Extract Block to File')<cr>"
                "extract block to file"]
            :p ["<esc><cmd>lua require('refactoring').debug.printf({below = false})<cr>"
                "add print statement"]
            :d ["<esc><cmd>lua require('refactoring').debug.print_var()<cr>"
                "add print statement for selected var"]
            :c ["<esc><cmd>lua require('refactoring').debug.cleanup({})<cr>"
                "clean up debug statements"]}
        :s {:name :Spectre
            :s [":lua require('spectre').open()<cr>" "open spectre"]
            :v [":lua require('spectre').open_visual()<cr>"
                "open spectre on visual selection"]
            :f [":lua require('spectre').open_file_search()<cr>"
                "open spectre file search"]}
        :t {:name :Tabs
            :a [:<cmd>tabedit<cr> "new tab"]
            :c [:<cmd>tabclose<cr> "close tab"]
            :o [:<cmd>tabonly<cr> "only tab"]
            :n [:<cmd>tabn<cr> "next tab"]
            :p [:<cmd>tabp<cr> "prev tab"]
            :m {:name :move
                :n [:<cmd>-tabmove<cr> "move tab down"]
                :p [:<cmd>+tabmove<cr> "move tab up"]}}
        :z {:name :Paq
            :c [:<cmd>PaqClean<cr> :Clean]
            :i [:<cmd>PaqInstall<cr> :Install]
            :u [:<cmd>PaqUpdate<cr> :Update]
            :s [:<cmd>PaqSync<cr> :Sync]}}
       {:mode :n
        :prefix :<leader>
        :buffer nil
        :silent true
        :noremap true
        :nowait false}))
