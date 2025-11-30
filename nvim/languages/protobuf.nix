{ pkgs, ... }: {
  plugins = {
    # Add Protobuf to treesitter
    treesitter = {
      enable = true;
      settings = {
        ensure_installed = [ "proto" ];
        highlight = {
          enable = true;
          additional_vim_regex_highlighting = false;
        };
      };
    };

    # Configure conform-nvim for Protobuf formatting
    conform-nvim = {
      enable = true;
      settings = {
        formatters = {
          buf = {
            command = "${pkgs.buf}/bin/buf";
            args = [ "format" "-w" "$FILENAME" ];
          };
        };
        formatters_by_ft = {
          proto = [ "buf" ];
        };
        format_on_save = {
          timeout_ms = 500;
          lsp_fallback = true;
        };
      };
    };
  };

  # Protobuf-specific configuration
  extraConfigLua = ''
    -- Manually configure protobuf LSP server using neovim's built-in API
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "proto",
      callback = function()
        -- Start protobuf-language-server
        vim.lsp.start({
          name = "protobuf-language-server",
          cmd = { "${pkgs.protobuf-language-server}/bin/protobuf-language-server", "--stdio" },
          root_dir = vim.fs.dirname(vim.fs.find({ 'buf.yaml', 'buf.work.yaml', '.git' }, { upward = true })[1]),
          capabilities = vim.lsp.protocol.make_client_capabilities(),
        })
      end,
    })

    -- Protobuf specific settings
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "proto",
      callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.expandtab = true

        -- Auto-format on save
        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern = "*.proto",
          callback = function()
            vim.lsp.buf.format({ async = false })
          end,
        })
      end
    })

    -- Additional Protobuf keymaps
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "proto",
      callback = function()
        local opts = { buffer = true, silent = true }

        -- Protobuf-specific keymaps
        vim.keymap.set("n", "<leader>pl", function()
          -- Run buf lint on the current file
          vim.cmd("!buf lint " .. vim.fn.expand("%:p"))
        end, vim.tbl_extend("force", opts, { desc = "Buf lint" }))

        vim.keymap.set("n", "<leader>pb", function()
          -- Run buf breaking change detection
          vim.cmd("!buf breaking --against '.git#branch=main'")
        end, vim.tbl_extend("force", opts, { desc = "Buf breaking" }))
      end
    })
  '';

  # Install necessary Protobuf tools
  extraPackages = with pkgs; [
    # Protobuf compiler
    protobuf

    # buf - Modern protobuf tooling for linting and formatting
    buf

    # Protobuf language server for LSP features
    protobuf-language-server

    # Optional: protoc-gen plugins for various languages
    # Uncomment the ones you need
    # protoc-gen-go
    # protoc-gen-go-grpc
  ];
}
