return {
    {
        "jinh0/eyeliner.nvim",
        -- highlight unique letter in each word on f/F press for easier jumping
        config = function()
            require("eyeliner").setup({
                highlight_on_key = true,
                dim = true,
                max_length = 9000,
                disabled_filetypes = {},
                disabled_buftypes = {},
                default_keymaps = true,
            })
        end,
    },
}
