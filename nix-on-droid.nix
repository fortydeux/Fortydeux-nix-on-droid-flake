{ config, lib, pkgs, nixvim, pkgsStable, ... }:
{
  environment.packages = with pkgs; [
    vim # Available as a minimal fallback editor.
    aichat
    codex
    neovim
    git
    gh
    mosh
    python3
    openssh
    opencode

    # Some common stuff that people expect to have
    #procps
    #killall
    #diffutils
    #findutils
    #utillinux
    #tzdata
    #hostname
    #man
    #gnugrep
    #gnupg
    #gnused
    #gnutar
    #bzip2
    #gzip
    #xz
    #zip
    #unzip
  ];

  android-integration = {
    am.enable = true;
    termux-open.enable = true;
    termux-open-url.enable = true;
    termux-reload-settings.enable = true;
    termux-setup-storage.enable = true;
    xdg-open.enable = true;
  };

  environment.etcBackupExtension = ".bak";
  system.stateVersion = "24.05";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  time.timeZone = "America/NewYork";

  home-manager.config = ./home.nix;
  home-manager.extraSpecialArgs = { inherit nixvim pkgsStable; };
}
