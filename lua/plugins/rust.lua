return {
  -- Rust tools (rustaceanvim - successor to rust-tools.nvim)
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = { "rust" },
    opts = {
      server = {
        on_attach = function(_, bufnr)
          -- Rust-specific keymaps
          vim.keymap.set("n", "<leader>cR", function()
            vim.cmd.RustLsp("codeAction")
          end, { desc = "Rust Code Action", buffer = bufnr })

          vim.keymap.set("n", "<leader>dr", function()
            vim.cmd.RustLsp("debuggables")
          end, { desc = "Rust Debuggables", buffer = bufnr })

          vim.keymap.set("n", "K", function()
            vim.cmd.RustLsp({ "hover", "actions" })
          end, { desc = "Rust Hover Actions", buffer = bufnr })

          vim.keymap.set("n", "<leader>ce", function()
            vim.cmd.RustLsp("explainError")
          end, { desc = "Rust Explain Error", buffer = bufnr })

          vim.keymap.set("n", "<leader>cm", function()
            vim.cmd.RustLsp("expandMacro")
          end, { desc = "Rust Expand Macro", buffer = bufnr })

          vim.keymap.set("n", "<leader>cc", function()
            vim.cmd.RustLsp("openCargo")
          end, { desc = "Open Cargo.toml", buffer = bufnr })

          vim.keymap.set("n", "<leader>cp", function()
            vim.cmd.RustLsp("parentModule")
          end, { desc = "Rust Parent Module", buffer = bufnr })

          vim.keymap.set("n", "<leader>cj", function()
            vim.cmd.RustLsp("joinLines")
          end, { desc = "Rust Join Lines", buffer = bufnr })
        end,

        default_settings = {
          ["rust-analyzer"] = {
            -- Cargo
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
            },

            -- Clippy for linting (instead of cargo check)
            checkOnSave = true,
            check = {
              command = "clippy",
              extraArgs = {
                "--",
                "-W",
                "clippy::pedantic",
                "-W",
                "clippy::nursery",
                "-A",
                "clippy::module_name_repetitions",
                "-A",
                "clippy::must_use_candidate",
              },
            },

            -- Proc macros
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["tokio"] = { "test" },
              },
            },

            -- Inlay hints
            inlayHints = {
              bindingModeHints = { enable = true },
              chainingHints = { enable = true },
              closingBraceHints = { enable = true, minLines = 25 },
              closureReturnTypeHints = { enable = "always" },
              lifetimeElisionHints = { enable = "always", useParameterNames = true },
              parameterHints = { enable = true },
              typeHints = { enable = true },
            },

            -- Completion
            completion = {
              fullFunctionSignatures = { enable = true },
              postfix = { enable = true },
            },

            -- Diagnostics
            diagnostics = {
              enable = true,
              experimental = { enable = true },
            },

            -- Imports
            imports = {
              granularity = { group = "module" },
              prefix = "self",
            },

            -- Lens (run/debug buttons)
            lens = {
              enable = true,
              references = {
                adt = { enable = true },
                enumVariant = { enable = true },
                method = { enable = true },
                trait = { enable = true },
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
    end,
  },

  -- Don't use lspconfig for rust (rustaceanvim handles it)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = {},
      },
      setup = {
        rust_analyzer = function()
          return true -- Skip lspconfig setup, rustaceanvim handles it
        end,
      },
    },
  },

  -- Crates.nvim for Cargo.toml
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        cmp = { enabled = true },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },

  -- Formatting with rustfmt
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        rust = { "rustfmt" },
      },
      formatters = {
        rustfmt = {
          args = { "--edition", "2021" },
        },
      },
    },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "rust",
        "toml",
      })
    end,
  },

  -- Testing
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "rouge8/neotest-rust",
    },
    opts = {
      adapters = {
        ["neotest-rust"] = {},
      },
    },
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      -- Install codelldb via Mason
      {
        "mason-org/mason.nvim",
        opts = {
          ensure_installed = { "codelldb" },
        },
      },
    },
  },
}
