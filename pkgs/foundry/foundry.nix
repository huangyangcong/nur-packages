{ lib, pkgs, fetchFromGitHub }:
let
  rustVersion = pkgs.rust-bin.stable.latest.default.override {
    #extensions = [ "rust-src" ];
    #targets = [ "x86_64-unknown-linux-musl" ];
    targets = [ "wasm32-wasi" "wasm32-unknown-unknown" "wasm32-unknown-emscripten" ];
  };
  rustPlatform = pkgs.makeRustPlatform {
    cargo = rustVersion;
    rustc = rustVersion;
  };
in
rustPlatform.buildRustPackage rec {
  # Enable nightly features somehow
  # https://nixos.org/manual/nixpkgs/stable/#using-community-maintained-rust-toolchains
  RUSTC_BOOTSTRAP = 1;

  pname = "foundry";
  version = "nightly-2022.09.23";

  src = fetchFromGitHub {
    owner = "foundry-rs";
    repo = "foundry";
    rev = "4665d7ce4b3b572163cc04b33b4fd190e28f2c5f";
    sha256 = "sha256-3slqb0MR0vHsC9ILHLWY+dc7a7MFfACePO3+OwPVLFM=";
  };
  cargoLock = {
    lockFile = ./Cargo.lock;
    # Allow dependencies to be fetched from git and avoid having to set the outputHashes manually
    #allowBuiltinFetchGit = true;
    outputHashes = {
      "c-kzg-0.1.0" = "sha256-a0ZkshWGzChNibsKBBq8HhOtjRYgAuNlSTinZoAFDkY=";
      "ethers-2.0.10" = "sha256-oC38WzFOXa+gA3bMCmCnpL7WzN+DG5QFOZEJtxPkNZc=";
      "ethers-core-2.0.10" = "sha256-0bgPD4aYDiMnVmqaGALfqptDhQ9r3u7txeXNSiqeozI=";
      "ethers-etherscan-2.0.10" = "sha256-0bgPD4aYDiMnVmqaGALfqptDhQ9r3u7txeXNSiqeozI=";
      "ethers-addressbook-2.0.10" = "sha256-0bgPD4aYDiMnVmqaGALfqptDhQ9r3u7txeXNSiqeozI=";
      "ethers-contract-2.0.10" = "sha256-0bgPD4aYDiMnVmqaGALfqptDhQ9r3u7txeXNSiqeozI=";
      "ethers-contract-derive-2.0.10" = "sha256-0bgPD4aYDiMnVmqaGALfqptDhQ9r3u7txeXNSiqeozI=";
      "ethers-contract-abigen-2.0.10" = "sha256-0bgPD4aYDiMnVmqaGALfqptDhQ9r3u7txeXNSiqeozI=";
      "ethers-middleware-2.0.10" = "sha256-0bgPD4aYDiMnVmqaGALfqptDhQ9r3u7txeXNSiqeozI=";
      "ethers-providers-2.0.10" = "sha256-0bgPD4aYDiMnVmqaGALfqptDhQ9r3u7txeXNSiqeozI=";
      "ethers-signers-2.0.10" = "sha256-0bgPD4aYDiMnVmqaGALfqptDhQ9r3u7txeXNSiqeozI=";
      "ethers-solc-2.0.10" = "sha256-0bgPD4aYDiMnVmqaGALfqptDhQ9r3u7txeXNSiqeozI=";
      "revm-3.3.0" = "sha256-Ljk72rk60YLVKLzANrKiG4c/IgaDEGqRO9nYec1bgaI=";
      "revm-interpreter-1.1.2" = "sha256-0bgPD4aYDiMnVmqaGALfqptDhQ9r3u7txeXNSiqeozI=";
    };
  };
  installPhase = ''
    cargo install --path ./crates/forge --profile local --force --locked
    cargo install --path ./crates/cast --profile local --force --locked
    cargo install --path ./crates/anvil --profile local --force --locked
    cargo install --path ./crates/chisel --profile local --force --locked
  '';

  #cargoSha256 = lib.fakeHash;
  cargoHash = "sha256-l1vL2ZdtDRxSGvP0X/l3nMw8+6WF67KPutJEzUROjg8=";

  meta = with lib; {
    description = "Foundry is a blazing fast, portable and modular toolkit for Ethereum application development";
    homepage = "https://getfoundry.sh/";
    downloadPage = "https://github.com/foundry-rs/foundry/releases";
    license = licenses.asl20;
    maintainers = [ maintainers.nook ];
  };
}
