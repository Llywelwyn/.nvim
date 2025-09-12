-- lua/plugins/ui.lua
return {
  { "folke/snacks.nvim", opts = { dashboard = { enabled = false } } },
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    config = function()
      require("kanagawa").setup({
        compile = false, -- after modifying, restart nvim and :KanagawaCompile
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { bold = true, italic = false },
        statementStyle = { bold = true },
        typeStyle = { bold = true },
        transparent = true, -- do not set background color
        dimInactive = true, -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = { -- add/modify theme and palette colors
          -- stylua: ignore
          palette = {
            fujiWhite    = "#8F8536",   -- default
            oldWhite     = "#C8C093",   -- statuslines
            sumiInk4     = "#54546D",   -- line numbers, fold column, non-text characters, float borders
            fujiGray     = "#8F3F41",   -- comments
            oniViolet    = "#FFFF00",   -- statements, keywords
            crystalBlue  = "#A60000",   -- functions and titles
            waveAqua2    = "#00CECE",   -- types
            springViolet1= "#FFFFFF",   -- light foreground
            springViolet2= "#FFFF00",   -- brackets and punctuation
            springGreen  = "#00BD00",   -- strings
            boatYellow2  = "#FFFF00",   -- operators
            sakuraPink   = "#FFFFFF",   -- numbers
            carpYellow   = "#8F8536",   -- identifiers
            surimiOrange = "#00CECE",   -- constants, imports, booleans
            springBlue   = "#A60000",   -- specials and builtin functions
            peachRed     = "#FFFF00",   -- specials 2: exception handling, return
          },
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
              },
            },
          },
        },
        overrides = function(colors) -- add/modify highlights
          local theme = colors.theme
          return {
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_mp3 },
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            -- lsp.type groups
            Operator = { fg = colors.palette.boatYellow2, bold = true },
            ["@variable"] = { fg = colors.palette.carpYellow },
            ["@variable.parameter"] = { fg = "#FFFFFF", bold = true },
            ["@lsp.type.struct"] = { fg = colors.palette.surimiOrange, bold = true },
            ["@lsp.type.class"] = { fg = colors.palette.surimiOrange, bold = true },
            ["@lsp.type.field"] = { fg = colors.palette.carpYellow, bold = true },
            ["@lsp.type.property"] = { fg = colors.palette.carpYellow, bold = true },
            ["@lsp.type.parameter"] = { fg = colors.palette.carpYellow, bold = true },
          }
        end,
        theme = "wave", -- Load "wave" theme
      })
      vim.cmd("colorscheme kanagawa")
    end,
  },
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    enabled = true,
    init = false,
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[neovim]]

      dashboard.section.header.val = vim.split(logo, "\n")
    -- stylua: ignore
    dashboard.section.buttons.val = {
      dashboard.button("n", "new",        [[<cmd> ene <BAR> startinsert <cr>]]),
      dashboard.button("r", "recent",    [[<cmd> lua LazyVim.pick("oldfiles")() <cr>]]),
      dashboard.button("s", "prev session", [[<cmd> lua require("persistence").load() <cr>]]),
    }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.width = 25
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,

    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          once = true,
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.header.val = "nvim in " .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
}
