{
  config,
  pkgs,
  self,
  ...
}: let
  # https://github.com/werman/noise-suppression-for-voice
  # https://discourse.nixos.org/t/pipewire-unable-to-set-filter-chain-via-configuration-nix/21972
  json = pkgs.formats.json {};
  pw_rnnoise_config = {
    "context.modules" = [
      {
        "name" = "libpipewire-module-filter-chain";
        "args" = {
          "node.description" = "Noise Canceling source";
          "media.name" = "Noise Canceling source";
          "filter.graph" = {
            "nodes" = [
              {
                "type" = "ladspa";
                "name" = "rnnoise";
                "plugin" = "${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so";
                "label" = "noise_suppressor_mono";
                "control" = {
                  "VAD Threshold (%)" = 50.0;
                  "VAD Grace Period (ms)" = 200;
                  "Retroactive VAD Grace (ms)" = 0;
                };
              }
            ];
          };
          "capture.props" = {
            "node.name" = "capture.rnnoise_source";
            "node.passive" = true;
            "audio.rate" = 48000;
          };
          "playback.props" = {
            "node.name" = "rnnoise_source";
            "media.class" = "Audio/Source";
            "audio.rate" = 48000;
          };
        };
      }
    ];
  };
in {
  # environment.etc."pipewire/pipewire.conf.d/99-input-denoising.conf" = {
  #   source = json.generate "99-input-denoising.conf" pw_rnnoise_config;
  # };
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

  environment.systemPackages = with pkgs; [
    pavucontrol
    pamixer
  ];
}
