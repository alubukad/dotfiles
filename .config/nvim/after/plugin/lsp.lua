local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config('vala_ls', {
    cmd = {"vala-language-server"},
    settings = {
        Vala = {
            packageDirectories = { "/usr/share/vala/vapi" },
        }
    },
    filetypes = { "vala" },
})

vim.lsp.config('clangd', {
    cmd = {"clangd"},
    capabilities = {
        offsetEncoding = { "utf-8", "utf-16" },
        textDocument = {
            completion = {
                editsNearCursor = true
            }
        }
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    root_markers = { ".clangd", ".clang-tidy", ".clang-format", "compile_commands.json", "compile_flags.txt", "configure.ac", ".git" }
})

vim.lsp.config('tsc', {
    cmd = { "tsc", "--lsp", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
})

vim.lsp.config('rust_analyzer', {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = { 'Cargo.toml', 'rust-project.json' },
    settings = {
        ['rust-analyzer'] = {},
    },
    capabilities = capabilities,
})

vim.lsp.config('bashls', {
    cmd = { "bash-language-server", "start" },
    filetypes = { "bash", "sh" },
    root_markers = { ".git" },
    settings = {
        bashIde = {
            globPattern = "*@(.sh|.inc|.bash|.command)"
        }
    }
})

vim.lsp.config('jsonls', {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    init_options = {
        provideFormatter = true
    },
    root_markers = { ".git" },
    capabilities = capabilities,
})

vim.lsp.config('cmake', {
    cmd = { "cmake-language-server" },
    filetypes = {"cmake"},
    init_options = {
        buildDirectory = "build"
    },
    root_markers = { "CMakePresets.json", "CTestConfig.cmake", ".git", "build", "cmake" }
})

vim.lsp.config('pylsp', {
    cmd = { "pylsp" },
    filetypes = {"python", "py"},
    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    ignore = {'W391'},
                    maxLineLength = 100
                }
            }
        }
    }
})

vim.lsp.config('fish_lsp', {
    cmd = { "fish-lsp", "start" },
    filetypes = { "fish" },
    root_markers = { "config.fish", ".git" }
})

vim.lsp.config('lua_ls', {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" }
})

vim.lsp.config('zls', {
    cmd = { "zls" },
    filetypes = { "zig", "zir" },
    root_markers = { "zls.json", "build.zig", ".git" },
    workspace_required = false
})

vim.lsp.config('jdtls', {
    cmd = { "jdtls" },
    filetypes = { "java" },
    root_markers = { { "mvnw", "gradlew", "build.gradle", "build.gradle.kts", ".git" }, { "build.xml", "pom.xml", "settings.gradle", "settings.gradle.kts" } },
    init_options = {
        bundles = {
            vim.fn.glob('/usr/share/java-debug/com.microsoft.java.debug.plugin.jar', 1),
        },
    },
    settings = {
        signatureHelp = { enabled = true },
        java = {
            maven = {
                downloadSources = true,
                updateSnapshots = true,
                downloadJavadoc = true,
            },
            gradle = {
                downloadSources = true
            },
            eclipse = {
                downloadSources = true
            }
        }
    }
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
vim.lsp.enable({
    'tsc',
    'rust_analyzer',
    'clangd',
    'bashls',
    'jsonls',
    'cmake',
    'vala_ls',
    'fish_lsp',
    'pylsp',
    'lua_ls',
    'zls',
    'jdtls'
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local bufmap = function(mode, rhs, lhs)
      vim.keymap.set(mode, rhs, lhs, {buffer = event.buf})
    end

    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
    bufmap('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to Declaration' })
    bufmap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('n', 'gO', '<cmd>lua vim.lsp.buf.document_symbol()<cr>')
    bufmap('n', 'gsh', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
    bufmap('n', 'gt', vim.lsp.buf.type_definition, { desc = 'Go to Type Definition' })

    bufmap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous Diagnostic' })
    bufmap('n', ']d', vim.diagnostic.goto_next, { desc = 'Next Diagnostic' })

    bufmap('n', '<leader>ref', '<cmd>lua vim.lsp.buf.references()<cr>')
    bufmap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>')
    bufmap('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open Diagnostic Float' })
    bufmap('n', '<leader>lsd', vim.diagnostic.setloclist, { desc = 'Open Location List for Diagnostics' })
    bufmap('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, { desc = 'LSP Format' })

  end,
})
