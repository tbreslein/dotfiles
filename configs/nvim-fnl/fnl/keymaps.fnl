(import-macros {: plugin-setup} :util-macros)
(set vim.g.mapleader " ")

(let [default-opts {:noremap true :silent true}
      expr_opts {:noremap true :expr true :silent true}
      keymaps [{1 :<c-h>
                2 :<c-w>h
                :mode [:n]
                :description "move focus left"
                :opts default-opts}
               {1 :<c-j>
                2 :<c-w>j
                :mode [:n]
                :description "move focus down"
                :opts default-opts}
               {1 :<c-k>
                2 :<c-w>k
                :mode [:n]
                :description "move focus up"
                :opts default-opts}
               {1 :<c-l>
                2 :<c-w>l
                :mode [:n]
                :description "move focus right"
                :opts default-opts}
               {1 :<c-t>
                2 "<cmd>ToggleTerm size=20<cr>"
                :mode [:n]
                :description "toggle terminal"
                :opts default-opts}
               {1 :s
                2 :<cmd>HopWord<cr>
                :mode [:n]
                :description "hop word forward"
                :opts default-opts}
               {1 :S
                2 :<cmd>HopWordBC<cr>
                :mode [:n]
                :description "hop word backward"
                :opts default-opts}
               {1 "<"
                2 :<gv
                :mode [:v]
                :description "unindent selection"
                :opts default-opts}
               {1 ">"
                2 :>gv
                :mode [:v]
                :description "indent selection"
                :opts default-opts}
               {1 :Y
                2 :y$
                :mode [:n]
                :description "yank to end of line"
                :opts default-opts}
               {1 :P
                2 :_dP
                :mode [:v]
                :description "paste over selected text"
                :opts default-opts}
               {1 :n
                2 :nzz
                :mode [:n]
                :description "next result (center)"
                :opts default-opts}
               {1 :N
                2 :Nzz
                :mode [:n]
                :description "prev result (center)"
                :opts default-opts}
               {1 :<esc>
                2 ":nohlsearch<bar>:echo<cr>"
                :mode [:n]
                :description "cancel search highlight"
                :opts default-opts}
               {1 :J
                2 ":m '>+1<cr>gv-gc"
                :mode [:v]
                :description "move lines downward"
                :opts default-opts}
               {1 :K
                2 ":m '<-2<cr>gv-gc"
                :mode [:v]
                :description "move lines upward"
                :opts default-opts}
               {1 :j
                2 "v:count == 0 ? 'gj' : 'j'"
                :mode [:n]
                :description "move down accross visual lines"
                :opts expr_opts}
               {1 :k
                2 "v:count == 0 ? 'gk' : 'k'"
                :mode [:n]
                :description "move up accross visual lines"
                :opts expr_opts}
               {1 :jk
                2 "<c-\\><c-n>"
                :mode [:t]
                :description "leave insert mode (terminal)"
                :opts default-opts}
               {1 :<a-j>
                2 :<cmd>BufferPrevious<cr>
                :mode [:n]
                :description "prev buffer"
                :opts default-opts}
               {1 :<a-k>
                2 :<cmd>BufferNext<cr>
                :mode [:n]
                :description "next buffer"
                :opts default-opts}
               {1 :<a-<>
                2 :<cmd>BufferMovePrevious<cr>
                :mode [:n]
                :description "move buffer prev"
                :opts default-opts}
               {1 :<a->>
                2 :<cmd>BufferMoveNext<cr>
                :mode [:n]
                :description "move buffer next"
                :opts default-opts}
               {1 :<a-x>
                2 :<cmd>BufferClose<cr>
                :mode [:n]
                :description "close buffer"
                :opts default-opts}]
      autocmds [{1 :FileType
                 2 "set commentstring=//%s"
                 :opts {:pattern [:*.c :*.cpp]}
                 :description "set commentstring for C and C++"}
                {1 :TextYankPost
                 2 "lua vim.highlight.on_yank {on_visual = false}"
                 :description "highlight yanked text"}
                {1 :CursorHold
                 2 "lua vim.diagnostic.open_float(nil, { focusable = false })"
                 :description "open diagnostics on holding the cursor"}
                {1 [:BufNewFile :BufRead]
                 2 "set filetype=fsharp"
                 :opts {:pattern [:*.fs "*.fs{x,i}"]}
                 :description "set filetype to fsharp for *.{fs,fsx,fsi} files"}
                {1 [:BufNewFile :BufRead]
                 2 "set filetype=markdown"
                 :opts {:pattern [:*.mdx]}
                 :description "set filetype to markdown for *.mdx"}
                {1 [:BufNewFile :BufRead]
                 2 "set filetype=astro"
                 :opts {:pattern [:*.astro]}
                 :description "set filetype to astro for *.astro"}]]
  (plugin-setup :legendary {: keymaps : autocmds}))

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
        ;; :g [:<cmd>Neogit<cr> :Neogit]
        :g [:<cmd>LazyGit<cr> :LazyGit]
        :f {:name :Telescope
            :b ["<cmd>Telescope current_burrer_fuzzy_find<cr>" "buffer fzf"]
            :f ["<cmd>Telescope find_files hidden=true<cr>" "file finder"]
            :g ["<cmd>Telescope live_grep<cr>" "live grep"]
            :h ["<cmd>Telescope notify<cr>" "notify history"]
            :p ["<cmd>Telescope projects<cr>" :projects]
            :t [":lua require('telescope').extensions.git_worktree.git_worktrees()<cr>"
                "git worktrees"]}
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
                "open refactoring in telescope"]
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
        :z {:name :Packer
            :c [:<cmd>PackerCompile<cr> :compile]
            :i [:<cmd>PackerInstall<cr> :install]
            :u [:<cmd>PackerUpdate<cr> :update]
            :s [:<cmd>PackerSync<cr> :sync]
            :S [:<cmd>PackerStatus<cr> :status]
            :t [:<cmd>TSUpdateSync<cr> "treesitter update sync"]}}
       {:mode :n
        :prefix :<leader>
        :buffer nil
        :silent true
        :noremap true
        :nowait false}))
