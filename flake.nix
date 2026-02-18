{
  description = "Reddix - Reddit, refined for the terminal";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in {
          default = pkgs.rustPlatform.buildRustPackage {
            pname = "reddix";
            version = "0.2.9";
            src = self;
            cargoHash = "sha256-4R27KeXu7nRA7A7GLbhIf+j5RKnOrOoysoUcZH053ns=";
            doCheck = false;
            nativeBuildInputs = with pkgs; [ pkg-config ];
            buildInputs = with pkgs; [ shared-mime-info ];
          };
        });
    };
}
