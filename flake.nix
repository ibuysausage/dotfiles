{
  description = "Flake for dotfiles for nixos";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    nixosModules.default = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        jq
        libnotify
        tmux
        zip
      ];
    };
  };
}
