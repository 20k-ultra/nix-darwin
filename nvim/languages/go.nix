{ pkgs, ... }: {
  plugins = {
    # Add Go to treesitter
    treesitter = {
      enable = true;
      settings = {
        ensure_installed = [ "go" ];
        highlight = {
          enable = true;
          additional_vim_regex_highlighting = false;
        };
      };
    };

    # Configure LSP for Go
    lsp.servers.gopls = {
      enable = true;
      settings = {
        gofumpt = true;
        analyses = {
          unusedparams = true;
          shadow = true;
        };
        staticcheck = true;
        usePlaceholders = true;
        completeUnimported = true;
        semanticTokens = true;
        # Enable code actions for organizing imports
        codelenses = {
          gc_details = false;
          generate = true;
          regenerate_cgo = true;
          run_govulncheck = true;
          test = true;
          tidy = true;
          upgrade_dependency = true;
          vendor = true;
        };
        hints = {
          assignVariableTypes = true;
          compositeLiteralFields = true;
          compositeLiteralTypes = true;
          constantValues = true;
          functionTypeParameters = true;
          parameterNames = true;
          rangeVariableTypes = true;
        };
      };
    };

    # Configure conform-nvim for Go formatting
    conform-nvim = {
      enable = true;
      settings = {
        formatters = {
          goimports = {
            command = "${pkgs.gotools}/bin/goimports";
          };
        };
        formatters_by_ft = {
          go = [ "goimports" ];
        };
        format_on_save = {
          timeout_ms = 500;
          lsp_fallback = true;
        };
      };
    };

    # Add nvim-dap support for Go
    dap.enable = true;
    dap-go.enable = true;
  };

  # Go-specific configuration
  extraConfigLua = ''
    -- Go specific settings
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "go",
      callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.expandtab = false  -- Go uses tabs, not spaces
        
        -- Auto-organize imports on save
        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern = "*.go",
          callback = function()
            -- Organize imports
            local params = vim.lsp.util.make_range_params()
            params.context = {only = {"source.organizeImports"}}
            local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
            for _, res in pairs(result or {}) do
              for _, r in pairs(res.result or {}) do
                if r.edit then
                  vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
                end
              end
            end
            
            -- Format the file
            vim.lsp.buf.format({ async = false })
          end,
        })
      end
    })
    
    -- Additional Go keymaps
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "go",
      callback = function()
        local opts = { buffer = true, silent = true }
        
        -- Go-specific keymaps
        vim.keymap.set("n", "<leader>gor", ":GoRun<CR>", vim.tbl_extend("force", opts, { desc = "Go run" }))
        vim.keymap.set("n", "<leader>got", ":GoTest<CR>", vim.tbl_extend("force", opts, { desc = "Go test" }))
        vim.keymap.set("n", "<leader>gof", ":GoTestFunc<CR>", vim.tbl_extend("force", opts, { desc = "Go test function" }))
        vim.keymap.set("n", "<leader>goi", function()
          -- Manually trigger organize imports
          local params = vim.lsp.util.make_range_params()
          params.context = {only = {"source.organizeImports"}}
          local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
          for _, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
              if r.edit then
                vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
              end
            end
          end
        end, vim.tbl_extend("force", opts, { desc = "Organize imports" }))
      end
    })
  '';

  # Install necessary Go tools
  extraPackages = with pkgs; [
    # Go itself
    go

    # Go tools
    gopls
    golangci-lint
    
    # Additional Go tools
    gotools
    gomodifytags
    gotests
    iferr
    impl
    delve  # Debugger
    
    # Go formatting tools
    gofumpt
  ];
}
