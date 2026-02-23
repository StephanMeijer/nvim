return {
  -- TypeScript/Deno setup
  -- Auto-detects: deno.json = Deno, package.json = Node

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Deno LSP
        denols = {
          root_dir = function(fname)
            local util = require("lspconfig.util")
            -- Only activate for Deno projects
            return util.root_pattern("deno.json", "deno.jsonc")(fname)
          end,
          settings = {
            deno = {
              enable = true,
              lint = true,
              unstable = true,
              suggest = {
                imports = {
                  hosts = {
                    ["https://deno.land"] = true,
                    ["https://jsr.io"] = true,
                  },
                },
              },
              inlayHints = {
                parameterNames = { enabled = "all" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
            },
          },
        },

        -- TypeScript (vtsls - faster than tsserver)
        vtsls = {
          root_dir = function(fname)
            local util = require("lspconfig.util")
            -- Only activate for Node projects (not Deno)
            local deno_root = util.root_pattern("deno.json", "deno.jsonc")(fname)
            if deno_root then
              return nil -- Let denols handle it
            end
            return util.root_pattern("package.json", "tsconfig.json", "jsconfig.json")(fname)
          end,
          settings = {
            typescript = {
              inlayHints = {
                parameterNames = { enabled = "all" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
              suggest = {
                completeFunctionCalls = true,
              },
              preferences = {
                importModuleSpecifier = "relative",
              },
            },
            javascript = {
              inlayHints = {
                parameterNames = { enabled = "all" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
            },
          },
        },
      },
    },
  },

  -- Disable tsserver (using vtsls instead)
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        tsserver = function()
          return true -- Skip, using vtsls
        end,
        ts_ls = function()
          return true -- Skip, using vtsls
        end,
      },
    },
  },

  -- Formatting: Prettier for Node, deno fmt for Deno
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        typescript = { "deno_fmt", "prettier", stop_after_first = true },
        typescriptreact = { "deno_fmt", "prettier", stop_after_first = true },
        javascript = { "deno_fmt", "prettier", stop_after_first = true },
        javascriptreact = { "deno_fmt", "prettier", stop_after_first = true },
        json = { "deno_fmt", "prettier", stop_after_first = true },
        jsonc = { "deno_fmt", "prettier", stop_after_first = true },
        markdown = { "deno_fmt", "prettier", stop_after_first = true },
      },
      formatters = {
        deno_fmt = {
          condition = function(ctx)
            -- Only use deno_fmt in Deno projects
            return vim.fs.find({ "deno.json", "deno.jsonc" }, { path = ctx.filename, upward = true })[1] ~= nil
          end,
        },
        prettier = {
          condition = function(ctx)
            -- Only use prettier in Node projects
            return vim.fs.find({ "deno.json", "deno.jsonc" }, { path = ctx.filename, upward = true })[1] == nil
          end,
        },
      },
    },
  },

  -- Linting: ESLint for Node only
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
      },
      linters = {
        eslint_d = {
          condition = function(ctx)
            -- Only lint with eslint in Node projects
            return vim.fs.find({ "deno.json", "deno.jsonc" }, { path = ctx.filename, upward = true })[1] == nil
          end,
        },
      },
    },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "typescript",
        "tsx",
        "javascript",
        "jsdoc",
      })
    end,
  },

  -- Package.json support
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    event = "BufRead package.json",
    opts = {},
  },

  -- Mason
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "prettier",
        "eslint_d",
        "vtsls",
        "deno",
      },
    },
  },
}
