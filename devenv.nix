{ pkgs, ... }:

{
  packages = with pkgs; [
    gawk
    go
    gcc
    python3
  ];
}
