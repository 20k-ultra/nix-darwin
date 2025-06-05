{ pkgs, ... }: {
  colorscheme = "sonokai";

  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "sonokai";
      src = pkgs.fetchFromGitHub {
        owner = "20k-ultra";
        repo = "sonokai";
        rev = "master";
        sha256 = "sha256-qROaZx0kIYVT8yCrTmK0cVDw9LPVCS1J1GslUc2ZrP0=";
      };
    })
  ];

  extraConfigLua = ''
    -- Sonokai theme configuration
    vim.g.sonokai_style = 'default'  -- Options: default, atlantis, andromeda, shusia, maia, espresso
    vim.g.sonokai_better_performance = 1
    vim.g.sonokai_enable_italic = 1
    vim.g.sonokai_disable_italic_comment = 0
    vim.g.sonokai_transparent_background = 0
    vim.g.sonokai_current_word = 'bold'  -- Make current word stand out
    vim.g.sonokai_diagnostic_line_highlight = 1
    vim.g.sonokai_diagnostic_virtual_text = 'colored'
  '';
}

