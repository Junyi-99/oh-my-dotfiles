return {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = {"VeryLazy"},
    opts = {
        -- 代码高亮
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false
        },
        -- 启用基于 Treesitter 的代码格式化(=)
        indent = {
            enable = true
        },
        ensure_installed = {"bash", "c", "diff", "html", "javascript", "jsdoc", "json", "jsonc", "lua", "luadoc",
                            "luap", "markdown", "markdown_inline", "python", "query", "regex", "toml", "tsx",
                            "typescript", "vim", "vimdoc", "xml", "yaml", "vimdoc"},
        -- 启用增量选择
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<CR>",
                node_incremental = "<CR>",
                scope_incremental = "<TAB>",
                node_decremental = "<BS>"
            }
        }
    }
}
