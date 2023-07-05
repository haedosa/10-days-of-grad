{ pkgs }: with pkgs; let

in haskellPackages.shellFor {
  withHoogle = true;
  packages = p: with p; [
    batchnorm
    conv
    bnn
    rl
    massiv-nn
  ];
  buildInputs =
    (with haskellPackages;
    [ haskell-language-server
      ghcid
      threadscope
    ]) ++
    [
      cabal-install
    ];
}
