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
  postPatch = ''
    for f in ${src}/scripts/blanc_build.sh ${src}/scripts/blanc_install.sh ${src}/scripts/helpers/eosio.sh; ${src}/scripts/helpers/general.sh; do
      substituteInPlace "$f" --replace "/usr/bin/env" "${pkgs.coreutils}/bin/env"
    done
  '';
  nativeBuildInputs = with pkgs; [ pkgconfig gcc13Stdenv cmake coreutils git python3 ];
  builder = "${src}/scripts/blanc_build.sh";
  setup = "${src}/scripts/blanc_install.sh";
  src = fetchFromGitHub {
    owner = "haderech";
    repo = "blanc";
    rev = "${version}";
    sha256 = "sha256-hoFIz+Q8IFNVEqVOaReLGeP8fYyEV3Ixfi1wPneXBZM=";
    fetchSubmodules = true;
  };
}
