# shell.nix - used with nix-shell to get a development environment with necessary dependencies
# Should be enough to run unit tests, integration tests and the service won't work
# If you don't use nix, don't worry about/use this file
let
  pkgs = import <nixpkgs> { };
in
pkgs.mkShell {
  nativeBuildInputs = [
    pkgs.pkg-config
    pkgs.wrapGAppsHook
  ];
  buildInputs = [
    pkgs.gobject-introspection
    pkgs.gtk3
    pkgs.bashInteractive
    pkgs.gobject-introspection
    pkgs.xlibs.xmodmap
    pkgs.gtksourceview4
    (pkgs.python310.withPackages (
      python-packages: with python-packages; [
        setuptools # for pkg_resources
        types-setuptools
        evdev
        pydbus
        pygobject3

        # only used in tests or to test
        psutil
        mypy
        pytest
        black
        flake8
      ]
    ))
  ];
}
