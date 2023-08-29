{ clangStdenv
, nodejs
, fetchgit
, pkgs
, lib
, llvmPackages
,
}:
clangStdenv.mkDerivation rec {
  name = "blanc";
  version = "16.0.0";
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
  nativeBuildInputs = with pkgs; [ pkgconfig cmake gcc16Stdenv clang16Stdenv git python3 ];

  src = fetchgit {
    owner = "haderech";
    repo = "blanc";
    rev = "${version}";
    sha256 = "sha256-08kmasxxnvjgvqarsnyf1mm1xyf5bzcrww6l0chrr52ijfpymclw"; #16.0.0
    fetchSubmodules = true;
  };
}
