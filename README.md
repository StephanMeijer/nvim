# nvim

Personal Neovim configuration built on [LazyVim](https://www.lazyvim.org/).

## Language support

- **Elixir** — Lexical LSP, Credo linting, mix formatting, HEEx/Surface templates, ExUnit via neotest
- **Rust** — rustaceanvim, clippy on save, full inlay hints, crates.nvim, codelldb debugging
- **TypeScript** — smart Deno/Node detection, vtsls + denols, eslint + prettier
- **TypeSpec** — tsp-server LSP, formatting

## Additional tooling

- Catppuccin Mocha colorscheme
- Treesitter with parsers for 18+ languages
- conform.nvim for formatting, nvim-lint for linting
- dadbod for database access
- venn.nvim for ASCII diagrams
- Docker, Helm, Terraform, JSON, YAML, TOML, SQL, Markdown support via LazyVim extras

## Setup

```sh
git clone git@github.com:StephanMeijer/nvim.git ~/.config/nvim
nvim
```

Plugins install automatically on first launch via lazy.nvim.
