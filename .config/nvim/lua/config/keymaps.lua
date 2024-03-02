local harpoon_ui = require("harpoon.ui")
local harpoon_mark = require("harpoon.mark")
--local utils = require("user.utils")

-- first key is the mode
-- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command

local function map(mode, lhs, rhs, opts)
    local keys = require("lazy.core.handler").handlers.keys
    ---@cast keys LazyKeysHandler
    -- do not create the keymap if a lazy keys handler exists
    if not keys.active[keys.parse({ lhs, mode = mode }).id] then
        opts = opts or {}
        opts.silent = opts.silent ~= false
        if opts.remap and not vim.g.vscode then
            opts.remap = nil
        end
        vim.keymap.set(mode, lhs, rhs, opts)
    end
end

-- FML!
map("n", "<leader>gf", "<cmd>CellularAutomaton make_it_rain<CR>")

-- SalesForce keybinds
map(
    "n",
    "<leader>]lt",
    ":tabnew | set ft=log | /tmp/apexlogs.log<CR><C-w>s<C-w>j:term sf apex tail log --color <bar> tee /tmp/apexlogs.log<C-left><C-left><C-left>",
    { desc = "Enable tail logging" }
)

map(
    "n",
    "<leader>ll",
    ":enew | set ft=log | read !sf apex list log <CR> | :set filetype=log<CR> :7 <CR> | :lua require('keybinder.custom').set_hotkeys()<CR>",
    { desc = "List Active Debug Logs for authenticated org" }
)

--0/07L<CR>:nohlsearch<CR>yiw :enew | set ft=log | read !sf apex log get -i <C-r>\"<CR> :2<CR>
-- require"keybinder".push("debug_mode", "n", {["<return>"] = " "})
map(
    "n",
    "<leader>ln",
    "push('debug_mode', 'n', {[' st'] = ':nmap <leader>ln<CR>'})",
    { desc = "Get Debug Log for selected line" }
)

map(
    "n",
    "<leader>lg",
    '0/07L<CR>:nohlsearch<CR>yiw :enew | set ft=log | read !sf apex log get -i <C-r>"<CR> :2<CR>',
    { desc = "Get Debug Log for selected line" }
)

map(
    "n",
    "<leader>[d",
    "<C-w>s<C-w>j10<C-w>-:term sfdx force:source:deploy -p '%' -l NoTestRun -w 5<CR>",
    { desc = "Deploy source to Org (SFDX)" }
)

map(
    "n",
    "<leader>dd",
    "<C-w>s<C-w>j10<C-w>-:term sfdx force:source:deploy -p '%' -l NoTestRun -w 5<CR>",
    { desc = "Deploy source to Org (SFDX)" }
)

map(
    "n",
    "<leader>[w",
    ":term sf lightning generate component --name  --type lwc --output-dir ~/repos/booknow/BookNow-Software-Dev-Org/force-app/main/default/lwc <S-Left><S-Left><S-Left><S-Left><LEFT>",
    { desc = "Create LWC" }
)

map(
    "n",
    "<leader>[d",
    "<C-w>s<C-w>j10<C-w>-:term sf project deploy start -d '%' <CR>",
    { desc = "Deploy path source to Org (SF)" }
)

map(
    "n",
    "<leader>[c",
    "<C-w>s<C-w>j10<C-w>-:term sf project deploy start --source-dir ./force-app/main/default/classes/ --source-dir ./force-app/main/default/objects/ --json --ignore-conflicts <CR>",
    { desc = "Deploy Objects & Classes to Org (SF)" }
)

map(
    "n",
    "<leader>[i",
    "<C-w>s<C-w>j10<C-w>-:term sf project deploy start --ignore-conflicts <CR>",
    { desc = "Deploy full source to Org --ignore-conflicts (SF)" }
)

map(
    "n",
    "<leader>[p",
    "<C-w>s<C-w>j10<C-w>-:term sf community publish --name 'BookNow'<CR>",
    { desc = "Publish BN Community" }
)

map("n", "<leader>dc", ":bd<CR>", { desc = "Delete buffer" })
map("n", "<leader>sl", ":set filetype=log<CR>", { desc = "Set log filetype" })
map("n", "<leader>[e", ":tabnew ~/.local/state/nvim/swap/<CR>", { desc = "open swap files" })

map(
    "n",
    "<leader>ta",
    "<C-w>s<C-w>j10<C-w>-:term sfdx apex:run:test -c -r human -w 5 -n '%:t:r'<CR>",
    { desc = "Run Apex test on current file" }
)

