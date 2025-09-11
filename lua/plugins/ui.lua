-- lua/plugins/ui.lua
return {
  { "folke/snacks.nvim", opts = { dashboard = { enabled = false } } },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        variant = "auto",
        dark_variant = "main",
        dim_inative_windows = false,
        extend_background_behind_borders = true,

        enable = {
          terminal = true,
          legacy_highlights = true,
          migrations = true,
        },

        styles = {
          bold = true,
          italic = true,
          transparency = true,
        },
      })
      vim.cmd("colorscheme rose-pine")
    end,
  },
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    enabled = true,
    init = false,
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[
                                   ░██                                                     
                                   ░██                                                     
   ░██    ░██    ░██  ░███████  ░████████ ░██    ░██    ░██  ░██████   ░██░████  ░███████  
   ░██    ░██    ░██ ░██    ░██    ░██    ░██    ░██    ░██       ░██  ░███     ░██    ░██ 
    ░██  ░████  ░██  ░█████████    ░██     ░██  ░████  ░██   ░███████  ░██      ░█████████ 
     ░██░██ ░██░██   ░██           ░██      ░██░██ ░██░██   ░██   ░██  ░██      ░██        
      ░███   ░███     ░███████      ░████    ░███   ░███     ░█████░██ ░██       ░███████  
    ]]

      dashboard.section.header.val = vim.split(logo, "\n")
    -- stylua: ignore
    dashboard.section.buttons.val = {
      dashboard.button("f", " " .. " find file",       "<cmd> lua LazyVim.pick()() <cr>"),
      dashboard.button("n", " " .. " new file",        [[<cmd> ene <BAR> startinsert <cr>]]),
      dashboard.button("r", " " .. " recent files",    [[<cmd> lua LazyVim.pick("oldfiles")() <cr>]]),
      dashboard.button("g", " " .. " grep",       [[<cmd> lua LazyVim.pick("live_grep")() <cr>]]),
      dashboard.button("c", " " .. " config",          "<cmd> lua LazyVim.pick.config_files()() <cr>"),
      dashboard.button("s", " " .. " restore session", [[<cmd> lua require("persistence").load() <cr>]]),
      dashboard.button("q", " " .. " quit",            "<cmd> qa <cr>"),
    }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
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
          dashboard.section.footer.val = ms .. "ms (" .. stats.loaded .. "/" .. stats.count .. ")"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
}
