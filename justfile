# Neovim config development tasks

# List available recipes
default:
    @just --list

# Format all Lua files
fmt:
    stylua .

# Check formatting without modifying
fmt-check:
    stylua --check .

# Lint with selene (Rust-based, fast)
lint-selene:
    selene lua/

# Lint with luacheck (classic, thorough)
lint-luacheck:
    luacheck lua/ --no-color

# Run all linters
lint: lint-selene lint-luacheck

# Scan for secrets
secrets:
    gitleaks detect --source . --verbose --no-git

# Run all checks (format + lint + secrets)
check: fmt-check lint secrets
