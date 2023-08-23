{ clangStdenv
, nodejs
, fetchgit
, pkgs
, lib
, llvmPackages
,
}:
clangStdenv.mkDerivation rec {
  name = "cdt";
  version = "4.0.0";
  buildInputs = with pkgs; [
    llvm
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
  nativeBuildInputs = with pkgs; [ pkgconfig cmake gcc11Stdenv clang11Stdenv git python3 ];
  cmakeFlags = [
    "-DCMAKE_CXX_COMPILER=${pkgs.gcc11Stdenv.cc}/bin/g++"
    "-DCMAKE_C_COMPILER=${pkgs.gcc11Stdenv.cc}/bin/gcc"
  ];

  src = fetchgit {
    url = "https://github.com/AntelopeIO/cdt";
    rev = "v${version}";
    sha256 = "sha256-yZpTj3MlWYDw3Se7ZwwvNnqB4XpdPVqHWY2hK18KIIU=";
    fetchSubmodules = true;
  };
}