map(
    "n",
    "<leader>td",
    "<C-w>s<C-w>j10<C-w>-:term sfdx apex:run:test -c -v -r human -w 5 -d /tmp/coverage -n '%:t:r'<CR>",
    { desc = "Run Apex test with detailed coverage on current file" }
)

map("n", "<leader>oc", ":tabnew /tmp/coverage<CR>", { desc = "Open coverage in new tab" })

-- Run just the specific test you are in
map(
    "n",
    "<leader>tt",
    "?@isTest<CR>0f(hyiw<C-w>s<C-w>j10<C-w>-:term sfdx apex:run:test -y -c -r human -w 5 -t '%:t:r'.<C-r>\"<CR>:nohlsearch<CR>",
    { desc = "Run Apex test on current test" }
)

map(
    "n",
    "<leader>aa",
    ":tabnew /tmp/execute.apex<CR>:silent %delete<CR>p<C-w>:w<CR>",
    { desc = "Extract selected apex into new temp file" }
)

-- Run apex code in execute anon for the current open file and print the results in a new tab
map(
    "n",
    "<leader>ra",
    "<C-w>v:enew | set ft=log | read !sf apex run -f '#' <CR> ",
    { desc = "Run Execute Anon on selected code" }
)

-- sf.nvim mappings
map("n", "<leader><leader>o", require("sf.org").set_target_org, { desc = "[O]rg Settings for current workspace" })
map("n", "<leader><leader>S", require("sf.org").set_global_target_org, { desc = "[S]et global target_org" })
map("n", "<leader><leader>f", ':lua require("sf.org").fetch_org_list(true)<CR>', { desc = "[F]etch orgs info" })

map("n", "<leader>mr", require("sf.org").retrieve_metadata_lists, { desc = "[M]etadata retrieve" })
map("n", "<leader>ml", require("sf.org").select_md_to_retrieve, { desc = "[M]etadata [L]ist" })
map("n", "<leader>mt", require("sf.org").retrieve_apex_under_cursor, { desc = "[m]etadata [T]his retrieve" })

map("n", "<leader><leader>t", require("sf.term").toggle, { desc = "[T]erminal toggle" })
map("n", "<leader><leader>r", require("sf.term").go_to_sf_root, { desc = "CD into [R]oot" })
map("n", "<leader>C-c>", require("sf.term").cancel, { desc = "[C]ancel current running command" })
map("n", "<leader><leader>r", require("sf.term").retrieve, { desc = "[R]etrieve current file" })
map("n", "<leader><leader>d", require("sf.term").save_and_push, { desc = "[D]eploy current file" })

map("n", "<leader>ta", require("sf.term").run_all_tests_in_this_file, { desc = "[T]est [A]ll" })
map("n", "<leader>tt", require("sf.term").run_current_test, { desc = "[T]est [T]his under cursor" })

map("n", "<leader>to", require("sf.test").open, { desc = "[T]est [O]pen Buf Select" })
map("n", "<leader>tr", require("sf.term").repeat_last_tests, { desc = "[T]est [R]epeat" })

map("n", "<leader>sd", require("sf.org").diff_in_target_org, { desc = "[d]iff in target_org" })
map("n", "<leader>sD", require("sf.org").select_org_to_diff_in, { desc = "[D]iff in org..." })

map("n", "<leader><leader>c", require("sf.org").search_custom_objects, { desc = "[s]earch custom object metadata" })

--:nnoremap ]ee :tabnew \| read !sfdx apex:run -f "#"<CR>
--:nnoremap ]ej :tabnew \| read !sfdx apex:run -f "#" --json<CR>

--System.debug("cool")
--["<leader>[e"] = {
--  ":tabnew ~/.local/state/nvim/swap/<CR>",
--  desc = "open swap files",
--},
-- Non SF Mappings
-- ["<leader>[n"] = {
--   "<C-e> :tabnew ~/.config/nvim/lua/user/init.lua<CR>",
--  desc = "open nvim config",
--},
--["<leader>[f"] = {
--  "<C-e> :tabnew ~/.config/fish/config.fish",
--  desc = "open fish config",
--},
--["<leader>[fw"] = {
--  "yiw :execute normal /pattern/e+1<CR>",
--  desc = "grep current word under cursor",
--},
--["<leader>fg"] = {
--  ":Telescope git_files<CR>",
--  desc = "find git files",
--},
-- ["<leader>[tg"] = {
--   'vim.api.nvim_buf_set_option(0, "commentstring", "+ %s")',
--   desc = "toggle git add comment string",
-- },
-- "vim grep current word
-- :nnoremap ]ss yiw:vim /\c<C-r>"/g

