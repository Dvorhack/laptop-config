# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices = {
      root.device = "/dev/disk/by-uuid/f574b3e3-8b6a-4dd0-86ed-f6d96c80bbdc";
  };
  boot.tmp.cleanOnBoot = true;
  security.pam.services.swaylock = {};
  networking.hostName = "nix-laptop"; # Define your hostname.
  # Pick only one of the below networking options.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     keyMap = "fr";
     # useXkbConfig = true; # use xkbOptions in tty.
   };

  
  programs.hyprland = {
    enable = true;
    nvidiaPatches = true;
    xwayland.enable = true;
  };
  environment.sessionVariables = {
    #GDK_FONT_SCALE = "1.2";
  };
  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

services.xserver = {
    enable = true;
    # videosDrivers = ["nvidia"];
    displayManager.gdm = {
        enable = true;
        wayland = true;
    };
layout = "fr";
};

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
   hardware.bluetooth.enable = true; 
  hardware.bluetooth.powerOnBoot = true;

  virtualisation.docker.enable = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dvorhack = {
    isNormalUser = true;
    extraGroups = [ "wheel" "sudo" "docker" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox
      tree
    ];
    shell = pkgs.zsh;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    asusctl
    discord
    docker
    rofi-wayland
    flameshot
    gcc
    git
    gdb
    gnumake
    patchelf
    (pwntools.override { debugger = pwndbg; })
    pwndbg
    (python3.withPackages(ps: with ps; [ pwntools requests pycryptodome ]))
    supergfxctl
    st
	swaylock-effects
    kitty
    vim neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    vscode
    waybar
    eww
    wget
    ropgadget
    xwaylandvideobridge
    zip unzip
    zsh
  ];


  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
      vim = "nvim";
      ccat = "pygmentize -g";
    };
    histSize = 10000;
      
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "history" ];
      theme = "gnzh";
    };
  
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services.supergfxd.enable = true;
  services.asusd.enable = true;
  services.asusd.enableUserService = true;
  services.blueman.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}

