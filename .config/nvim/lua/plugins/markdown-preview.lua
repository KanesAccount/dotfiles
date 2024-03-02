return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && yarn install",
    config = function()
        vim.g.mkdp_filetypes = { "markdown" }
        vim.keymap.set("n", "<leader>mp", ":MarkdownPreviewToggle <CR>", {})
    end,
}
