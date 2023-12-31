{ clangStdenv
, nodejs
, fetchFromGitHub
, pkgs
, lib
, llvmPackages
,
}:
clangStdenv.mkDerivation rec {
  name = "cdt";
  version = "3.1.0";
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
  nativeBuildInputs = with pkgs; [ pkg-config cmake gcc11Stdenv clang11Stdenv git python3 ];
  cmakeFlags = [
    "-DCMAKE_CXX_COMPILER=${pkgs.gcc11Stdenv.cc}/bin/g++"
    "-DCMAKE_C_COMPILER=${pkgs.gcc11Stdenv.cc}/bin/gcc"
  ];

  src = fetchFromGitHub {
    owner = "AntelopeIO";
    repo = "cdt";
    rev = "v${version}";
    sha256 = "sha256-O1vXYvWDoVtqyAfDhJ/wDkejYri/ItlOoygsuZl1vlY=";
    fetchSubmodules = true;
  };
}
