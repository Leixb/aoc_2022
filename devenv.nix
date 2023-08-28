{ pkgs, ... }:

{
  # packages = with pkgs; [
  #   gawk
  #   go
  #   gcc
  #   python3
  #   rustc
  #   rust-analyzer
  #   cargo
  # ];

  languages = {
    haskell.enable = true;
    julia.enable = true;
    go.enable = true;
    rust.enable = true;
    cplusplus.enable = true;
    c.enable = true;
    python.enable = true;
  };
}
