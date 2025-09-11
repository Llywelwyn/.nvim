-- lua/plugins/guess_indent.lua
return {
  {
    "NMAC427/guess-indent.nvim",
    event = { "BufReadPost", "BufNewFile" }, -- load when a file is opened/new file
    opts = {
      auto_cmd = true, -- run automatically when buffer is opened
      override_editorconfig = false, -- don't override .editorconfig by default
      filetype_exclude = { "netrw", "tutor" },
      buftype_exclude = { "help", "nofile", "terminal", "prompt" },
      on_tab_options = {
        ["expandtab"] = false,
      },
      on_space_options = {
        ["expandtab"] = true,
        ["tabstop"] = "detected",
        ["softtabstop"] = "detected",
        ["shiftwidth"] = "detected",
      },
    },
    config = function(_, opts)
      require("guess-indent").setup(opts)
    end,
  },
}
