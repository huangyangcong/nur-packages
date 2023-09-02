{ stdenv
, fetchFromGitHub
, pkgs
, lib
, llvmPackages
,
}:
stdenv.mkDerivation rec {
  name = "blanc";
  version = "16.0.0";
  buildInputs = with pkgs; [
    llvmPackages_16.clang-unwrapped
    llvmPackages_16.llvm
    llvmPackages_16.lld
    libxml2.dev
  ];
  nativeBuildInputs = with pkgs; [ pkgconfig cmake git python3 ];

  cmakeFlags = [
    "-DLLVM_BUILD_EXTERNAL_COMPILER_RT=ON"
    "-DLLVM_BUILD_LLVM_DYLIB=ON"
    "-DLLVM_ENABLE_LIBCXX=ON"
    "-DLLVM_ENABLE_RTTI=ON"
    "-DLLVM_INCLUDE_DOCS=OFF"
    "-DLLVM_OPTIMIZED_TABLEGEN=ON"
    "-DLLVM_TARGETS_TO_BUILD=all"
    "-DCMAKE_BUILD_TYPE=Release"
  ];
  src = fetchFromGitHub {
    owner = "haderech";
    repo = "blanc";
    rev = "${version}";
    sha256 = "sha256-hoFIz+Q8IFNVEqVOaReLGeP8fYyEV3Ixfi1wPneXBZM=";
    fetchSubmodules = true;
  };
}
