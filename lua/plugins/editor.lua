return {
  -- Show hidden files in snacks explorer
  {
    "folke/snacks.nvim",
    opts = {
      explorer = {
        replace_netrw = true,
      },
      picker = {
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
          },
        },
      },
    },
  },

  -- Better diagnostics
  {
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = true },
  },

  -- Git blame inline
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 500,
      },
    },
  },

  -- Extra treesitter parsers for your stack
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "elixir",
        "heex",
        "eex",
        "rust",
        "typescript",
        "tsx",
        "javascript",
        "json",
        "yaml",
        "toml",
        "sql",
        "dockerfile",
        "terraform",
        "hcl",
        "lua",
        "markdown",
        "markdown_inline",
      })
    end,
  },

  -- Mason tools
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- Lua
        "stylua",
        -- Shell
        "shellcheck",
        "shfmt",
        -- TypeScript/JS
        "prettier",
        "eslint_d",
        -- Rust (rust-analyzer installed via rustup)
        -- Elixir
        "elixir-ls",
      },
    },
  },

  -- ASCII diagram drawing
  {
    "jbyuki/venn.nvim",
    cmd = { "VBox", "VBoxH", "VBoxD", "VBoxO", "VBoxHO", "VBoxDO", "VFill" },
    keys = {
      {
        "<leader>v",
        function()
          local venn_enabled = vim.inspect(vim.b.venn_enabled)
          if venn_enabled == "nil" then
            vim.b.venn_enabled = true
            vim.cmd([[setlocal ve=all]])
            -- Draw single lines with hjkl
            vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
            vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
            vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
            vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
            -- Draw boxes with visual selection
            vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
            vim.api.nvim_buf_set_keymap(0, "v", "b", ":VBoxH<CR>", { noremap = true, desc = "Bold box" })
            vim.api.nvim_buf_set_keymap(0, "v", "d", ":VBoxD<CR>", { noremap = true, desc = "Double box" })
            vim.notify("Venn mode enabled (f=single, b=bold, d=double)", vim.log.levels.INFO)
          else
            vim.cmd([[setlocal ve=]])
            vim.api.nvim_buf_del_keymap(0, "n", "J")
            vim.api.nvim_buf_del_keymap(0, "n", "K")
            vim.api.nvim_buf_del_keymap(0, "n", "L")
            vim.api.nvim_buf_del_keymap(0, "n", "H")
            vim.api.nvim_buf_del_keymap(0, "v", "f")
            vim.api.nvim_buf_del_keymap(0, "v", "b")
            vim.api.nvim_buf_del_keymap(0, "v", "d")
            vim.b.venn_enabled = nil
            vim.notify("Venn mode disabled", vim.log.levels.INFO)
          end
        end,
        desc = "Toggle Venn (ASCII diagrams)",
      },
    },
  },
}
