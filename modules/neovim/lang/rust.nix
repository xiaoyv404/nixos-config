{
  plugins.rustaceanvim = {
    enable = true;
    rustAnalyzerPackage = null;
    lazyLoad = {
      enable = true;
      settings.ft = "rust";
    };
  };
}
