{
  lib,
  stdenv,
  fetchurl,
  electron,
  dpkg,
  makeWrapper,
}: let
  sources = import ./sources.nix;
  version = sources.version;
  srcs = {
    x86_64-linux = fetchurl {
      url = "https://github.com/Icalingua-plus-plus/Icalingua-plus-plus/releases/download/v${version}/icalingua_${version}_amd64.deb";
      hash = sources.x86_64-hash;
    };
    aarch64-linux = fetchurl {
      url = "https://github.com/Icalingua-plus-plus/Icalingua-plus-plus/releases/download/v${version}/icalingua_${version}_arm64.deb";
      hash = sources.arm64-hash;
    };
  };
  src =
    srcs.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
in
  stdenv.mkDerivation {
    pname = "icalingua-plus-plus";
    inherit src version;

    nativeBuildInputs = [
      makeWrapper
      dpkg
    ];

    installPhase = ''
      runHook preInstall

      mkdir -p $out/bin
      cp -r usr/share $out/share
      sed -i "s|Exec=.*|Exec=$out/bin/icalingua-plus-plus|" $out/share/applications/*.desktop
      cp -r opt/ $out/opt
      makeWrapper ${lib.getExe electron} $out/bin/icalingua-plus-plus \
        --argv0 "icalingua-plus-plus" \
        --add-flags "$out/opt/Icalingua++/resources/app.asar" \

      runHook postInstall
    '';

    # passthru.updateScript = ./update.sh;

    meta = with lib; {
      description = "A Linux client for QQ and more";
      homepage = "https://github.com/Icalingua-plus-plus/Icalingua-plus-plus";
      license = licenses.mit;
      maintainers = with maintainers; [];
      platforms = platforms.linux;
    };
  }
