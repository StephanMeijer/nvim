-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local opt = vim.opt

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

-- Line numbers
opt.relativenumber = true

-- Search
opt.ignorecase = true
opt.smartcase = true

-- UI
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.cursorline = true

-- No swap files
opt.swapfile = false
opt.backup = false

-- Faster updates
opt.updatetime = 250
opt.timeoutlen = 300

-- Split behavior
opt.splitright = true
opt.splitbelow = true

-- Clipboard
opt.clipboard = "unnamedplus"
