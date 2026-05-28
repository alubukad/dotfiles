require'nvim-treesitter'.setup {
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,

    additional_vim_regex_highlighting = false,
  },
}

  -- A list of parser names, or "all" (the five listed parsers should always be installed)
require'nvim-treesitter'.install { "c", "angular", "asm", "awk", "bash", "c_sharp", "cmake", "cpp", "css", "desktop", "dockerfile", "elixir", "erlang", "fish", "gitcommit", "gitattributes", "gitignore", "helm", "html", "http", "jq", "kotlin", "latex", "make", "meson", "ocaml", "passwd", "php", "powershell", "python", "regex", "terraform", "tsx", "vala", "xml", "zig", "zsh", "vimdoc", "typescript", "python", "javascript", "java", "scala", "go", "rust", "lua", "vim", "vimdoc", "query" }
