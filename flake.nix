{
  description = "Raid night flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    # mdbook-admonish (1.20.0, the latest release as of writing) doesn't yet
    # speak mdbook 0.5's preprocessor protocol: https://github.com/tommilligan/mdbook-admonish/issues/233
    # Pin mdbook + mdbook-admonish together from a known-compatible nixpkgs
    # release until that's fixed upstream.
    nixpkgs-mdbook.url = "github:nixos/nixpkgs?ref=nixos-24.11";
  };

  outputs = { self, nixpkgs, flake-utils, nixpkgs-mdbook }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        pkgsMdbook = nixpkgs-mdbook.legacyPackages.${system};
        mdbookTools = [ pkgsMdbook.mdbook pkgsMdbook.mdbook-admonish ];
      in {
        packages.default = pkgs.stdenv.mkDerivation {
          src = ./.;
          name = "raid-night";
          nativeBuildInputs = mdbookTools;

            buildPhase = ''
              mdbook build
            '';

            installPhase = ''
              mkdir -p $out
              cp -r book/* $out/
            '';
        };

        devShells.default = pkgs.mkShell {
          buildInputs = mdbookTools;
          shellHook = ''
            alias run="mdbook serve"
            echo "Raid night!"
          '';
        };
      }
    );
}
