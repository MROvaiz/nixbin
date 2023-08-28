{
  config,
  pkgs,
  lib,
  osConfig,
  ...
}: {
  mainBar = {
    position = "top";
    layer = "top";
    height = 43;
    margin-top = 0;
    margin-bottom = 0;
    margin-left = 0;
    margin-right = 0;
    modules-left = [
      "custom/launcher"
      "hyprland/window"
      #"custom/playerctl"
      #"custom/playerlabel"
    ];
    modules-center = [
      "wlr/workspaces"
      # "cpu"
      # "memory"
      # "disk"
    ];
    modules-right = [
      "tray"
      "pulseaudio"
      "network"
      "clock"
      # "custom/randwall"
    ];
    clock = {
      format = "󱑍 {:%H:%M}";
      tooltip = "true";
      tooltip-format = ''
        <big>{:%Y %B}</big>
        <tt><small>{calendar}</small></tt>'';
      format-alt = " {:%d/%m}";
    };

    "hyprland/window" = {
      format = "{}";
      max-length = 10;
    };
    "wlr/workspaces" = {
      active-only = false;
      all-outputs = true;
      disable-scroll = false;
      on-scroll-up = "hyprctl dispatch workspace e-1";
      on-scroll-down = "hyprctl dispatch workspace e+1";
      format = "{icon}";
      on-click = "activate";
      format-icons = {
        urgent = "";
        active = "";
        default = "";
        sort-by-number = true;
      };
    };

    "custom/playerctl" = {
      format = "{icon}";
      return-type = "json";
      max-length = 64;
      exec = ''
        playerctl -a metadata --format '{"text": "{{artist}} - {{markup_escape(title)}}", "tooltip": "{{playerName}} : {{markup_escape(title)}}", "alt": "{{status}}", "class": "{{status}}"}' -F'';
      on-click-middle = "playerctl play-pause";
      on-click = "playerctl previous";
      on-click-right = "playerctl next";
      format-icons = {
        Playing = "<span foreground='#6791eb'>󰓇 </span>";
        Paused = "<span foreground='#cdd6f4'>󰓇 </span>";
      };
    };

    "custom/playerlabel" = {
      format = "<span>{}</span>";
      return-type = "json";
      max-length = 48;
      exec = ''
        playerctl -a metadata --format '{"text": "{{artist}} - {{markup_escape(title)}}", "tooltip": "{{playerName}} : {{markup_escape(title)}}", "alt": "{{status}}", "class": "{{status}}"}' -F'';
      on-click-middle = "playerctl play-pause";
      on-click = "playerctl previous";
      on-click-right = "playerctl next";
      format-icons = {
        Playing = "<span foreground='#6791eb'>󰓇 </span>";
        Paused = "<span foreground='#cdd6f4'>󰓇 </span>";
      };
    };

    battery = {
      states = {
        good = 95;
        warning = 30;
        critical = 15;
      };
      format = "{icon}  {capacity}%";
      format-charging = "{capacity}% ";
      format-plugged = "{capacity}% ";
      format-alt = "{icon} {time}";
      # "format-good"= "", // An empty format will hide the module
      # "format-full"= "";
      format-icons = ["" "" "" "" ""];
    };

    memory = {
      format = "󰍛 {}%";
      format-alt = "󰍛 {used}/{total} GiB";
      interval = 5;
    };

    cpu = {
      format = "󰻠 {usage}%";
      format-alt = "󰻠 {avg_frequency} GHz";
      interval = 5;
    };

    disk = {
      format = "󰋊 {}%";
      format-alt = "󰋊 {used}/{total} GiB";
      interval = 5;
      path = "/";
    };

    network = {
      interface = "wlo1";
      format = "{}";
      format-wifi = "󰤨";
      format-ethernet = "󰈀 {ifname}: Aesthetic";
      format-linked = "󰈀 {ifname} (No IP)";
      format-disconnected = "󰤭";
      format-alt = "󰈀 {ifname}: {ipaddr}/{cidr}";
      tooltip-format = "{essid}";
      on-click-right = "kitty nmtui";
    };

    tray = {
      icon-size = 16;
      spacing = 5;
    };

    backlight = {
      # "device"= "acpi_video1";
      format = "{icon} {percent}%";
      format-icons = ["" "" "" "" "" "" "" "" ""];
      #	"on-scroll-up"=;
      #	"on-scroll-down"=;
    };

    pulseaudio = {
      format = "{icon} {volume}%";
      format-muted = "󰝟";
      format-icons = {default = ["󰕿" "󰖀" "󱄠"];};
      on-click = "pamixer -t";
      on-click-right = "pavucontrol";
      on-scroll-up = "pamixer -i 5";
      on-scroll-down = "pamixer -d 5";
      scroll-step = 5;
    };
    "custom/randwall" = {
      format = "󰏘";
      on-click = "bash $HOME/.config/hypr/randwall.sh";
      on-click-right = "bash $HOME/.config/hypr/wall.sh";
    };
    "custom/launcher" = {
      format = "";
      on-click = "rofi -show drun";
      tooltip = "false";
    };

    "custom/wf-recorder" = {
      format = "{}";
      interval = "once";
      exec = "echo ''";
      tooltip = "false";
      exec-if = "pgrep 'wf-recorder'";
      on-click = "exec ./scripts/wlrecord.sh";
      signal = 8;
    };

    "custom/hyprpicker" = {
      format = "󰈋";
      on-click = "hyprpicker -a -f hex";
      on-click-right = "hyprpicker -a -f rgb";
    };
  };
}
