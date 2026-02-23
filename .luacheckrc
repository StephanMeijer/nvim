std = "luajit"
globals = { "vim" }

ignore = {
  "212", -- unused argument (LazyVim opts function patterns)
  "213", -- unused loop variable
}

max_line_length = 120
max_cyclomatic_complexity = 30
