# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs ? import <nixpkgs> { } }:

{
  # The `lib`, `modules`, and `overlay` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  #blanc_16 = pkgs.callPackage ./pkgs/blanc/blanc_16.nix { };
  cdt_3 = pkgs.callPackage ./pkgs/cdt/cdt_3.nix { };
  cdt_4 = pkgs.callPackage ./pkgs/cdt/cdt_4.nix { };
  leap_4 = pkgs.callPackage ./pkgs/leap/leap_4.nix { };
  solang_0_3_2 = pkgs.callPackage ./pkgs/solang/solang_0_3_2.nix { };
  foundry = pkgs.callPackage ./pkgs/solang/foundry.nix { };
  # some-qt5-package = pkgs.libsForQt5.callPackage ./pkgs/some-qt5-package { };
  # ...
}
