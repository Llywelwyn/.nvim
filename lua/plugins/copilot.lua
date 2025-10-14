--[[
  Plugin configuration for CodeCompanion and related tools.
  All plugins in this file are used to enhance or support CodeCompanion functionality.
]]
return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "toggle chat" },
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "actions" },
      { mode = { "v" }, "<leader>ap", "<cmd>CodeCompanionChat Add<cr>", desc = "put in chat" },
    },
    opts = {
      -- https://codecompanion.olimorris.dev/extending/prompts
      display = {
        action_palette = {
          width = 95,
          height = 10,
          prompt = "Prompt ", -- Prompt used for interactive LLM calls
          provider = "default", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
          opts = {
            show_default_actions = true, -- Show the default actions in the action palette?
            show_default_prompt_library = true, -- Show the default prompt library in the action palette?
            title = "CodeCompanion actions", -- The title of the action palette
          },
        },
      },
    },
  },
  {
    -- Allows markdown to be rendered in the chat window.
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
  },
  {
    -- Enhances diffing.
    "nvim-mini/mini.diff",
    config = function()
      local diff = require("mini.diff")
      diff.setup({
        source = diff.gen_source.none(),
      })
    end,
  },
  {
    -- Allows :PasteImage into the chat window.
    "HakonHarnes/img-clip.nvim",
    opts = {
      filetypes = {
        codecompanion = {
          prompt_for_file_name = false,
          template = "[Image]($FILE_PATH)",
          use_absolute_path = true,
        },
      },
    },
  },
}
