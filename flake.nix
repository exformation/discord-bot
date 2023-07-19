{
  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable"; };
  outputs = { self, nixpkgs }:
    let pkgs = nixpkgs.legacyPackages.x86_64-linux.pkgs;
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          nil
          nixfmt
          python311
          python311Packages.python-lsp-server
          python311Packages.autopep8
          python311Packages.discordpy
          python311Packages.requests
        ];
      };
      packages.x86_64-linux.default = with pkgs.python311Packages;
        buildPythonPackage {
          name = "discord-bot";
          pname = "discord-bot";
          version = "0.0.1";
          src = ./.;
          propagatedBuildInputs = [ discordpy requests ];
        };
      packages.armv7l-linux.default = with pkgs.python311Packages;
        buildPythonPackage {
          name = "discord-bot";
          pname = "discord-bot";
          version = "0.0.1";
          src = ./.;
          propagatedBuildInputs = [ discordpy requests ];
        };

    };
}
