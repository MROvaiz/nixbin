{
  config,
  pkgs,
  self,
  ...
}: {
  imports = [self.inputs.nixos-hardware.nixosModules.common-gpu-amd];
  services.vnstat.enable = true;
  services.hardware.openrgb.enable = true;
  # Enable Bluetooth.
  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
  hardware.pulseaudio.enable = false;

  # Video Drivers
  hardware = {
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        # intel-media-driver # LIBVA_DRIVER_NAME=iHD
        # vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        vaapiVdpau
        libvdpau-va-gl
        # intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        # intel-media-driver # LIBVA_DRIVER_NAME=iHD
        # vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };

  # Virtualisation for virt manager
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [virt-manager];

  security = {
    # allow wayland lockers to unlock the screen
    pam.services.swaylock.text = "auth include login";
  };
  services.xserver = {
    enable = true;
    libinput = {
      enable = true;

      # disabling mouse acceleration
      mouse = {
        accelProfile = "flat";
      };

      # disabling touchpad acceleration
      touchpad = {
        accelProfile = "flat";
      };
    };
  };
}
