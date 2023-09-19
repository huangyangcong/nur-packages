{ stdenv, fetchurl, autoPatchelfHook, pkgs, zlib }:
stdenv.mkDerivation {
  name = "solang";
  src = fetchurl {
    url = "https://github.com/hyperledger/solang/releases/download/v0.3.2/solang-linux-x86-64";
    sha256 = "sha256-+qezaj8+s/oYR0VaHntW3RucMth5IfOQ6tcwhBw4qKE=";
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
