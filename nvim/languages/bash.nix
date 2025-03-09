{ pkgs, ... }: {
  plugins = {
    # Add Bash to treesitter for better syntax highlighting
    treesitter.ensureInstalled = [ "bash" ];

    # Configure LSP for Bash
    lsp.servers.bashls = {
      enable = true;
      settings = {
        # Default settings for bash-language-server
        globPattern = "**/*.{sh,bash,zsh}";
      };
    };

    # Configure nvim-lint for shellcheck
    lint = {
      enable = true;
      lintersByFt = {
        sh = [ "shellcheck" ];
        bash = [ "shellcheck" ];
      };
    };

    # Configure formatter for shfmt
    conform-nvim = {
      enable = true;
      formatters = {
        shfmt = {
          command = "${pkgs.shfmt}/bin/shfmt";
          args = ["-i" "2" "-ci"];
        };
      };
      formattersByFt = {
        sh = [ "shfmt" ];
        bash = [ "shfmt" ];
      };
    };
  };

  # Setup shellcheck manually if needed
  extraConfigLua = ''
    vim.api.nvim_create_autocmd({"BufWritePost", "BufEnter"}, {
      pattern = {"*.sh", "*.bash"},
      callback = function()
        local shellcheck_cmd = "${pkgs.shellcheck}/bin/shellcheck"
        local file = vim.fn.expand("%:p")
        local job_id = vim.fn.jobstart({shellcheck_cmd, "-f", "gcc", file}, {
          on_stdout = function(_, data)
            if data then
              local diagnostics = {}
              for _, line in ipairs(data) do
                if line ~= "" then
                  local filename, lnum, col, severity, message = line:match("([^:]+):(%d+):(%d+): ([^:]+): (.*)")
                  if filename and lnum and col and message then
                    table.insert(diagnostics, {
                      lnum = tonumber(lnum) - 1,
                      col = tonumber(col) - 1,
                      message = message,
                      severity = severity == "error" and vim.diagnostic.severity.ERROR or 
                                severity == "warning" and vim.diagnostic.severity.WARN or 
                                vim.diagnostic.severity.INFO
                    })
                  end
                end
              end
              vim.diagnostic.set(vim.api.nvim_create_namespace("shellcheck"), 0, diagnostics)
            end
          end
        })
      end
    })
  '';

  # Install necessary Bash tools
  extraPackages = with pkgs; [
    # Bash language server
    nodePackages.bash-language-server
    
    # Shellcheck for static analysis
    shellcheck
    
    # shfmt for formatting
    shfmt
    
    # Additional helpful tools
    bats # Bash Automated Testing System
    shellharden # Shell script corrector
  ];
}
