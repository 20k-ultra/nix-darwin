{ ... }: {
  plugins = {
    # Bufferline configuration
    bufferline = {
      enable = true;
      settings = {
        options = {
          show_buffer_icons = false; # Remove file type icons
          show_buffer_close_icons = false; # Remove the "x" on each buffer
          show_close_icon = false; # Remove the close button at the end
          buffer_close_icon = ""; # Make buffer close icon empty (backup)
          close_icon = ""; # Make close icon empty (backup)
          modified_icon = "●"; # Show dot indicator for modified buffers
          indicator = {
            style = "none"; # Remove the line indicator on active buffer
          };
        };
      };
    };

    # Other UI plugins
    telescope.enable = true;
    lualine.enable = true;
    gitsigns.enable = true;
    nvim-autopairs.enable = true;
    comment.enable = true;
  };

  extraConfigLua = ''
    -- Bufferline color customization for a more subtle active buffer
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        -- Set more subtle bufferline colors
        vim.api.nvim_set_hl(0, "BufferLineTabSelected", {
          bg = "#2D2E32", -- Slightly darker than background
          fg = "#F8F8F2", -- Normal foreground
          bold = true
        })
       
        vim.api.nvim_set_hl(0, "BufferLineBackground", {
          bg = "#1B1D1E", -- Match your terminal background
          fg = "#6C6C6C" -- Dimmer text for inactive buffers
        })
       
        vim.api.nvim_set_hl(0, "BufferLineModified", {
          bg = "#1B1D1E",
          fg = "#FF6E67" -- Subtle red for modified indicator
        })
       
        vim.api.nvim_set_hl(0, "BufferLineModifiedSelected", {
          bg = "#2D2E32",
          fg = "#FF6E67" -- Red for active modified buffer
        })
       
        -- Remove separator styling for cleaner look
        vim.api.nvim_set_hl(0, "BufferLineSeparator", {
          bg = "#1B1D1E",
          fg = "#1B1D1E"
        })
      end
    })

    -- Apply colors immediately after colorscheme loads
    vim.defer_fn(function()
      vim.cmd("doautocmd ColorScheme")
    end, 100)
  '';
}

