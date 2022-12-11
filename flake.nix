{
  description = "Multirepo example";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    packageA.url = "github:Teekuningas/multirepo-nix-example-package-A";
    packageB.url = "github:Teekuningas/multirepo-nix-example-package-B";
    nixpkgs.url = "github:NixOS/nixpkgs";
  };
  outputs = { self, nixpkgs, flake-utils, packageA, packageB }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
 
        programA = packageA.defaultPackage.${system};
        programB = packageB.defaultPackage.${system};

        program = pkgs.stdenv.mkDerivation {
          name = "multirepo-nix-example-0.0.0";
          phases = ["installPhase"];
          installPhase = ''
          mkdir -p $out/bin
          echo '"${programA}/bin/hello"' > $out/bin/hello
          echo '"${programB}/bin/hello"' >> $out/bin/hello
          chmod +x $out/bin/hello
          '';
        };
      in rec {
        defaultPackage = program;
      }
    );
}

