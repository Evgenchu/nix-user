{
  description = "nix-user, a package for managing users in NixOS";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };
  outputs =
    {
      self,
      nixpkgs,
      utils,
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        nix-user = pkgs.stdenv.mkDerivation {
          pname = "nix-user";
          version = "1.0.0";
          src = ./.;

          installPhase = ''
            mkdir -p $out/bin
            cp -r $src/* $out/bin
            chmod +x $out/bin/nix-user.sh
            ln -s $out/bin/nix-user.sh $out/bin/nix-user
          '';

          meta = {
            description = "A CLI tool for managing NixOS users imperatively by generating Nix code";
            homepage = "https://github.com/Evgenchu/nix-user";
            license = pkgs.lib.licenses.mit;
          };
        };
        execution-tests =
          pkgs.runCommandLocal "execution"
            {
              src = ./.;
              nativeBuildInputs = with pkgs; [ bash ];
            }
            ''
              cp -r $src/* .
              chmod +x tests/executable-test.sh 
              export NIX_USER_PATH=${nix-user}
              if bash tests/executable-test.sh; then
                echo "Tests passed!"
                mkdir -p $out
              else
                echo "Tests failed!"
                exit 1
              fi
            '';
      in
      {
        packages = {
          nix-user = nix-user;
        };
        devShells.default = pkgs.mkShell {
          buildInputs = [ nix-user ];
          shellHook = ''
            echo "nix-user development environment activated"
            echo "You can now run 'nix-user' directly to test how it works"
          '';
        };
        checks = {
          build-check = nix-user;
          execution-check = execution-tests;
        };
      }
    );
}
