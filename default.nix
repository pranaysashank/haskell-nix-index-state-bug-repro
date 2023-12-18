let

  # Read in the Niv sources
  sources = import ./nix/sources.nix { };

  # Fetch the haskell.nix commit we have pinned with Niv
  haskellNix = import sources.haskellNix {
  };

  # Import nixpkgs and pass the haskell.nix provided nixpkgsArgs
  pkgs = import
    haskellNix.sources.nixpkgs-unstable
    haskellNix.nixpkgsArgs;

  # Fetch the haskell.nix commit we have pinned with Niv
  haskellNixNew = import sources.haskellNix {
    sourcesOverride = {
      hackage = sources.hackageNix;
    };
  };

  pkgsNew = import
    haskellNixNew.sources.nixpkgs-unstable
    haskellNixNew.nixpkgsArgs;

in {
  fOld = pkgs.haskell-nix.tool "ghc981" "fourmolu" {
      version = "latest";
      index-state = "2023-12-15T23:46:08Z";
      # cabalProjectFreeze = readFileIfExists ./nix/fourmolu.project.freeze;
  };

  fNew =  pkgsNew.haskell-nix.tool "ghc981" "fourmolu" {
      version = "latest";
      index-state = "2023-12-15T23:46:08Z";
      # cabalProjectFreeze = readFileIfExists ./nix/fourmolu.project.freeze;
  };
}
