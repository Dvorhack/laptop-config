# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/edcef689-d584-4d83-b5be-8121b63631da";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/BF0B-BB71";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/9af7317a-bbb0-45ea-afa1-f92336c1185f"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  
## Enable OpenGL
 # hardware.opengl = {
 #   enable = true;
 #   driSupport = true;
 #   driSupport32Bit = true;
 # };

 # # Load nvidia driver for Xorg and Wayland
# services.xserver.videoDrivers = ["nvidia"];

 # hardware.nvidia = {

 #   # Modesetting is required.
 #   modesetting.enable = true;

 #   # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
 #   powerManagement.enable = false;
 #   # Fine-grained power management. Turns off GPU when not in use.
 #   # Experimental and only works on modern Nvidia GPUs (Turing or newer).
 #   powerManagement.finegrained = false;

 #   # Use the NVidia open source kernel module (not to be confused with the
 #   # independent third-party "nouveau" open source driver).
 #   # Support is limited to the Turing and later architectures. Full list of 
 #   # supported GPUs is at: 
 #   # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
 #   # Only available from driver 515.43.04+
 #   # Do not disable this unless your GPU is unsupported or if you have a good reason to.
 #   open = true;

 #   # Enable the Nvidia settings menu,
 #       # accessible via `nvidia-settings`.
 #   nvidiaSettings = true;

 #   # Optionally, you may need to select the appropriate driver version for your specific GPU.
 #   package = config.boot.kernelPackages.nvidiaPackages.stable;
 # };
#hardware.nvidia.modesetting.enable = true;
#  hardware.nvidia.prime.sync.allowExternalGpu = true;
#  hardware.nvidia.prime.offload.enable = true;
#hardware.nvidia.prime = {
#  
#  amdgpuBusId = "PCI:1:0:0";
#  nvidiaBusId = "PCI:6:0:0";
#};

hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
