{
  # Add your overlays here
  #
  # my-overlay = import ./my-overlay;

  rust-overlay = {
    url = "github:oxalica/rust-overlay";
    inputs.nixpkgs.follows = "nixpkgs";
  };
}
