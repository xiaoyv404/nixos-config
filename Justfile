switch target='.':
  sudo nixos-rebuild --flake {{target}} switch |& nom

debug target='.':
  sudo nixos-rebuild --flake {{target}} --show-trace -L -v switch |& nom

boot target='.':
  sudo nixos-rebuild --flake {{target}} boot |& nom

test target='.':
  sudo nixos-rebuild --flake {{target}} --show-trace -L -v dry-build |& nom