--},
-- My custom remaps
-- Move highlighted lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")
-- Keep cursor in position when copying line below and appeding with a space
vim.keymap.set("n", "J", "mzJ`z")
-- Keep cursor in the middle of the screen when jumping up/down half pages
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- Keep cursor in the middle of the screen when jumping with search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- Paste yanked word without overwriting copied buffer
vim.keymap.set("x", "<leader>p", '"_dP')
-- Yank to the system buffer
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+y')
-- Delete to the system buffer
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')
-- Remove capital Q from quitting
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("", "<leader>pp", ":w | :! sf community publish --name 'BookNow'<CR>")
--
-- Source the current file
vim.keymap.set("", "<leader><leader>s", ": source %<CR>")
-- Print current buf number
vim.keymap.set("", "<leader>pb", ": echo nvim_get_current_buf()<CR>")
vim.keymap.set("", "<leader>ar", ": AutoRun<CR>")

-- Persistance keybinds
--
-- -- restore the session for the current directory
-- vim.api.nvim_set_keymap("n", "<leader>ss", [[<cmd>lua require("persistence").load()<cr>]], {})
-- -- restore the last session
-- vim.api.nvim_set_keymap("n", "<leader>sl", [[<cmd>lua require("persistence").load({ last = true })<cr>]], {})
-- -- stop Persistence => session won't be saved on exit
-- vim.api.nvim_set_keymap("n", "<leader>sd", [[<cmd>lua require("persistence").stop()<cr>]], {})
-- -- move to next buffer
-- vim.api.nvim_set_keymap("n", "<leader>k", "[n", {})
-- -- move to previous buffer
-- vim.api.nvim_set_keymap("n", "<leader>j", "[b", {})

-- Remap Defaults
-- New w default
map("n", "<leader>w", ":w<CR>", { desc = "Write buffer", remap = true })

--vim.keymap.set("n", "<leader>tg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")

--local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
--vim.keymap.set("n", "<leader>sw", live_grep_args_shortcuts.grep_word_under_cursor)
--
-- New Fresh and Funky vibes
--
-- Map Oil to <leader>e
vim.keymap.set("n", "<leader>e", function()
    require("oil").toggle_float()
end)

-- Press 'S' for quick find/replace for the word under the cursor
vim.keymap.set("n", "S", function()
    local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
    local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
    vim.api.nvim_feedkeys(keys, "n", false)
end)

-- Open Spectre for global find/replace
vim.keymap.set("n", "<leader>S", function()
    require("spectre").toggle()
end)

-- Open Spectre for global find/replace for the word under the cursor in visual mode
vim.keymap.set("v", "<leader>sw", function()
    require("spectre").open_visual({ select_word = true })
end, { desc = "Search current word" })

-- Press 'H', 'L' to jump to start/end of a line (first/last char)
-- vim.keymap.set("n", "L", "$")
-- vim.keymap.set("n", "H", "^")

-- Open the qflist
vim.keymap.set("n", "<leader>co", ":copen<cr>zz")

-- Close the qflist
vim.keymap.set("n", "<leader>cc", ":cclose<cr>zz")

-- Map MaximizerToggle (szw/vim-maximizer) to leader-m
vim.keymap.set("n", "<leader>M", ":MaximizerToggle<cr>")

-- Resize split windows to be equal size
vim.keymap.set("n", "<leader>=", "<C-w>=")

-- Press leader rw to rotate open windows
vim.keymap.set("n", "<leader>rw", ":RotateWindows<cr>", { desc = "[R]otate [W]indows" })

-- Press gx to open the link under the cursor
vim.keymap.set("n", "gx", ":sil !open <cWORD><cr>", { silent = true })

-- Harpoon keybinds --
-- Open harpoon ui
vim.keymap.set("n", "<leader>ho", function()
    harpoon_ui.toggle_quick_menu()
end)

-- Add current file to harpoon
vim.keymap.set("n", "<leader>ha", function()
    harpoon_mark.add_file()
end)

-- Remove current file from harpoon
vim.keymap.set("n", "<leader>hr", function()
    harpoon_mark.rm_file()
end)

-- Remove all files from harpoon
vim.keymap.set("n", "<leader>hc", function()
    harpoon_mark.clear_all()
end)

