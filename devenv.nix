{ pkgs, ... }:

{
  packages = with pkgs; [
    gawk
    go
    gcc
    python3
    rustc
    rust-analyzer
    cargo
  ];

  languages.haskell.enable = true;
}
