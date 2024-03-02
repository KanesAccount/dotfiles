return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-context",
  },
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "json",
        "javascript",
        "bash",
        "lua",
        "vim",
        "comment",
        "markdown",
        "apex",
        "soql",
        "sosl",
      },
      ignore_install = {},
      highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = false,
      },
    })
  end,
}

--vim.treesitter.language.register("apex", "java")
