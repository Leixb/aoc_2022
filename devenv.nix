{ pkgs, ... }:

{
  packages = with pkgs; [
    gawk
    go
  ];
}
