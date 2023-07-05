final: prev: with final; {

  haskell = let
    hlib = final.haskell.lib;
    packageOverrides = lib.composeManyExtensions [
      (prev.haskell.packageOverrides or (_: _: {}))
      (hfinal: hprev: with haskell.lib; rec {
        batchnorm = hfinal.callCabal2nix "batchnorm" ./day4 {};
        conv = hfinal.callCabal2nix "conv" ./day5 {};
        bnn = hfinal.callCabal2nix "bnn" ./day6 {};
        rl = hfinal.callCabal2nix "bnn" ./day10 {};
        massiv-nn = hfinal.callCabal2nix "massiv-nn" ./massiv {};

        # https://github.com/mstksg/backprop/pull/22
        backprop = hfinal.callCabal2nix "backprop" (builtins.fetchGit {
          url = "https://github.com/idontgetoutmuch/backprop";
          rev = "96ba7d37a6f583a3e018b8dab50691bdfa482dc8";
        }) { };

        vinyl = hlib.overrideSrc hprev.vinyl {
          version = "1.4.3";
          src = pkgs.fetchFromGitHub {
            owner = "VinylRecords";
            repo = "Vinyl";
            rev = "v0.14.3";
            hash = "sha256-lfUNAHI8+A/0s1zeX9m5ttueIEPhzPlXkCodUwMhAYU=";
          };
        };

      })
  ];
  in prev.haskell // { inherit packageOverrides; };

}
