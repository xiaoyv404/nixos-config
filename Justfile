hostname := `hostname`
os_name := `uname -s`
platformSubcommand := if os_name == "Darwin" { "darwin" } else { "os" }

switch target=hostname:
  nh {{platformSubcommand}} switch --hostname {{hostname}} --ask .

debug target=hostname:
  nh {{platformSubcommand}} switch --hostname {{hostname}} --ask --verbose .

boot target=hostname:
  nh {{platformSubcommand}} boot --hostname {{hostname}} --ask .

test target='.':
  sudo nixos-rebuild --flake {{target}} --show-trace -L -v dry-build |& nom
