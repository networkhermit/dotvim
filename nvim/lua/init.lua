local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

local opts = {
  performance = {
    reset_packpath = false,
    rtp = {
      reset = false,
    },
  },
}

local plugins = {
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
        window = {
          completion = cmp.config.window.bordered({
            scrollbar = false,
          }),
          documentation = cmp.config.window.bordered(),
        },
      })
    end,
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
      },
    },
    event = "InsertEnter",
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      null_ls.setup({
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format()
              end,
            })
          end
        end,
        sources = {
          null_ls.builtins.code_actions.shellcheck,
          null_ls.builtins.diagnostics.ansiblelint,
          null_ls.builtins.diagnostics.golangci_lint,
          null_ls.builtins.diagnostics.mypy,
          null_ls.builtins.diagnostics.opacheck,
          null_ls.builtins.diagnostics.ruff,
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.diagnostics.staticcheck,
          null_ls.builtins.diagnostics.terraform_validate,
          null_ls.builtins.diagnostics.trail_space,
          null_ls.builtins.diagnostics.yamllint,
          null_ls.builtins.formatting.alejandra,
          null_ls.builtins.formatting.jq.with({ extra_args = { "--sort-keys", "." } }),
          null_ls.builtins.formatting.rego,
          null_ls.builtins.formatting.rome.with({ disabled_filetypes = { "json" } }),
          null_ls.builtins.formatting.rustfmt,
          -- null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.terraform_fmt,
          null_ls.builtins.formatting.yq.with({ extra_args = { "'sort_keys(..)'" } }),

          null_ls.builtins.formatting.goimports,
          null_ls.builtins.formatting.gofmt.with({ extra_args = { "-s" } }),

          null_ls.builtins.formatting.ruff,
          null_ls.builtins.formatting.black,
        },
      })

      vim.g.build_mate_format_disabled_filetypes = {
        "go",
        "json",
        -- "lua",
        "nix",
        "python",
        "rust",
        "terraform",
        "terraform-vars",
        "yaml",
      }
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufNewFile", "BufReadPre" },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      lspconfig.gopls.setup({ capabilities = capabilities })
      lspconfig.lua_ls.setup({ capabilities = capabilities })
      lspconfig.rome.setup({ capabilities = capabilities })
      lspconfig.ruff_lsp.setup({ capabilities = capabilities })
      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            check = {
              command = "clippy",
            },
            imports = {
              granularity = {
                enforce = true,
              },
            },
          },
        },
      })
      lspconfig.terraformls.setup({ capabilities = capabilities })
      lspconfig.tflint.setup({ capabilities = capabilities })
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    event = { "BufNewFile", "BufReadPre" },
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    cmd = "Telescope",
    config = function()
      require("telescope").setup({
        defaults = {
          history = false,
        },
      })
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    cmd = { "TSUpdateSync" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "go", "python", "rust", "terraform" },
        highlight = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_decremental = "grm",
            node_incremental = "grn",
            scope_incremental = "grc",
          },
        },
        indent = { enable = true },
        textobjects = {
          move = {
            enable = true,
            set_jumps = true,

            goto_next_start = {
              ["]t"] = "@class.outer",
              ["]f"] = "@function.outer",
              ["]a"] = "@parameter.inner",
              ["]o"] = "@conditional.outer",
              ["]l"] = "@loop.outer",
              ["]b"] = "@block.outer",
              ["]s"] = "@call.outer",
              ["]r"] = "@assignment.outer",
            },
            goto_next_end = {
              ["]T"] = "@class.outer",
              ["]F"] = "@function.outer",
              ["]A"] = "@parameter.inner",
              ["]O"] = "@conditional.outer",
              ["]L"] = "@loop.outer",
              ["]B"] = "@block.outer",
              ["]S"] = "@call.outer",
              ["]R"] = "@assignment.outer",
            },

            goto_previous_start = {
              ["[t"] = "@class.outer",
              ["[f"] = "@function.outer",
              ["[a"] = "@parameter.inner",
              ["[o"] = "@conditional.outer",
              ["[l"] = "@loop.outer",
              ["[b"] = "@block.outer",
              ["[s"] = "@call.outer",
              ["[r"] = "@assignment.outer",
            },
            goto_previous_end = {
              ["[T"] = "@class.outer",
              ["[F"] = "@function.outer",
              ["[A"] = "@parameter.inner",
              ["[O"] = "@conditional.outer",
              ["[L"] = "@loop.outer",
              ["[B"] = "@block.outer",
              ["[S"] = "@call.outer",
              ["[R"] = "@assignment.outer",
            },
          },
          select = {
            enable = true,
            include_surrounding_whitespace = true,
            lookahead = true,

            keymaps = {
              ["at"] = "@class.outer",
              ["it"] = "@class.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["ao"] = "@conditional.outer",
              ["io"] = "@conditional.inner",
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
              ["ab"] = "@block.outer",
              ["ib"] = "@block.inner",
              ["as"] = "@call.outer",
              ["is"] = "@call.inner",
              ["ar"] = "@assignment.outer",
              ["ir"] = "@assignment.inner",
              ["a#"] = "@comment.outer",
              ["i#"] = "@comment.inner",
            },
          },
          swap = {
            enable = true,

            swap_next = {
              [">T"] = "@class.outer",
              [">F"] = "@function.outer",
              [">A"] = "@parameter.inner",
              [">O"] = "@conditional.outer",
              [">L"] = "@loop.outer",
              [">B"] = "@block.outer",
              [">S"] = "@call.outer",
              [">R"] = "@assignment.outer",
              [">#"] = "@comment.outer",
            },
            swap_previous = {
              ["<T"] = "@class.outer",
              ["<F"] = "@function.outer",
              ["<A"] = "@parameter.inner",
              ["<O"] = "@conditional.outer",
              ["<L"] = "@loop.outer",
              ["<B"] = "@block.outer",
              ["<S"] = "@call.outer",
              ["<R"] = "@assignment.outer",
              ["<#"] = "@comment.outer",
            },
          },
        },
      })

      vim.opt.foldenable = false
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldmethod = "expr"

      local repeatable_move = require("nvim-treesitter.textobjects.repeatable_move")

      vim.keymap.set({ "n", "x", "o" }, ";", repeatable_move.repeat_last_move)
      vim.keymap.set({ "n", "x", "o" }, ",", repeatable_move.repeat_last_move_opposite)

      vim.keymap.set({ "n", "x", "o" }, "f", repeatable_move.builtin_f)
      vim.keymap.set({ "n", "x", "o" }, "F", repeatable_move.builtin_F)
      vim.keymap.set({ "n", "x", "o" }, "t", repeatable_move.builtin_t)
      vim.keymap.set({ "n", "x", "o" }, "T", repeatable_move.builtin_T)
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    event = { "BufNewFile", "BufReadPost" },
  },
}

require("lazy").setup(plugins, opts)
vim.treesitter.language.register("terraform", "terraform-vars")

vim.opt.loadplugins = true
