{
  description = "10 Days of Grad";

  inputs = rec {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils";
    hmatrix.url = "github:haedosa/hmatrix/haedosa";
    hasktorch-nix-skeleton.url = "github:haedosa/hasktorch-nix-skeleton";

  };

  outputs =
    inputs@{ self, nixpkgs, flake-utils, ... }:
    {
      overlay = nixpkgs.lib.composeManyExtensions
        (with inputs; [ hmatrix.overlay
                        hasktorch-nix-skeleton.overlay
                        (import ./overlay.nix)
                      ]);
    } // flake-utils.lib.eachDefaultSystem (system:

      let
        pkgs = import nixpkgs {
          inherit system;
          config = {};
          overlays = [
            self.overlay
          ];
        };

      in
      {
        inherit pkgs;
        devShells.default = import ./develop.nix { inherit pkgs; };

        packages = rec {
          default = pkgs.symlinkJoin {
            name = "10-days-of-grad";
            paths = [
              pkgs.haskellPackages.batchnorm
              pkgs.haskellPackages.conv
              pkgs.haskellPackages.bnn
              pkgs.haskellPackages.rl
              pkgs.haskellPackages.massiv-nn
            ];
          };

        };

      }
    );

}
