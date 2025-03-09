{...}: {
  config = {
    keymaps = [
      # File explorer toggle
      {
        mode = "n";
        key = "<leader>e";
        action = ":NvimTreeToggle<CR>";
        options = {
          silent = true;
          desc = "Toggle file explorer";
        };
      }
      
      # Focus file explorer
      {
        mode = "n";
        key = "<leader>E";
        action = ":NvimTreeFocus<CR>";
        options = {
          silent = true;
          desc = "Focus file explorer";
        };
      }
      
      # Find file in NvimTree
      {
        mode = "n";
        key = "<leader>tf";
        action = ":NvimTreeFindFile<CR>";
        options = {
          silent = true;
          desc = "Find current file in explorer";
        };
      }
      
      # Buffer navigation
      {
        mode = "n";
        key = "<S-l>";
        action = ":BufferLineCycleNext<CR>";
        options = {
          silent = true;
          desc = "Go to next buffer";
        };
      }
      
      {
        mode = "n";
        key = "<S-h>";
        action = ":BufferLineCyclePrev<CR>";
        options = {
          silent = true;
          desc = "Go to previous buffer";
        };
      }
      
      # Close current buffer
      {
        mode = "n";
        key = "<leader>bd";
        action = ":bdelete<CR>";
        options = {
          silent = true;
          desc = "Close current buffer";
        };
      }
      
      # Close all buffers except current
      {
        mode = "n";
        key = "<leader>bo";
        action = ":%bd|e#|bd#<CR>";
        options = {
          silent = true;
          desc = "Close all buffers except current";
        };
      }
      
      # Find files
      {
        mode = "n";
        key = "<leader>ff";
        action = ":Telescope find_files<CR>";
        options = {
          silent = true;
          desc = "Find files";
        };
      }
      
      # Live grep (search for text)
      {
        mode = "n";
        key = "<leader>fw";
        action = ":Telescope live_grep<CR>";
        options = {
          silent = true;
          desc = "Live grep";
        };
      }
      
      # Browse files
      {
        mode = "n";
        key = "<leader>fb";
        action = ":Telescope file_browser<CR>";
        options = {
          silent = true;
          desc = "Browse files";
        };
      }
      
      # Search current buffer
      {
        mode = "n";
        key = "<leader>fs";
        action = ":Telescope current_buffer_fuzzy_find<CR>";
        options = {
          silent = true;
          desc = "Search in current buffer";
        };
      }

      # Close current buffer
      {
        mode = "n";
        key = "<leader>c";
        action = ":bdelete<CR>";
        options = {
          silent = true;
          desc = "Close current buffer";
        };
      }

      # Recent files
      {
        mode = "n";
        key = "<leader>fr";
        action = ":Telescope oldfiles<CR>";
        options = {
          silent = true;
          desc = "Recent files";
        };
      }
      
      # Git status
      {
        mode = "n";
        key = "<leader>gs";
        action = ":Telescope git_status<CR>";
        options = {
          silent = true;
          desc = "Git status";
        };
      }
      
      # Remove search highlighting
      {
        mode = "n";
        key = "<leader>h";
        action = ":nohlsearch<CR>";
        options = {
          silent = true;
          desc = "Clear search highlight";
        };
      }
      
      # Split window management
      {
        mode = "n";
        key = "<leader>sv";
        action = ":vsplit<CR>";
        options = {
          silent = true;
          desc = "Split vertically";
        };
      }
      
      {
        mode = "n";
        key = "<leader>sh";
        action = ":split<CR>";
        options = {
          silent = true;
          desc = "Split horizontally";
        };
      }
      
      # Better window navigation
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options = {
          desc = "Go to left window";
        };
      }
      
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options = {
          desc = "Go to lower window";
        };
      }
      
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options = {
          desc = "Go to upper window";
        };
      }
      
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options = {
          desc = "Go to right window";
        };
      }
    ];
  };
}

