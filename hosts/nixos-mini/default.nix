{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  modulesPath,
  ...
}: {
  imports = [
    # Include the default lxd configuration.
    "${modulesPath}/virtualisation/lxc-container.nix"
    outputs.modules.nixos.hosts.home
    outputs.modules.nixos.users.xiaoyv
    outputs.modules.nixvim

    ./orbstack.nix

    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = {
        inherit inputs outputs;
      };
      home-manager.users.xiaoyv = import ./home.nix;
    }
  ];

  # users.users.xiaoyv = {
  #   uid = 1001;
  #   isNormalUser = true;
  #   group = "users";
  #   homeMode = "700";
  # };
  # This being `true` leads to a few nasty bugs, change at your own risk!
  users.mutableUsers = false;

  networking = {
    hostName = "nixos-mini";
    dhcpcd.enable = false;
    useDHCP = false;
    useHostResolvConf = false;
  };
  systemd.network = {
    enable = true;
    networks."50-eth0" = {
      matchConfig.Name = "eth0";
      networkConfig = {
        DHCP = "ipv4";
        IPv6AcceptRA = true;
      };
      linkConfig.RequiredForOnline = "routable";
    };
  };

  # Extra certificates from OrbStack.
  security.pki.certificates = [
    ''
            -----BEGIN CERTIFICATE-----
      MIIDcjCCAlqgAwIBAgIQaaClzWfpAl8l4zX54Qn45TANBgkqhkiG9w0BAQsFADBM
      MSQwIgYDVQQKDBtTdXJnZSBHZW5lcmF0ZWQgQ0EgODY5OTVDNUYxJDAiBgNVBAMM
      G1N1cmdlIEdlbmVyYXRlZCBDQSA4Njk5NUM1RjAeFw0yMzA5MzAwMTUxMjRaFw0z
      MzA5MjcwMTUxMjRaMEwxJDAiBgNVBAoMG1N1cmdlIEdlbmVyYXRlZCBDQSA4Njk5
      NUM1RjEkMCIGA1UEAwwbU3VyZ2UgR2VuZXJhdGVkIENBIDg2OTk1QzVGMIIBIjAN
      BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA22A+lBvW/j6ZjQocpBmS9y0kYGsU
      Rx6YB8wuehYWP+HaflGT9uDVW8U408TocHZ3hzaFrBOxDPvBLJgrI9qFRXHsm+v6
      HKPmZBkXgyDORhdzAOq5s0upZXRbPlbDaQTs/bUAU3RThrOdzbDPxe+EO6u4LxUI
      +LUgCwTvMdIiRwfz47wwe+mPY7sVxp9xkIVlZyUJfB8KXWw9GQ4mGbzBOm/qMTEr
      wBrrNf7cFJjYem14A9cgua+XIzQxO6ztZjzsjCKjDcoTgJKahMOMZ6tjaN/oPGyo
      3WmatxICCcmOP1JQocgzIcnx4oe94BJt2cDi3HyyKcBPqcGAcSXzu7PnEwIDAQAB
      o1AwTjAdBgNVHQ4EFgQUPudQ8TNjXBRvruM9fzkVlZ90mY0wHwYDVR0jBBgwFoAU
      PudQ8TNjXBRvruM9fzkVlZ90mY0wDAYDVR0TBAUwAwEB/zANBgkqhkiG9w0BAQsF
      AAOCAQEAaxg1uLYrKu9avyfOnsahq9G9s6ognwk3fI1SiplS+uxdTCMc+bO+kRLz
      ImjXEj4EsJjHtsaKyhWtWHRTyDJN1c/O8x4BtHL9NHYvU+XO1eYSbwFwCQthpcND
      /zEivwTHHsb1IwuzvsGR9SM077mT5iLVKdqJE0yFXiJN6Qv7JRhmuyWEtQsolh6O
      xWMWTFQMDWYy+JN+JOLAztI7ZY4U9c0BoCCUt8hcfdEkSlGxd77phGR7no9z2GJT
      qLpa1lNKz1G6YeHIp5dHW/1eAoC7wJGHgqFMhaTuYeWzqU0MqHR4OC0Ina6FR12F
      wKw1n/Y4QRUzk6m5IBQOLkB6h59pZw==
      -----END CERTIFICATE-----

      -----BEGIN CERTIFICATE-----
      MIIDczCCAlugAwIBAgIRAMmCdAckhFKA6r9KEjVmFTkwDQYJKoZIhvcNAQELBQAw
      TDEkMCIGA1UECgwbU3VyZ2UgR2VuZXJhdGVkIENBIDhEMjBDQzAwMSQwIgYDVQQD
      DBtTdXJnZSBHZW5lcmF0ZWQgQ0EgOEQyMENDMDAwHhcNMjMxMDA4MTA1NjI3WhcN
      MzMxMDA1MTA1NjI3WjBMMSQwIgYDVQQKDBtTdXJnZSBHZW5lcmF0ZWQgQ0EgOEQy
      MENDMDAxJDAiBgNVBAMMG1N1cmdlIEdlbmVyYXRlZCBDQSA4RDIwQ0MwMDCCASIw
      DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMp2NNZhvAY64kIHf20Vnuc1SDNp
      VYwNcZWRTT6GWMUcCksvt4Per9mKCGGZiue51zUSSY+xRWDEH1R0mvWuuxaTQdea
      3u8coYPSMNDL7pYjKsOyhdidFxgJ8e1U59SNiRt1Yt5ttZO1Qb01Sl5xNeKhczft
      dX6BCe1spaCfNwZvRTaNRFb256eqwXTJEPSjxF6HUGnjteFYS54/TmD6/ZMJAxjK
      LE9HuCY2b6szwY4CZPS5fOa1HnH1C3ypU8YgR2eignlumKSsHBK0W0tJ1AovLqfW
      ZesYHPd1ERVKE5rW7vxFsPPC/O/npIKyRxq6Q0qtpl/9+9xmi2m+2XB8cesCAwEA
      AaNQME4wHQYDVR0OBBYEFIw08dC6CP+t9aMehBDmJXysvU1JMB8GA1UdIwQYMBaA
      FIw08dC6CP+t9aMehBDmJXysvU1JMAwGA1UdEwQFMAMBAf8wDQYJKoZIhvcNAQEL
      BQADggEBADe3WVYNCJ4XjUTEU/ZJMWFrdgYjccKVAsRq0EMKOHZ+pHB1ym7GYNcq
      qOXT5MhAjipsnbQfjE9jGsA4ZOrpm9EAODVSjArP5w7lXF3OuNm45OR8+WKdZbL/
      sgll66K5NPJX3ZqiJt/vLJHJdnHYGEFcJiwuNy2T6ZR4WA8B7AxrS8SXb8pQjY/9
      53a2zfhZE+rMJg7XLrDx+lzgv4aTdkfTNAu/R/7ZRZfefV6LODBN4AFLVvo+wke0
      68Q/XPa7U2L+rPeuJfBh1t51hIpLTxK4pEiKtTYzMI45J8grkHsJbhPt9lAPtJBY
      x5MpAAhp6Hj8w+EuVPMh1l/3PbCxb1g=
      -----END CERTIFICATE-----

      -----BEGIN CERTIFICATE-----
      MIICDDCCAbKgAwIBAgIQQFYOp+Fw62RHF7QvFN9y/jAKBggqhkjOPQQDAjBmMR0w
      GwYDVQQKExRPcmJTdGFjayBEZXZlbG9wbWVudDEeMBwGA1UECwwVQ29udGFpbmVy
      cyAmIFNlcnZpY2VzMSUwIwYDVQQDExxPcmJTdGFjayBEZXZlbG9wbWVudCBSb290
      IENBMB4XDTI1MDIxNTEyNTgyOFoXDTM1MDIxNTEyNTgyOFowZjEdMBsGA1UEChMU
      T3JiU3RhY2sgRGV2ZWxvcG1lbnQxHjAcBgNVBAsMFUNvbnRhaW5lcnMgJiBTZXJ2
      aWNlczElMCMGA1UEAxMcT3JiU3RhY2sgRGV2ZWxvcG1lbnQgUm9vdCBDQTBZMBMG
      ByqGSM49AgEGCCqGSM49AwEHA0IABH3gDcQjNT7mHOoYZ8s7Gl39qc6hYuAsvOfD
      //zLLDQ8efZSqJuf+iX4Lffac9eg3CBChk6OXBBWj0vM8kg88fajQjBAMA4GA1Ud
      DwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSmY+7xqONXBHvb
      2rwiQD5ydlfNmDAKBggqhkjOPQQDAgNIADBFAiBfbu/lihU5s2no8ZF/9hCoFqAz
      svyqomuNMZECG2WtFwIhAP5oHipPLzNOb9vAVO7xTH4r+fEsE9feFLDikPGkp4gA
      -----END CERTIFICATE-----

    ''
  ];
  system.stateVersion = "24.11";
}
