# Optimized Neovim Configuration 

A blazing fast, memory-efficient, and feature-rich Neovim setup designed specifically for devs who wants speed and efficiency over animations.

## ✨ Why This Configuration Rocks

### 🔥 Performance First
- **Memory Optimized**: Intelligent buffer management automatically closes unused buffers when exceeding 10 open files
- **Lightning Fast Startup**: Lazy-loaded plugins and disabled unnecessary built-in features
- **Smooth Scrolling**: Optimized mouse scrolling and cursor movement
- **No Disk Bloat**: Disabled swap files, backups, and unnecessary file handlers

### 🎯 Developer Experience
- **Instant File Access**: File explorer and fuzzy finder load immediately for zero-delay navigation
- **Smart Indentation**: VS Code-like 2-space indentation with automatic detection
- **Transparent UI**: Clean, distraction-free interface with Tokyo Night theme
- **Inline Diagnostics**: Real-time error display without cluttering your workspace

### 🛠️ MERN Stack Ready
- **TypeScript/JavaScript**: Full LSP support with auto-completion and formatting
- **React/JSX**: Smart auto-pairing and auto-closing tags
- **Tailwind CSS**: Integrated CSS framework support
- **Modern Tooling**: Prettier formatting, ESLint integration, and Git workflow

## 🎮 Beautiful Shortcuts & Keybindings

### 🗂️ File Management
| Shortcut | Action | Description |
|----------|--------|-------------|
| `<Space>e` | Toggle Explorer | Open/close file tree |
| `<Space><Space>` | Find Files | Fuzzy find files in project |
| `<Space>gg` | Live Grep | Search text across all files |
| `<Space>bb` | Buffer List | Quick buffer switching |

### 📝 Editing Power
| Shortcut | Action | Description |
|----------|--------|-------------|
| `<Tab>` | Smart Indent | Context-aware indentation |
| `<Shift-Tab>` | Unindent | Reverse indentation |
| `H` / `L` | Buffer Navigation | Previous/next buffer |
| `<Ctrl-w>` | Close Buffer | Smart buffer closing |
| `d` | Delete (No Yank) | Delete without copying to clipboard |

### 🔍 Code Navigation
| Shortcut | Action | Description |
|----------|--------|-------------|
| `grn` | Rename Symbol | LSP-powered renaming |
| `gra` | Code Actions | Quick fixes and refactoring |
| `grd` | Go to Definition | Jump to symbol definition |
| `grr` | Find References | Show all symbol references |
| `[d` / `]d` | Navigate Diagnostics | Jump between errors/warnings |

### 🪟 Window Management
| Shortcut | Action | Description |
|----------|--------|-------------|
| `<Ctrl-h/j/k/l>` | Window Navigation | Move between splits |
| `<Ctrl-d/u>` | Smart Scrolling | Page up/down with centering |
| `<Esc><Esc>` | Terminal Exit | Exit terminal mode |

### 🎨 Git Integration
| Shortcut | Action | Description |
|----------|--------|-------------|
| `<Space>gb` | Git Blame | Show line blame information |
| `<Space>gd` | Preview Diff | Show git diff for current hunk |

## 🔧 Plugin Stack

### Core Functionality
- **[Lazy.nvim](https://github.com/folke/lazy.nvim)**: Lightning-fast plugin manager
- **[Telescope](https://github.com/nvim-telescope/telescope.nvim)**: Fuzzy finder for everything
- **[NvimTree](https://github.com/nvim-tree/nvim-tree.lua)**: File explorer with git integration

### Language Support
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)**: LSP configuration
- **[blink.cmp](https://github.com/saghen/blink.cmp)**: Auto-completion with Enter key
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)**: Syntax highlighting
- **[conform.nvim](https://github.com/stevearc/conform.nvim)**: Code formatting

### Developer Tools
- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)**: Git integration
- **[nvim-autopairs](https://github.com/windwp/nvim-autopairs)**: Auto-pairing brackets
- **[nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)**: Auto-close HTML/JSX tags

### UI Enhancement
- **[tokyonight.nvim](https://github.com/folke/tokyonight.nvim)**: Beautiful theme
- **[bufferline.nvim](https://github.com/akinsho/bufferline.nvim)**: Clean buffer tabs
- **[mini.nvim](https://github.com/echasnovski/mini.nvim)**: Lightweight utilities

## 🚀 Quick Start

1. **Backup your existing config**:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Create new config directory**:
   ```bash
   mkdir -p ~/.config/nvim
   ```

3. **Copy the configuration**:
   ```bash
   # Copy the init.lua file to ~/.config/nvim/init.lua
   ```

4. **Install dependencies**:
   ```bash
   # Make sure you have these installed:
   # - ripgrep (for telescope grep)
   # - fd (for telescope file finding)
   # - nodejs & npm (for LSP servers)
   ```

5. **Launch Neovim**:
   ```bash
   nvim
   ```

   The configuration will automatically install all plugins on first launch!

## 💡 Pro Tips

### Custom Commands
- `:WF` - Format and write buffer in one command ,  cause by default i dont use formatting !
- Use `<Space>sw` to search for the word under cursor
- `<Space>sd` shows all diagnostics in telescope

### Memory Management
- Buffers automatically close when you have more than 10 open
- Swap files are disabled for better performance
- Large files (>100KB) skip treesitter highlighting

### Git Workflow
- File explorer shows git status with icons
- Gitsigns provides inline diff markers
- Quick blame and diff preview without leaving your code

## 🎯 Perfect For
- If you are irritated by the amount of ram consumption on multiple tabs and glitchey


---

*This configuration strikes the perfect balance between power and performance, giving you a professional development environment without the bloat. Happy coding! �
