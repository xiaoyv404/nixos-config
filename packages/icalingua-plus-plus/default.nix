{
  lib,
  fetchFromGitHub,
  electron,
  pnpm_8,
  stdenv,
  nodejs,
}:
stdenv.mkDerivation rec {
  pname = "icalingua-plus-plus";
  version = "2.12.28";
  src = fetchFromGitHub {
    owner = "xiaoyv404";
    repo = "Icalingua-plus-plus";
    rev = "b9db13135ec6efc4748aa543113fdec9eefe9f93";
    hash = "sha256-VaNmfjTGSOJrX4mhhMAeEflmGVwJyijvdBXXA2/Wtf0=";
  };

  nativeBuildInputs = [
    electron
    pnpm_8.configHook
    nodejs
  ];

  pnpmWorkspaces = [""];
  pnpmDeps = pnpm_8.fetchDeps {
    inherit pname version src pnpmWorkspaces;
    hash = "sha256-h4foQGQOjQzNmw3IoX3IMU9Q5Sxv312s6z/r6j7mCTY=";
  };
  env = {
    ELECTRON_SKIP_BINARY_DOWNLOAD = 1;
  };

  buildPhase = ''
    runHook preBuild

    pnpm electron install-app-deps
    pnpm electron --dir -c.extraMetadata.version=${version}

    runHook postBuild
  '';

  meta = with lib; {
    description = "A Linux client for QQ and more";
    homepage = "https://github.com/Icalingua-plus-plus/Icalingua-plus-plus";
    license = licenses.mit;
    maintainers = with maintainers; [];
    platforms = platforms.linux;
  };
}
