require("core")

-- lazy.nvim package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
vim.opt.cursorline = true

for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
    local default_diagnostic_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, result, context, config)
        if err ~= nil and err.code == -32802 then
            return
        end
        return default_diagnostic_handler(err, result, context, config)
    end
end


-- Plugins

local plugin_telescope = {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = { 
        'nvim-lua/plenary.nvim' ,
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    }
}

local plugin_treesitter = {
    'nvim-treesitter/nvim-treesitter',
        config = function()
        vim.cmd("TSUpdate")
    end
}

local plugin_mini_nvim = { 'nvim-mini/mini.nvim', version = false }

local plugin_nvim_jdtls = 'mfussenegger/nvim-jdtls'
local plugin_nvim_dap = 'mfussenegger/nvim-dap'
local plugin_nvim_dap_ui = 'rcarriga/nvim-dap-ui'

local plugin_colorscheme = {
    "rebelot/kanagawa.nvim",
    config = true,
    opts = {
        theme = "wave",
        background = { dark = "wave" },
        -- kanagawa deep-merges these over its defaults, so an empty table
        -- would leave the default italic/bold in place: be explicit.
        commentStyle = { italic = false },
        keywordStyle = { italic = false },
        statementStyle = { bold = false },
        functionStyle = { italic = false, bold = false },
        typeStyle = { italic = false, bold = false },
        variablebuiltinStyle = { italic = false },
        transparent = false,
        dimInactive = false,
        terminalColors = true,
        colors = {
            palette = {
                fujiWhite = "#EDE8D4", -- main fg, brighter
                fujiGray  = "#9E9B8B", -- comments: 3.3:1 -> 6.4:1
                sumiInk6  = "#7A7A99", -- line numbers: 2.2:1 -> 4.4:1
            },
            theme = {
                wave = {
                    ui = { bg = "#16161D" }, -- darker ground, more separation
                },
            },
        },
    },
    priority = 1000
}

local plugin_undotree = "mbbill/undotree"
local plugin_vim_figutive = "tpope/vim-fugitive"

local plugin_neo_tree = {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = {
        default_component_configs = {
            icon = {
                folder_empty = "󰜌",
                folder_empty_open = "󰜌",
            },
            git_status = {
                symbols = {
                    renamed   = "󰁕",
                    unstaged  = "󰄱",
                },
            },
        },
        filesystem = {
            filtered_items = {
                visible = true,
                hide_dotfiles = false
            }
        },
        document_symbols = {
            kinds = {
                File = { icon = "󰈙", hl = "Tag" },
                Namespace = { icon = "󰌗", hl = "Include" },
                Package = { icon = "󰏖", hl = "Label" },
                Class = { icon = "󰌗", hl = "Include" },
                Property = { icon = "󰆧", hl = "@property" },
                Enum = { icon = "󰒻", hl = "@number" },
                Function = { icon = "󰊕", hl = "Function" },
                String = { icon = "󰀬", hl = "String" },
                Number = { icon = "󰎠", hl = "Number" },
                Array = { icon = "󰅪", hl = "Type" },
                Object = { icon = "󰅩", hl = "Type" },
                Key = { icon = "󰌋", hl = "" },
                Struct = { icon = "󰌗", hl = "Type" },
                Operator = { icon = "󰆕", hl = "Operator" },
                TypeParameter = { icon = "󰊄", hl = "Type" },
                StaticMethod = { icon = '󰠄 ', hl = 'Function' },
            }
        }
    }
}

local plugin_treesj = {
    'Wansmer/treesj',
    keys = { '<space>m', '<space>j', '<space>s' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        require('treesj').setup({})
    end,
}


local nvimplugins = {
    plugin_telescope,
    plugin_colorscheme,
    plugin_treesitter,
    plugin_undotree,
    plugin_vim_figutive,
    plugin_neo_tree,
    plugin_treesj,
    plugin_mini_nvim,
    plugin_nvim_jdtls,
    plugin_nvim_dap,
    plugin_nvim_dap_ui
}

-- Plugins end

require("lazy").setup(nvimplugins)

require('mini.snippets').setup({})
require('mini.completion').setup({})

-- Setting up colorscheme
vim.cmd.colorscheme("kanagawa")
vim.cmd.set("number relativenumber")

