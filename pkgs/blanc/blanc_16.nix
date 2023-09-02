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
    stdenv.cc.cc.lib
    llvmPackages_16.clang-unwrapped
    llvmPackages_16.llvm
    libxml2.dev
    gmp.dev
    openssl.dev
    libusb1.dev
    bzip2.dev
    ocaml
    opam
    (boost.override
      {
        enableShared = false;
        enabledStatic = true;
      })
  ];
  nativeBuildInputs = with pkgs; [ pkgconfig cmake git python3 ];
  cmakeFlags = [
    "-DCMAKE_CXX_COMPILER=${pkgs.gcc11Stdenv.cc}/bin/g++"
    "-DCMAKE_C_COMPILER=${pkgs.gcc11Stdenv.cc}/bin/gcc"
  ];

  src = fetchFromGitHub {
    owner = "haderech";
    repo = "blanc";
    rev = "${version}";
    sha256 = "sha256-hoFIz+Q8IFNVEqVOaReLGeP8fYyEV3Ixfi1wPneXBZM=";
    fetchSubmodules = true;
  };
}
