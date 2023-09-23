{ pkgs, fetchFromGitHub }:
let
  inherit (pkgs) stdenv lib;

  bins = [ "forge" "cast" "anvil" "chisel" ];
  binsWithCompletions = [ "forge" "cast" "anvil" ];
in
stdenv.mkDerivation rec {
  pname = "foundry";
  version = "nightly-4665d7ce4b3b572163cc04b33b4fd190e28f2c5f";

  src = fetchFromGitHub {
    owner = "foundry-rs";
    repo = "foundry";
    rev = "${version}";
    sha256 = "sha256-yZpTj3MlWYDw3Se7ZwwvNnqB4XpdPVqHWY2hK18KIIU=";
  };

  nativeBuildInputs = with pkgs;
    [
      pkg-config
      openssl
      makeWrapper
      installShellFiles
    ]
    ++ lib.optionals stdenv.isLinux [
      autoPatchelfHook
    ];

  postPhases = [ "postAutoPatchelf" ];

  installPhase =
    let
      path = pkgs.lib.makeBinPath [ pkgs.git ];
    in
    ''
      set -e
      mkdir -p $out/bin
      ${lib.concatMapStringsSep "\n" (bin: ''
          install -m755 -D ${bin} $out/bin/${bin}
          wrapProgram $out/bin/${bin} --prefix PATH : "${path}"
        '')
        bins}
    '';

  # Adapation for https://github.com/NixOS/nixpkgs/pull/209870;
  # something similar will go upstream in nixpkgs for all
  # autoPatchelfHook users.  When it does, this can be dropped.
  preFixup = lib.optionalString (stdenv?cc.cc.libgcc) ''
    set -x
    addAutoPatchelfSearchPath ${stdenv.cc.cc.libgcc}/lib
  '';

  postAutoPatchelf = ''
    ${lib.concatMapStringsSep "\n" (bin: ''
        installShellCompletion --cmd ${bin} --bash <($out/bin/${bin} completions bash) --fish <($out/bin/${bin} completions fish) --zsh <($out/bin/${bin} completions zsh)
      '')
      binsWithCompletions}
  '';

  installCheckPhase = ''
    $out/bin/forge --version > /dev/null
    $out/bin/cast --version > /dev/null
    $out/bin/anvil --version > /dev/null
    $out/bin/chisel --version > /dev/null
  '';

  doInstallCheck = true;
}
