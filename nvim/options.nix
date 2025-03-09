{...}: {
  # Use explicit config attribute for all configuration
  config = {
    # Set leader key
    globals.mapleader = " ";

    # Basic options
    options = {
      number = true;         # Show line numbers
      relativenumber = true; # Show relative line numbers
      shiftwidth = 2;        # Number of spaces to use for each indentation step
      tabstop = 2;           # Number of spaces a tab counts for
      expandtab = true;      # Convert tabs to spaces
      smartindent = true;    # Smart auto-indenting when starting a new line
      wrap = false;          # Don't wrap lines
      ignorecase = true;     # Ignore case in search patterns
      smartcase = true;      # Override ignorecase if search contains uppercase
      termguicolors = true;  # Enable 24-bit RGB color
      updatetime = 300;      # Faster completion
      timeout = true;        # Enable timeout for key mappings
      timeoutlen = 500;      # Time in milliseconds to wait for a mapped sequence
      signcolumn = "yes";    # Always show the sign column
      
      # Configure how new splits should be opened
      splitright = true;     # New vertical splits go to the right
      splitbelow = true;     # New horizontal splits go below
      
      # Make search more convenient
      incsearch = true;      # Show search results as you type
      hlsearch = true;       # Highlight search results
      
      # Make editing more convenient
      undofile = true;       # Save undo history
      cursorline = true;     # Highlight the current line
      scrolloff = 8;         # Keep 8 lines visible when scrolling
      
      # System clipboard support
      clipboard = "unnamedplus";
    };

    # Automatically open Telescope on startup when no file is specified
    autoCmd = [
      {
        event = [ "VimEnter" ];
        callback = { 
          __raw = "function() if vim.fn.argc() == 0 then require('telescope.builtin').find_files() end end"; 
        };
      }
    ];
    
    # Fix common typos in command mode
    userCommands = {
      W.command = "w";
      Q.command = "q";
      Wq.command = "wq";
      WQ.command = "wq";
    };
  };
}
