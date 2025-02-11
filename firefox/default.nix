# ~/.config/nix/firefox/default.nix
{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-dev;  # Our custom package
    
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
      
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.startup.homepage" = "about:blank";
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "browser.startup.page" = 0;
        "dom.security.https_only_mode" = true;
      };

      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        vimium
	darkreader
	ublock-origin
	tree-style-tab
	decentraleyes
	facebook-container
	onepassword-password-manager
      ];

      userChrome = builtins.readFile ./userChrome.css;
    };
  };
}
