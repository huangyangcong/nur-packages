{ lib, pkgs, rustPlatform, fetchFromGitHub }:
rustPlatform.buildRustPackage rec {
  pname = "foundry";
  version = "";

  src = fetchFromGitHub {
    owner = "foundry-rs";
    repo = "foundry";
    rev = "4665d7ce4b3b572163cc04b33b4fd190e28f2c5f";
  };
  cargoLock = {
    lockFile = "${src}/Cargo.lock";
    outputHashes = {
      "c-kzg-0.1.0" = "sha256-0bgPD4aYDiMnVmqaGALfqptDhQ9r3u7txeXNSiqeozI=";
      "ethers-2.0.10" = "sha256-0bgPD4aYDiMnVmqaGALfqptDhQ9r3u7txeXNSiqeozI=";
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
      "revm-3.3.0" = "sha256-0bgPD4aYDiMnVmqaGALfqptDhQ9r3u7txeXNSiqeozI=";
      "revm-interpreter-1.1.2" = "sha256-0bgPD4aYDiMnVmqaGALfqptDhQ9r3u7txeXNSiqeozI=";
    };
  };
  installPhase = ''
    cargo install --path ./crates/forge --profile local --force --locked
    cargo install --path ./crates/cast --profile local --force --locked
    cargo install --path ./crates/anvil --profile local --force --locked
    cargo install --path ./crates/chisel --profile local --force --locked
  '';

  cargoSha256 = lib.fakeHash;
  meta = with lib; {
    description = "Foundry is a blazing fast, portable and modular toolkit for Ethereum application development";
    homepage = "https://getfoundry.sh/";
    downloadPage = "https://github.com/foundry-rs/foundry/releases";
    license = licenses.asl20;
    maintainers = [ maintainers.nook ];
  };
}
