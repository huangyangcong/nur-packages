{ clangStdenv
, nodejs
, fetchFromGitHub
, pkgs
, lib
, xz
,
}:
clangStdenv.mkDerivation rec {
  pname = "leap";
  version = "4.0.4";

  src = fetchFromGitHub {
    owner = "AntelopeIO";
    repo = "leap";
    rev = "v${version}";
    hash = "sha256-14/oqaLF0LI94nkClIHPfxAOylsisp/6w7tWTkRFBI8=";
    fetchSubmodules = true;
  };

  prePatch = ''
    find . -type f -name '*.py' -print0 | xargs -0 -I{} sed -i -E 's#/usr/bin/env python3?#${pkgs.python3}/bin/python3#' {}
  '';

  nativeBuildInputs = with pkgs; [ pkgconfig cmake gcc11Stdenv clang11Stdenv git python3 ];
  cmakeFlags = [
    "-DCMAKE_CXX_COMPILER=${pkgs.gcc11Stdenv.cc}/bin/g++"
    "-DCMAKE_C_COMPILER=${pkgs.gcc11Stdenv.cc}/bin/gcc"
  ];

  buildInputs = with pkgs; [
    llvm
    curl.dev
    gmp.dev
    openssl.dev
    libusb1.dev
    bzip2.dev
    (lib.getLib xz)
    (boost.override
      {
        enableShared = false;
        enabledStatic = true;
      })
  ];
}
