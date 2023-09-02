{ stdenv
, gcc10Stdenv
, fetchFromGitHub
, pkgs
, lib
, llvmPackages
,
}:
gcc10Stdenv.mkDerivation rec {
  name = "blanc";
  version = "16.0.0";
  buildInputs = with pkgs; [
    stdenv.cc.cc # libstdc++
    llvmPackages_16.clang-unwrapped
    llvmPackages_16.llvm
    libxml2.dev
  ];
  nativeBuildInputs = with pkgs; [ pkgconfig cmake git python3 ];
  cmakeFlags = [
    "-DCMAKE_CXX_COMPILER=${pkgs.llvmPackages_16.clang}/bin/clang++"
    "-DCMAKE_C_COMPILER=${pkgs.llvmPackages_16.clang}/bin/clang"
  ];

  src = fetchFromGitHub {
    owner = "haderech";
    repo = "blanc";
    rev = "${version}";
    sha256 = "sha256-hoFIz+Q8IFNVEqVOaReLGeP8fYyEV3Ixfi1wPneXBZM=";
    fetchSubmodules = true;
  };
}
