{ stdenv, fetchurl, autoPatchelfHook, pkgs, zlib }:
stdenv.mkDerivation {
  name = "solang";
  src = fetchurl {
    url = "https://github.com/hyperledger/solang/releases/download/v0.3.2/solang-linux-x86-64";
    sha256 = "sha256-aUgc0cXyiyBvzye3wKLFCsJDevVPzwyD3588zn2Qtd4=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    stdenv.cc.cc.lib
    zlib
  ];
  unpackPhase = "true";
  installPhase = ''
    install -m755 -D $src $out/bin/solang
  '';
}
