-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--

vim.cmd([[
      augroup FileTypeGroup
	    au!
	    au BufRead,BufNewFile *.cls,*.trigger,*.apex set filetype=apex | set syntax=apex
	    "au BufRead,BufNewFile *.cls,*.trigger,*.apex set filetype=apex | set syntax=java | UltiSnipsAddFiletypes cls.java
	    au BufRead,BufNewFile *.soql set filetype=apex | set syntax=sql
	    "au BufRead,BufNewFile *-meta.xml UltiSnipsAddFiletypes meta.xml
	    au BufRead,BufNewFile project-scratch-def.json set filetype=scratch | set syntax=json
	    au BufRead,BufNewFile *.cmp,*.page,*.component set filetype=html
	    au BufRead,BufNewFile *.tsx,*.jsw set filetype=javascript
	    au BufRead,BufNewFile *.jsx set filetype=javascript.jsx
	    au FileType qf :nnoremap <buffer> <CR> <CR>
      augroup END
    ]])

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.apex = {
  install_info = {
    url = "~/repos/utils/tree-sitter-sfapex/apex",
    files = { "src/parser.c" },
    branch = "main",
    generate_requires_npm = false,
    requires_generate_from_grammar = false,
  },
}

parser_config.soql = {
  install_info = {
    url = "~/repos/utils/tree-sitter-sfapex/soql",
    files = { "src/parser.c" },
    branch = "main",
    generate_requires_npm = false,
    requires_generate_from_grammar = true,
  },
}

parser_config.sosl = {
  install_info = {
    url = "~/repos/utils/tree-sitter-sfapex/sosl",
    files = { "src/parser.c" },
    branch = "main",
    generate_requires_npm = false,
    requires_generate_from_grammar = true,
  },
}

-- AutoRun for split buffer messaging
local attach_to_buffer = function(output_bufnr, pattern, command)
  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    group = vim.api.nvim_create_augroup("command_group", { clear = true }),
    pattern = pattern,
    callback = function()
      vim.cmd.new()
      vim.cmd.wincmd("L")
      local output_buf = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_set_lines(output_buf, 0, -1, false, { "output of test.js:" })
      vim.fn.jobstart(command, {
        stdout_buffered = true,
        on_stdout = function(_, data)
          vim.api.nvim_buf_set_lines(output_buf, -1, -1, false, data)
        end,
        on_stderr = function(_, data)
          vim.api.nvim_buf_set_lines(output_buf, -1, -1, false, data)
        end,
      })
    end,
  })
end

vim.api.nvim_create_user_command("AutoRun", function()
  local file_name = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
  print("Autorun starting on " .. file_name .. "...")
  attach_to_buffer(0, "*.js", "bun " .. file_name)
end, {})

--
