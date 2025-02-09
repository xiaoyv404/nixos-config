{
  lib,
  buildGoModule,
  fetchFromGitHub,
  ...
}:
buildGoModule rec {
  pname = "trzsz-go";
  version = "1.1.8";
  src = fetchFromGitHub {
    owner = "trzsz";
    repo = "trzsz-go";
    rev = "v${version}";
    sha256 = "sha256-g1fbgKTFS9aPAmnTeFYoymrDEoZ6BtzUhA2Z9SNYbsU=";
  };

  vendorHash = "sha256-AsrRHHBlzW5s/PtJSQ+hAgqUIYwDwoemQaerRV/QKX0=";
}
