hostname := `hostname`

switch target=hostname:
  nh os switch --hostname {{hostname}} --ask .

debug target=hostname:
  nh os switch --hostname {{hostname}} --ask --verbose .

boot target=hostname:
  nh os boot --hostname {{hostname}} --ask .

test target='.':
  sudo nixos-rebuild --flake {{target}} --show-trace -L -v dry-build |& nom
