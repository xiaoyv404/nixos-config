{
  inputs,
  outputs,
  ...
}: {
  self-defined-packages = final: _prev: {
    self-defined = final.callPackage ../packages {
      inherit inputs outputs;
      pkgs = final;
    };
  };
}
