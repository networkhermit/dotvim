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
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.config("rust_analyzer", {
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

      vim.lsp.enable("gopls")
      vim.lsp.enable("biome")
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("nixd")
      vim.lsp.enable("ruff")
      vim.lsp.enable("rust_analyzer")
      vim.lsp.enable("tofu_ls")
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    event = { "BufNewFile", "BufReadPre" },
  },
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
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
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "bash",
        "cue",
        "go",
        "json",
        "lua",
        "nix",
        "python",
        "rego",
        "rust",
        "terraform",
        "toml",
        "yaml",
      })
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true }),
        callback = function(args)
          local parser = vim.treesitter.get_parser(args.buf, nil, { error = false })
          if not parser then
            return
          end

          vim.treesitter.start(args.buf)

          vim.wo.foldenable = false
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo.foldmethod = "expr"

          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}

require("lazy").setup(plugins, opts)
vim.treesitter.language.register("terraform", "terraform-vars")

vim.opt.loadplugins = true
