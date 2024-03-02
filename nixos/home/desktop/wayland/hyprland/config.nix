{
  config,
  pkgs,
  self,
  ...
}: let
  wallpaper = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/MROvaiz/wallpapers/main/earth-above.jpg";
    sha256 = "15z8imzgi68vy3fv70x3fkvsmm313rfgjmjvbzwi7mar3dcizqaa";
  };
  swww-script = pkgs.writeShellScript "swww-script" ''
    # have pre-start here itself
    ${pkgs.swww}/bin/swww init &

    # Start Service here
    ${pkgs.swww}/bin/swww img ${wallpaper}
  '';
in {
  wayland.windowManager.hyprland = {
    settings = {
      "$MOD" = "SUPER";
      "$MODSHIFT" = "$MOD SHIFT";
      "$MODALT" = "$MOD ALT";
      monitor = [
        ",preferred,auto,auto"
        "DP-1,2560x1440@144,0x0,1"
      ];
      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "blueman-applet & nm-applet --indicator"
        "waybar"
        swww-script
      ];
      xwayland = {force_zero_scaling = true;};
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        force_no_accel = 1;
        touchpad = {
          natural_scroll = 0;
        };
      };
      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        no_cursor_warps = true;
      };
      decoration = {
        rounding = 10;
        blur = {
          size = 3;
          passes = 1;
          new_optimizations = false;
          xray = true;
        };

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };
      animation = {
        bezier = [
          "myBezier, 0.05, 0.9, 0.1, 1.05"
        ];
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      master = {
        new_is_master = true;
      };
      gestures = {
        workspace_swipe = false;
      };
      bind = [
        # Apps binds
        "$MOD, Q, exec, kitty"
        "$MOD, C, killactive"
        "$MOD, M, exit"
        "$MOD, L, exec, swaylock -Ff"
        "$MOD, E, exec, thunar"
        "$MOD, V, togglefloating"
        "$MOD, SPACE, exec, rofi -show drun"
        "$MOD, P, pseudo"
        "$MOD, J, togglesplit"
        ''$MOD, S, exec, grim -g "$(slurp)" - | swappy -f -'' # take a screenshot

        # Move Focus
        "$MOD, left, movefocus, l"
        "$MOD, right, movefocus, r"
        "$MOD, up, movefocus, u"
        "$MOD, down, movefocus, d"

        # Switch Workspaces with MOD [0-9]
        "$MOD, 1, workspace, 1"
        "$MOD, 2, workspace, 2"
        "$MOD, 3, workspace, 3"
        "$MOD, 4, workspace, 4"
        "$MOD, 5, workspace, 5"
        "$MOD, 6, workspace, 6"
        "$MOD, 7, workspace, 7"
        "$MOD, 8, workspace, 8"
        "$MOD, 9, workspace, 9"
        "$MOD, 0, workspace, 0"

        # Move to Active window to different workspace with MOD SHIFT [0-9]
        "$MODSHIFT, 1, movetoworkspace, 1"
        "$MODSHIFT, 2, movetoworkspace, 2"
        "$MODSHIFT, 3, movetoworkspace, 3"
        "$MODSHIFT, 4, movetoworkspace, 4"
        "$MODSHIFT, 5, movetoworkspace, 5"
        "$MODSHIFT, 6, movetoworkspace, 6"
        "$MODSHIFT, 7, movetoworkspace, 7"
        "$MODSHIFT, 8, movetoworkspace, 8"
        "$MODSHIFT, 9, movetoworkspace, 9"
        "$MODSHIFT, 0, movetoworkspace, 10"

        # Scroll through existing workspaces with MOD + scroll
        "$MOD, mouse_down, workspace, e+1"
        "$MOD, mouse_up, workspace, e-1"

        # Move through existing workspaces
        "$MODALT, right, workspace, e+1"
        "$MODALT, left, workspace, e-1"
      ];
      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$MOD, mouse:272, movewindow"
        "$MOD, mouse:273, resizewindow"
      ];
      # Example windowrule v1
      windowrule = [
        "float,^(pavucontrol)$"
        "float,^(blueman-manager)$"
        "float,^(lutris)$"
        "float,^(nm-connection-editor)$"
      ];
      # Example windowrule v2
      windowrulev2 = [
        # Steam Window rules
        "float,class:^(steam)$,title:^(Steam)$"
        "size 75% 75%,class:^(steam)$,title:^(Steam)$"
        "center,class:^(steam)$,title:^(Steam)$"
        "float,class:^(steam)$,title:^(Friends List)$"
        "size 20% 75%,class:^(steam)$,title:^(Friends List)$"
        "center,class:^(steam)$,title:^(Friends List)$"

        # Virt Manager Window rules
        "float,class:^(virt-manager)$,title:^(Virtual Machine Manager)$"
        "size 75% 75%,class:^(virt-manager)$,title:^(Virtual Machine Manager)$"
        "center,class:^(virt-manager)$,title:^(Virtual Machine Manager)$"

        # Lutris Window rules
        "float,class:^(lutris)$,title:^(lutris)$"
        "nomaxsize,class:^(dxwsetup.exe)$"

        # Kitty Window rules
        "opacity 0.8 0.8,class:^(kitty)$"
        "animation popin,class:^(kitty)$,title:^(update-sys)$"

        # Thunar Window rules
        "animation popin,class:^(thunar)$"
        "opacity 0.8 0.8,class:^(thunar)$"
        "float,class:^(thunar)$,title:^(File Operation Progress)$"
        "pin,class:^(thunar)$,title:^(File Operation Progress)$"
        "move 68.33% 88%,class:^(thunar)$,title:^(File Operation Progress)$"
        "float,class:^(thunar)$,title:^(Confirm to replace files)$"

        # Firefox Window rules
        "float,class:^(firefox)$,title:^(Firefox — Sharing Indicator)$"
        "float,class:^(firefox)$,title:^(Sign in – Google accounts — Mozilla Firefox)$"
        "center,class:^(firefox)$,title:^(Sign in – Google accounts — Mozilla Firefox)$"
        "move 38% 0.5%,class:^(firefox)$,title:^(Firefox — Sharing Indicator)$"

        # Utility
        "float,class:^(.blueman-manager-wrapped)$,title:^(Bluetooth Devices)$"
        "size 25% 25%,class:^(.blueman-manager-wrapped)$,title:^(Bluetooth Devices)$"
        "float,class:^(openrgb)$,title:^(OpenRGB)$"
      ];
    };
  };
}
