{ fetchFromGitHub }:
let
  rust-overlay = import (fetchFromGitHub {
    owner = "oxalica";
    repo = "rust-overlay";
    rev = "9ea38d547100edcf0da19aaebbdffa2810585495";
    sha256 = "kwKCfmliHIxKuIjnM95TRcQxM/4AAEIZ+4A9nDJ6cJs=";
  });
in
rust-overlay.overlays.default
