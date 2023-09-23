{ lib, pkgs, rustPlatform, fetchFromGitHub }:
rustPlatform.buildRustPackage rec {
  pname = "foundry";
  version = "";

  src = fetchFromGitHub {
    owner = "foundry-rs";
    repo = "foundry";
    rev = "4665d7ce4b3b572163cc04b33b4fd190e28f2c5f";
    sha256 = "sha256-yZpTj3MlWYDw3Se7ZwwvNnqB4XpdPVqHWY2hK18KIIU=";
  };
  cargoLock = {
    lockFile = ./Cargo.lock;
    # Allow dependencies to be fetched from git and avoid having to set the outputHashes manually
    allowBuiltinFetchGit = true;
  };
  installPhase = ''
    cargo install --path ./crates/forge --profile local --force --locked
    cargo install --path ./crates/cast --profile local --force --locked
    cargo install --path ./crates/anvil --profile local --force --locked
    cargo install --path ./crates/chisel --profile local --force --locked
  '';

  cargoSha256 = "sha256-IfuEqo5z+K+XbDSFgDIycpOLiBeB9iCz/sj8i+lB8dw=";
  meta = with lib; {
    description = "Foundry is a blazing fast, portable and modular toolkit for Ethereum application development";
    homepage = "https://getfoundry.sh/";
    downloadPage = "https://github.com/foundry-rs/foundry/releases";
    license = licenses.asl20;
    maintainers = [ maintainers.nook ];
  };
}
