{ pkgs, pkgsStable, nixvim, lib, ... }:
{
  imports = [ nixvim.homeModules.nixvim ];

  home.stateVersion = "24.05";

  fonts.fontconfig.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };

  home.shellAliases = {
    nod = "cd ~/.config/nix-on-droid/";
    nody = "cd ~/.config/nix-on-droid/ && yazi";
    nod-switch = "nix-on-droid switch -F ~/.config/nix-on-droid/";
  };

  programs = {
    atuin = {
      enable = true;
      flags = [ "--disable-ctrl-r" ];
      package = pkgsStable.atuin;
    };
    bash.enable = true;
    fish.enable = true;
    fzf.enable = true;
    helix = {
      enable = true;
      defaultEditor = true;
      settings = {
        theme = "tokyonight";
        editor = {
          line-number = "relative";
          mouse = true;
          soft-wrap.enable = true;
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
        };
      };
    };
    micro.enable = true;
    nix-search-tv = {
      enable = true;
      enableTelevisionIntegration = true;
    };
    nixvim = {
      enable = true;
      defaultEditor = false;
      opts = {
        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        smartindent = true;
        number = true;
        relativenumber = true;
        cursorline = true;
        wrap = false;
        timeoutlen = 1000;
        updatetime = 300;
      };
      plugins = {
        lualine.enable = true;
        telescope.enable = true;
        treesitter.enable = true;
        which-key.enable = true;
        gitsigns.enable = true;
        nvim-autopairs.enable = true;
        nvim-surround.enable = true;
        oil.enable = true;
        web-devicons.enable = true;
      };
    };
    television.enable = true;
    yazi = {
      enable = true;
      shellWrapperName = "y";
    };
    zellij.enable = true;
    home-manager.enable = true;
  };

  # Termux's Android font loader may not follow Home Manager's store symlink.
  # Install a real file so Nerd Font glyphs (including Yazi icons) render.
  home.activation.installTermuxFont = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD rm -f "$HOME/.termux/font.ttf"
    $DRY_RUN_CMD ${pkgs.coreutils}/bin/install -Dm644 \
      ${pkgs.nerd-fonts.jetbrains-mono}/share/fonts/truetype/NerdFonts/JetBrainsMono/JetBrainsMonoNerdFont-Regular.ttf \
      "$HOME/.termux/font.ttf"
  '';

  home.packages = with pkgs; [
    axel
    btop
    duf
    fastfetch
    fd
    nerd-fonts.jetbrains-mono
    nix-search
    rclone
    ripgrep
    tealdeer
    topgrade
  ];
}
