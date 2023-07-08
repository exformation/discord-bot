{
  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable"; };
  outputs = { self, nixpkgs }:
    let pkgs = nixpkgs.legacyPackages.x86_64-linux.pkgs;
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          nil
          nixfmt
          python310
          python310Packages.python-lsp-server
          python310Packages.autopep8
          python310Packages.evdev
          # python310Packages.pylint
          # python310Packages.flake8

          # NOTE: just messing around with examples that interact directly with X
          # TODO: push to nixpkgs
          # (python3Packages.buildPythonPackage rec {
          #   pname = "python-xlib";
          #   version = "0.33";
          #   src = fetchPypi {
          #     inherit pname version;
          #     sha256 = "sha256-Va95BqLHXObLKApYR3YIBgJET3WBWnr/TSh7stcBizI=";
          #   };
          #   doCheck = false;
          #   propagatedBuildInputs = [
          #     python310Packages.setuptools-scm
          #     python310Packages.coverage
          #     python310Packages.codecov
          #     python310Packages.mock
          #     python310Packages.nose
          #     python310Packages.six
          #   ];
          # })
        ];
      };
    };
}
