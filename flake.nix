{
  description = "Raid Night";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: 
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages.default = pkgs.hello;

        shell.default = pkgs.mkShell {
          buildInputs = with pkgs; [ nodejs nodePackages.create-react-app yarn ];
          shellHook = ''
            echo Developing!
          '';
        };
      }
    );
}