-- Quickly jump to harpooned files
vim.keymap.set("n", "<leader>1", function()
    harpoon_ui.nav_file(1)
end)

vim.keymap.set("n", "<leader>2", function()
    harpoon_ui.nav_file(2)
end)

vim.keymap.set("n", "<leader>3", function()
    harpoon_ui.nav_file(3)
end)

vim.keymap.set("n", "<leader>4", function()
    harpoon_ui.nav_file(4)
end)

vim.keymap.set("n", "<leader>5", function()
    harpoon_ui.nav_file(5)
end)

-- Telescope keybinds --
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader>sb", require("telescope.builtin").buffers, { desc = "[S]earch Open [B]uffers" })
vim.keymap.set("n", "<leader>sf", function()
    require("telescope.builtin").find_files({ hidden = true })
end, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").git_files, { desc = "[S]earch [D]iagnostics" })

vim.keymap.set("n", "<leader>tc", function()
    require("telescope.builtin").commands(require("telescope.themes").get_dropdown({
        previewer = false,
    }))
end, { desc = "[T]elescope [C]ommands" })

vim.keymap.set("n", "<leader>/", function()
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        previewer = false,
    }))
end, { desc = "[/] Fuzzily search in current buffer]" })

vim.keymap.set("n", "<leader>ss", function()
    require("telescope.builtin").spell_suggest(require("telescope.themes").get_dropdown({
        previewer = false,
    }))
end, { desc = "[S]earch [S]pelling suggestions" })

-- Insert --
-- Map jj to <esc>
-- no bueno
--inoremap("jj", "<esc>")
vim.keymap.set("n", "<leader><leader>x", ":w | :source %<CR>")

-- Visual --
-- Press 'H', 'L' to jump to start/end of a line (first/last char)
-- vim.keymap.set("v", "L", "$<left>")
-- vim.keymap.set("v", "H", "^")

-- Paste without losing the contents of the register
vim.keymap.set("x", "<leader>p", '"_dP')

-- Move selected text up/down in visual mode
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- Terminal --
-- Enter normal mode while in a terminal
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
--vim.keymap.set("t", "jj", [[<C-\><C-n>]])

-- Window navigation from terminal
vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]])
vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]])
vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]])
vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]])

-- joely boiii
-- Show lsp implementations
map(
    "n",
    "<leader>ti",
    [[<Cmd>lua require'telescope.builtin'.lsp_implementations()<CR>]],
    { noremap = true, silent = true }
)

-- show LSP definitions
map(
    "n",
    "<leader>td",
    [[<Cmd>lua require'telescope.builtin'.lsp_definitions({layout_config = { preview_width = 0.50, width = 0.92 }, path_display = { "shorten" }, results_title='Definitions'})<CR>]],
    { noremap = true, silent = true }
)

-- git telescope goodness
-- git_branches
map(
    "n",
    "<space>gb",
    [[<Cmd>lua require'telescope.builtin'.git_branches({prompt_title = ' ', results_title='Git Branches'})<CR>]],
    {
        noremap = true,
        silent = true,
    }
)
-- git_bcommits - file scoped commits with diff preview. <C-V> for vsp diff to parent
map(
    "n",
    "<space>gc",
    [[<Cmd>lua require'telescope.builtin'.git_bcommits({prompt_title = '  ', results_title='Git File Commits'})<CR>]],
    { noremap = true, silent = true }
)
-- git_commits (log) git log
map("n", "gl", [[<Cmd>lua require'telescope.builtin'.git_commits()<CR>]], { noremap = true, silent = true })
-- git_status - <tab> to toggle staging
map("n", "gs", [[<Cmd>lua require'telescope.builtin'.git_status()<CR>]], { noremap = true, silent = true })

-- registers picker
map("n", "<space>r", [[<Cmd>lua require'telescope.builtin'.registers()<CR>]], { noremap = true, silent = true })

-- find files including gitignored
map(
    "n",
    ",f",
    [[<Cmd>lua require'telescope.builtin'.find_files({find_command={'fd','--no-ignore-vcs'}})<CR>]],
    { noremap = true, silent = true }
)

-- Browse files from cwd - File Browser
map(
    "n",
    "<leader>fb",
    [[<Cmd>lua require'telescope'.extensions.file_browser.file_browser()<CR>]],
    { noremap = true, silent = true }
)

-- Resume previous picker
map("n", "<leader>rp", [[<Cmd>lua require'telescope.builtin'.resume()<CR>]], { noremap = true, silent = true })
