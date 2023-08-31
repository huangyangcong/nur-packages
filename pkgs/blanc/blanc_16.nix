{ clangStdenv
, nodejs
, fetchFromGitHub
, pkgs
, lib
, llvmPackages
, coreutils
,
}:
clangStdenv.mkDerivation rec {
  name = "blanc";
  version = "16.0.0";
  buildInputs = with pkgs; [
    llvmPackages_16.clang-unwrapped
    llvmPackages_16.llvm
    llvmPackages_16.lld
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
  nativeBuildInputs = with pkgs; [ pkgconfig gcc13Stdenv cmake git python3 ];
  builder = "${src}/scripts/blanc_build.sh";
  setup = "${src}/scripts/blanc_install.sh";
  postPatch = ''
    patchShebangs blanc

    for f in blanc/scripts/blanc_build.sh blanc/scripts/blanc_install.sh; do
      substituteInPlace "$f" --replace "/usr/bin/env" "${coreutils}/bin/env"
    done
  '';
  src = fetchFromGitHub {
    owner = "haderech";
    repo = "blanc";
    rev = "${version}";
    sha256 = "sha256-hoFIz+Q8IFNVEqVOaReLGeP8fYyEV3Ixfi1wPneXBZM=";
    fetchSubmodules = true;
  };
}
