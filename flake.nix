{
  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable"; };
  outputs = { self, nixpkgs }:
    let
      pkgs_x86 = nixpkgs.legacyPackages.x86_64-linux.pkgs;
      pkgs_arm = nixpkgs.legacyPackages.armv7l-linux.pkgs;
    in {
      devShells.x86_64-linux.default = with pkgs_x86; with python311Packages;
        mkShell {
          buildInputs = [
            nil
            nixfmt
            python311
            python-lsp-server
            autopep8
            discordpy
            requests
          ];
        };
      packages.x86_64-linux.default = with pkgs_x86;
        with python311Packages;
        buildPythonPackage {
          name = "discord-bot";
          pname = "discord-bot";
          version = "0.0.1";
          src = ./.;
          propagatedBuildInputs = [ discordpy requests ];
        };
      # packages.armv7l-linux.default = with pkgs_arm;
      #   with python311Packages;
      #   buildPythonPackage {
      #     name = "discord-bot";
      #     pname = "discord-bot";
      #     version = "0.0.1";
      #     src = ./.;
      #     propagatedBuildInputs = [ discordpy requests ];
      #   };
    };
}
