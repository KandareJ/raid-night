{
  description = "Raid night flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: 
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages.default = pkgs.stdenv.mkDerivation {
          src = ./.;
          name = "raid-night";
          nativeBuildInputs = [ pkgs.mdbook ];

            buildPhase = ''
              mdbook build
            '';

            installPhase = ''
              mkdir -p $out
              cp -r book/* $out/
            '';
        };

        devShells.default = pkgs.mkShell {
          buildInputs = [ pkgs.mdbook ];
          shellHook = ''
            alias run="mdbook serve"
            echo "Raid night!"
          '';
        };
      }
    );
}
