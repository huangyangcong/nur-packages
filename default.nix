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

  cdt_3_1_0 = pkgs.callPackage ./pkgs/cdt/3.1.0 { };
  cdt_4_0_0 = pkgs.callPackage ./pkgs/cdt/4.0.0 { };
  leap_4_0_4 = pkgs.callPackage ./pkgs/leap/4.0.4 { };
  blanc_16_0_0 = pkgs.callPackage ./pkgs/blanc/16.0.0 { };
  # some-qt5-package = pkgs.libsForQt5.callPackage ./pkgs/some-qt5-package { };
  # ...
}
