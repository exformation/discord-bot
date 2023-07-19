{
  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable"; };
  outputs = { self, nixpkgs }:
    let pkgs = nixpkgs.legacyPackages.x86_64-linux.pkgs;
    in with pkgs;
    with python311Packages; {
      devShells.x86_64-linux.default = mkShell {
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
      packages.x86_64-linux.default = buildPythonPackage {
        name = "discord-bot";
        pname = "discord-bot";
        version = "0.0.1";
        src = ./.;
        propagatedBuildInputs = [ discordpy requests ];
      };
      packages.armv7l-linux.default = buildPythonPackage {
        name = "discord-bot";
        pname = "discord-bot";
        version = "0.0.1";
        src = ./.;
        propagatedBuildInputs = [ discordpy requests ];
      };

    };
}
