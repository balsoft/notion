{ compiler ? "ghc8107" }:

let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {};

  inherit (pkgs.haskell.lib) dontCheck;

  baseHaskellPkgs = pkgs.haskell.packages.${compiler};

  myHaskellPackages = baseHaskellPkgs.override {
    overrides = hself: hsuper: {
      notion = hself.callCabal2nix "notion" (./.) {};
    };
  };

  shell = myHaskellPackages.shellFor {
    packages = p: with p; [
      notion
    ];

    buildInputs = with pkgs.haskellPackages; [
      cabal-install
      ghcid
      ormolu
      hlint
      pkgs.niv
      pkgs.nixpkgs-fmt
    ];

    libraryHaskellDepends = [
    ];

    exactDeps= true;
    withHoogle = false;
    
    shellHook = ''
      set -e
      hpack
      set +e
    '';
};

in
{ inherit pkgs;
  inherit shell;
  inherit myHaskellPackages;
  notion = myHaskellPackages.notion;
}
