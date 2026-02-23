return {
  -- Expert LSP (official Elixir language server)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lexical = {
          cmd = { vim.fn.expand("~/.local/bin/expert") },
          root_dir = function(fname)
            local util = require("lspconfig.util")
            return util.root_pattern("mix.exs", ".git")(fname) or vim.loop.cwd()
          end,
          filetypes = { "elixir", "eelixir", "heex" },
          settings = {},
        },
      },
    },
  },

  -- Mix formatter integration
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        elixir = { "mix" },
        heex = { "mix" },
        eex = { "mix" },
      },
      formatters = {
        mix = {
          command = "mix",
          args = { "format", "-" },
          stdin = true,
        },
      },
    },
  },

  -- Treesitter for Elixir/HEEx
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "elixir",
        "heex",
        "eex",
        "erlang",
      })
    end,
  },

  -- Better Elixir syntax (if treesitter falls short)
  { "elixir-editors/vim-elixir", ft = { "elixir", "heex", "eex" } },

  -- ExUnit test runner integration
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "jfpedroza/neotest-elixir",
    },
    opts = {
      adapters = {
        ["neotest-elixir"] = {
          mix_task = { "test" },
          args = { "--trace" },
        },
      },
    },
  },

  -- Filetype detection
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      vim.filetype.add({
        extension = {
          heex = "heex",
          leex = "heex",
          sface = "surface",
        },
      })
    end,
  },

  -- Credo linting
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        elixir = { "credo" },
      },
      linters = {
        credo = {
          cmd = "mix",
          args = { "credo", "suggest", "--format", "json", "--read-from-stdin" },
          stdin = true,
          ignore_exitcode = true,
          parser = function(output)
            local diagnostics = {}
            local ok, result = pcall(vim.json.decode, output)
            if not ok or not result or not result.issues then
              return diagnostics
            end
            for _, issue in ipairs(result.issues) do
              table.insert(diagnostics, {
                lnum = (issue.line_no or 1) - 1,
                col = (issue.column or 1) - 1,
                severity = issue.priority == "high" and vim.diagnostic.severity.ERROR
                  or issue.priority == "normal" and vim.diagnostic.severity.WARN
                  or vim.diagnostic.severity.HINT,
                message = issue.message,
                source = "credo",
              })
            end
            return diagnostics
          end,
        },
      },
    },
  },
}
