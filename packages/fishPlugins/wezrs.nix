{ buildFishPlugin }:
buildFishPlugin {
  pname = "wezrs";
  version = "0.1.0";
  src = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/expnn/wezrs/a7ccaf55715fe15ba5f0a12c9f53ead05cf58057/deps/wezrs.fish";
    sha256 = "sha256:0azz4wgbgrllnam58m2cv0p4gbfyq176p8k372jk9xvzaagq6zqa";
  };

  unpackPhase = ":"; # dontUnpack
  buildPhase = ''
    mkdir -p $out/conf.d
    cp $src $out/conf.d/wezrz.fish
  '';
}
