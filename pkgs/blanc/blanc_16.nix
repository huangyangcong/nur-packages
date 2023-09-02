{ stdenv
, gcc11Stdenv
, fetchFromGitHub
, pkgs
, lib
, llvmPackages
,
}:
gcc11Stdenv.mkDerivation rec {
  name = "blanc";
  version = "16.0.0";
  buildInputs = with pkgs; [
    stdenv.cc.cc # libstdc++
    llvmPackages_16.clang-unwrapped
    llvmPackages_16.llvm
    libxml2.dev
  ];
  nativeBuildInputs = with pkgs; [ pkgconfig cmake gcc11Stdenv git python3 ];

  src = fetchFromGitHub {
    owner = "haderech";
    repo = "blanc";
    rev = "${version}";
    sha256 = "sha256-hoFIz+Q8IFNVEqVOaReLGeP8fYyEV3Ixfi1wPneXBZM=";
    fetchSubmodules = true;
  };
}
