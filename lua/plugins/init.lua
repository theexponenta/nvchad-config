return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
      "mason-org/mason.nvim",
      opts = function ()
        require("mason").setup {
          registries = {
            "github:mason-org/mason-registry",
          },
        }

        local mr = require "mason-registry"
        mr.refresh(function()
          local package = require "mason-core.package"
          local notify = require "mason-core.notify"

          for _, tool in ipairs {
            "codelldb",
            "pyrefly",
            "typescript-language-server",
            "clangd",
          } do
            local package_name, _ = package.Parse(tool)
            local p_ok, p = pcall(mr.get_package, package_name)

            if not p_ok or not p then
              notify(("%q is not a valid package."):format(tool), vim.log.levels.ERROR)
              goto continue
            end

            if not p:is_installed() then
              p:install(nil, function(ok, err)
                if ok or not err then return end
                notify(
                  ("Error installing %s.\n%s"):format(tool, tostring(err)),
                  vim.log.levels.ERROR,
                  { title = "Mason (install)" }
                )
              end)
            end
              ::continue::
          end
        end)
      end
  },

  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
    ft = "rust",
    config = function ()
      local mason_registry = require('mason-registry')
      local codelldb = mason_registry.get_package("codelldb")
      local extension_path = codelldb:get_install_path() .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
	    local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
      local cfg = require('rustaceanvim.config')

      vim.g.rustaceanvim = {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
        tools = {
          float_win_config = {
            border = 'rounded'
          }
        }
      }
    end
  },

  {
    'rust-lang/rust.vim',
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },

  {
    'mfussenegger/nvim-dap',
    config = function()
			local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      dap.configurations.rust = {
        {
          name = 'Launch Rust file',
          type = 'codelldb',
          request = 'launch',
          program = function()
            -- Automatically prompts you to pick the compiled binary in target/debug/
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }
		end,
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    config = function()
			require("dapui").setup()
		end,
  },

  "pogyomo/winresize.nvim",

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
