{ lib, pkgs, rustPlatform, fetchFromGitHub }:
rustPlatform.mkDerivation rec {
  pname = "foundry";
  version = "nightly-4665d7ce4b3b572163cc04b33b4fd190e28f2c5f";

  src = fetchFromGitHub {
    owner = "foundry-rs";
    repo = "foundry";
    rev = "${version}";
    sha256 = "sha256-yZpTj3MlWYDw3Se7ZwwvNnqB4XpdPVqHWY2hK18KIIU=";
  };

  meta = with lib; {
    description = "Foundry is a blazing fast, portable and modular toolkit for Ethereum application development";
    homepage = "https://getfoundry.sh/";
    downloadPage = "https://github.com/foundry-rs/foundry/releases";
    license = licenses.asl20;
    maintainers = [ maintainers.nook ];
  };
}
