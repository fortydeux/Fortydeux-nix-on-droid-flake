{ pkgs, ... }:

{
  home.stateVersion = "24.05";
  
  programs.atuin.enable = true;
  programs.fish.enable = true;
}
