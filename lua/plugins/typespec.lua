return {
  -- Treesitter: syntax highlighting and indentation for .tsp files
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "typespec" })
    end,
  },

  -- LSP: tsp-server (global install via npm install -g @typespec/compiler)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsp_server = {},
      },
    },
  },

  -- Formatting: tsp format (uses local node_modules tsp binary)
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        typespec = { "typespec" },
      },
    },
  },

  -- Mason: install tsp-server globally as fallback
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "tsp-server",
      },
    },
  },
}
