--[[
Avoiding problems on redraw. Bug in upstream neovim
Example issues:
https://github.com/nvim-lualine/lualine.nvim/issues/825
https://github.com/nvim-lualine/lualine.nvim/issues/773
--]]

local function override_event()
  return {}
end

return {
  { "folke/snacks.nvim", opts = { dashboard = { enabled = false } } },
  {
    "LazyVim/LazyVim",
    init = function()
      -- override lazyvim.config.options, the I empties the startscreen:
      vim.opt.shortmess:append({ W = true, I = false, c = true })
    end,
  },
  { -- do not lazyload
    "folke/which-key.nvim",
    lazy = false,
    event = override_event,
  },
  { -- do not lazyload
    -- and don't use default section operators!
    "nvim-lualine/lualine.nvim",
    lazy = false,
    event = override_event,
    opts = function(_, opts)
      opts.options.section_separators = ""
    end,
  },
  { -- do not lazyload
    "akinsho/bufferline.nvim",
    lazy = false,
    event = override_event,
  },
  { -- do not lazyload
    "folke/noice.nvim",
    lazy = false,
    event = override_event,
  },
}
