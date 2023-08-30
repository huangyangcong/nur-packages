{ clangStdenv
, nodejs
, fetchFromGitHub
, pkgs
, lib
, llvmPackages
,
}:
clangStdenv.mkDerivation rec {
  name = "blanc";
  version = "16.0.0";
  buildInputs = with pkgs; [
    llvmPackages_16.llvm
    curl.dev
    gmp.dev
    openssl.dev
    libusb1.dev
    bzip2.dev
    libxml2.dev
    ocaml
    opam
    (boost.override
      {
        enableShared = false;
        enabledStatic = true;
      })
  ];
  nativeBuildInputs = with pkgs; [ pkgconfig cmake clang13Stdenv git python3 ];
  cmakeFlags = [
    "-DCMAKE_CXX_COMPILER=${pkgs.gcc13Stdenv.cc}/bin/clang"
    "-DCMAKE_C_COMPILER=${pkgs.gcc13Stdenv.cc}/bin/clang++"
    "-DCMAKE_PREFIX_PATH=${llvmPackages_16.llvm}/lib/cmake/llvm"
  ];

  src = fetchFromGitHub {
    owner = "haderech";
    repo = "blanc";
    rev = "${version}";
    sha256 = "sha256-hoFIz+Q8IFNVEqVOaReLGeP8fYyEV3Ixfi1wPneXBZM="; #16.0.0
    fetchSubmodules = true;
  };
}
