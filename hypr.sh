#!/bin/bash
# Hyprland Desktop Environment Setup Script
# Run this script to install and configure your custom Wayland desktop

set -e

echo "========================================="
echo "Hyprland Desktop Setup"
echo "========================================="
echo ""

# Check if running as root
if [ "$EUID" -eq 0 ]; then 
   echo "Please don't run this script as root"
   exit 1
fi

# Update system
echo "Updating system..."
sudo pacman -Syu --noconfirm

# Install core components
echo "Installing core components..."
sudo pacman -S --needed --noconfirm \
    hyprland \
    waybar \
    wofi \
    kitty \
    hyprlock \
    hypridle \
    hyprpaper \
    hyprpicker

# Install essential utilities
echo "Installing essential utilities..."
sudo pacman -S --needed --noconfirm \
    mako \
    grim \
    slurp \
    wl-clipboard \
    brightnessctl \
    playerctl \
    pavucontrol \
    network-manager-applet \
    blueman \
    thunar \
    polkit-gnome \
    xdg-desktop-portal-hyprland \
    qt5-wayland \
    qt6-wayland \
    pipewire \
    pipewire-pulse \
    pipewire-alsa \
    wireplumber \
    firefox

# Create config directories
echo "Creating config directories..."
mkdir -p ~/.config/{hypr,waybar,wofi,kitty,mako}

# Create Hyprland config
echo "Creating Hyprland configuration..."
cat > ~/.config/hypr/hyprland.conf << 'EOF'
# Hyprland Configuration

# Monitor configuration
monitor=,preferred,auto,1

# Execute at launch
exec-once = waybar
exec-once = mako
exec-once = hyprpaper
exec-once = hypridle
exec-once = /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
exec-once = nm-applet --indicator
exec-once = blueman-applet

# Environment variables
env = XCURSOR_SIZE,24
env = QT_QPA_PLATFORMTHEME,qt5ct
env = QT_QPA_PLATFORM,wayland
env = GDK_BACKEND,wayland,x11

# Input configuration
input {
    kb_layout = us
    kb_variant =
    kb_model =
    kb_options =
    kb_rules =
    follow_mouse = 1
    touchpad {
        natural_scroll = true
    }
    sensitivity = 0
}

# General settings
general {
    gaps_in = 5
    gaps_out = 10
    border_size = 2
    col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
    col.inactive_border = rgba(595959aa)
    layout = dwindle
    allow_tearing = false
}

# Decoration
decoration {
    rounding = 10
    blur {
        enabled = true
        size = 3
        passes = 1
        vibrancy = 0.1696
    }
    drop_shadow = true
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)
}

# Animations
animations {
    enabled = true
    bezier = myBezier, 0.05, 0.9, 0.1, 1.05
    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = border, 1, 10, default
    animation = borderangle, 1, 8, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default
}

# Layouts
dwindle {
    pseudotile = true
    preserve_split = true
}

master {
    new_status = master
}

# Gestures
gestures {
    workspace_swipe = true
}

# Misc settings
misc {
    force_default_wallpaper = 0
    disable_hyprland_logo = true
}

# Window rules
windowrulev2 = suppressevent maximize, class:.*

# Keybindings
$mainMod = SUPER

# Applications
bind = $mainMod, Return, exec, kitty
bind = $mainMod, Q, killactive,
bind = $mainMod, M, exit,
bind = $mainMod, E, exec, thunar
bind = $mainMod, V, togglefloating,
bind = $mainMod, D, exec, wofi --show drun
bind = $mainMod, P, pseudo,
bind = $mainMod, J, togglesplit,
bind = $mainMod, F, fullscreen,
bind = $mainMod, L, exec, hyprlock

# Screenshots
bind = , Print, exec, grim -g "$(slurp)" - | wl-copy
bind = SHIFT, Print, exec, grim - | wl-copy

# Move focus
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d

# Switch workspaces
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

# Move window to workspace
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Scroll through workspaces
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Move/resize windows
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

# Media keys
bind = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
bind = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
bind = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
bind = , XF86AudioPlay, exec, playerctl play-pause
bind = , XF86AudioNext, exec, playerctl next
bind = , XF86AudioPrev, exec, playerctl previous
bind = , XF86MonBrightnessUp, exec, brightnessctl set +5%
bind = , XF86MonBrightnessDown, exec, brightnessctl set 5%-
EOF

# Create Waybar config
echo "Creating Waybar configuration..."
cat > ~/.config/waybar/config << 'EOF'
{
    "layer": "top",
    "position": "top",
    "height": 30,
    "spacing": 4,
    "modules-left": ["hyprland/workspaces", "hyprland/window"],
    "modules-center": ["clock"],
    "modules-right": ["pulseaudio", "network", "cpu", "memory", "battery", "tray"],
    
    "hyprland/workspaces": {
        "disable-scroll": false,
        "all-outputs": true,
        "format": "{icon}",
        "format-icons": {
            "1": "1",
            "2": "2",
            "3": "3",
            "4": "4",
            "5": "5",
            "6": "6",
            "7": "7",
            "8": "8",
            "9": "9",
            "10": "10"
        }
    },
    
    "hyprland/window": {
        "format": "{}",
        "max-length": 50
    },
    
    "clock": {
        "format": "{:%H:%M - %a %d %b}",
        "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>"
    },
    
    "cpu": {
        "format": " {usage}%",
        "tooltip": false
    },
    
    "memory": {
        "format": " {}%"
    },
    
    "battery": {
        "states": {
            "warning": 30,
            "critical": 15
        },
        "format": "{icon} {capacity}%",
        "format-charging": " {capacity}%",
        "format-plugged": " {capacity}%",
        "format-icons": ["", "", "", "", ""]
    },
    
    "network": {
        "format-wifi": " {essid}",
        "format-ethernet": " {ipaddr}",
        "format-disconnected": "⚠ Disconnected",
        "tooltip-format": "{ifname}: {ipaddr}/{cidr}"
    },
    
    "pulseaudio": {
        "format": "{icon} {volume}%",
        "format-muted": " Muted",
        "format-icons": {
            "headphone": "",
            "default": ["", "", ""]
        },
        "on-click": "pavucontrol"
    },
    
    "tray": {
        "spacing": 10
    }
}
EOF

# Create Waybar styles
cat > ~/.config/waybar/style.css << 'EOF'
* {
    border: none;
    border-radius: 0;
    font-family: "JetBrainsMono Nerd Font", monospace;
    font-size: 13px;
    min-height: 0;
}

window#waybar {
    background: rgba(30, 30, 46, 0.9);
    color: #cdd6f4;
}

#workspaces button {
    padding: 0 10px;
    color: #cdd6f4;
    background: transparent;
}

#workspaces button.active {
    background: #89b4fa;
    color: #1e1e2e;
}

#workspaces button:hover {
    background: #45475a;
}

#clock,
#battery,
#cpu,
#memory,
#network,
#pulseaudio,
#tray,
#window {
    padding: 0 10px;
    margin: 0 3px;
    background: rgba(49, 50, 68, 0.8);
    border-radius: 5px;
}

#battery.charging {
    color: #a6e3a1;
}

#battery.warning:not(.charging) {
    color: #f9e2af;
}

#battery.critical:not(.charging) {
    color: #f38ba8;
}
EOF

# Create Wofi config
echo "Creating Wofi configuration..."
cat > ~/.config/wofi/config << 'EOF'
width=600
height=400
location=center
show=drun
prompt=Search...
filter_rate=100
allow_markup=true
no_actions=true
halign=fill
orientation=vertical
content_halign=fill
insensitive=true
allow_images=true
image_size=40
gtk_dark=true
EOF

# Create Wofi styles
cat > ~/.config/wofi/style.css << 'EOF'
window {
    margin: 0px;
    border: 2px solid #89b4fa;
    background-color: #1e1e2e;
    border-radius: 10px;
}

#input {
    margin: 5px;
    padding: 10px;
    border: none;
    color: #cdd6f4;
    background-color: #313244;
    border-radius: 5px;
}

#inner-box {
    margin: 5px;
    border: none;
    background-color: #1e1e2e;
}

#outer-box {
    margin: 5px;
    border: none;
    background-color: #1e1e2e;
}

#scroll {
    margin: 0px;
    border: none;
}

#text {
    margin: 5px;
    border: none;
    color: #cdd6f4;
}

#entry:selected {
    background-color: #89b4fa;
    color: #1e1e2e;
}

#entry:selected #text {
    color: #1e1e2e;
}
EOF

# Create Kitty config
echo "Creating Kitty configuration..."
cat > ~/.config/kitty/kitty.conf << 'EOF'
# Font configuration
font_family      JetBrainsMono Nerd Font
bold_font        auto
italic_font      auto
bold_italic_font auto
font_size 11.0

# Cursor
cursor_shape beam
cursor_beam_thickness 1.5

# Scrollback
scrollback_lines 10000

# Mouse
mouse_hide_wait 3.0
url_style curly
detect_urls yes

# Performance
repaint_delay 10
input_delay 3
sync_to_monitor yes

# Window layout
remember_window_size  yes
initial_window_width  640
initial_window_height 400
window_padding_width 10

# Tab bar
tab_bar_edge bottom
tab_bar_style powerline

# Color scheme (Catppuccin Mocha)
foreground              #CDD6F4
background              #1E1E2E
selection_foreground    #1E1E2E
selection_background    #F5E0DC

# Cursor colors
cursor                  #F5E0DC
cursor_text_color       #1E1E2E

# URL underline color when hovering
url_color               #F5E0DC

# Kitty window border colors
active_border_color     #B4BEFE
inactive_border_color   #6C7086
bell_border_color       #F9E2AF

# Tab bar colors
active_tab_foreground   #11111B
active_tab_background   #CBA6F7
inactive_tab_foreground #CDD6F4
inactive_tab_background #181825
tab_bar_background      #11111B

# Colors for marks
mark1_foreground #1E1E2E
mark1_background #B4BEFE
mark2_foreground #1E1E2E
mark2_background #CBA6F7
mark3_foreground #1E1E2E
mark3_background #74C7EC

# The 16 terminal colors
# black
color0 #45475A
color8 #585B70

# red
color1 #F38BA8
color9 #F38BA8

# green
color2  #A6E3A1
color10 #A6E3A1

# yellow
color3  #F9E2AF
color11 #F9E2AF

# blue
color4  #89B4FA
color12 #89B4FA

# magenta
color5  #F5C2E7
color13 #F5C2E7

# cyan
color6  #94E2D5
color14 #94E2D5

# white
color7  #BAC2DE
color15 #A6ADC8
EOF

# Create Hyprlock config
echo "Creating Hyprlock configuration..."
cat > ~/.config/hypr/hyprlock.conf << 'EOF'
background {
    monitor =
    path = screenshot
    blur_passes = 3
    blur_size = 8
}

input-field {
    monitor =
    size = 300, 50
    outline_thickness = 3
    dots_size = 0.2
    dots_spacing = 0.35
    dots_center = true
    outer_color = rgba(89, 182, 250, 1)
    inner_color = rgba(30, 30, 46, 1)
    font_color = rgba(205, 214, 244, 1)
    fade_on_empty = false
    placeholder_text = <span foreground="##cdd6f4">Password...</span>
    hide_input = false
    position = 0, -200
    halign = center
    valign = center
}

label {
    monitor =
    text = cmd[update:1000] echo "$(date +'%H:%M')"
    color = rgba(205, 214, 244, 1)
    font_size = 120
    font_family = JetBrains Mono
    position = 0, 300
    halign = center
    valign = center
}

label {
    monitor =
    text = cmd[update:1000] echo "$(date +'%A, %B %d')"
    color = rgba(205, 214, 244, 1)
    font_size = 25
    font_family = JetBrains Mono
    position = 0, 200
    halign = center
    valign = center
}

label {
    monitor =
    text = $USER
    color = rgba(205, 214, 244, 1)
    font_size = 18
    font_family = JetBrains Mono
    position = 0, -250
    halign = center
    valign = center
}
EOF

# Create Hypridle config
echo "Creating Hypridle configuration..."
cat > ~/.config/hypr/hypridle.conf << 'EOF'
general {
    lock_cmd = pidof hyprlock || hyprlock
    before_sleep_cmd = loginctl lock-session
    after_sleep_cmd = hyprctl dispatch dpms on
}

listener {
    timeout = 300
    on-timeout = brightnessctl -s set 10
    on-resume = brightnessctl -r
}

listener {
    timeout = 600
    on-timeout = loginctl lock-session
}

listener {
    timeout = 900
    on-timeout = hyprctl dispatch dpms off
    on-resume = hyprctl dispatch dpms on
}
EOF

# Create Hyprpaper config
echo "Creating Hyprpaper configuration..."
cat > ~/.config/hypr/hyprpaper.conf << 'EOF'
preload = ~/.config/hypr/wallpaper.jpg
wallpaper = ,~/.config/hypr/wallpaper.jpg
splash = false
EOF

# Create Mako config
echo "Creating Mako configuration..."
cat > ~/.config/mako/config << 'EOF'
font=JetBrainsMono Nerd Font 10
background-color=#1e1e2e
text-color=#cdd6f4
border-color=#89b4fa
border-size=2
border-radius=10
width=300
height=100
margin=10
padding=15
default-timeout=5000
ignore-timeout=0

[urgency=high]
border-color=#f38ba8
default-timeout=0
EOF

# Download a default wallpaper
echo "Downloading default wallpaper..."
mkdir -p ~/.config/hypr
curl -L "https://images.unsplash.com/photo-1557683316-973673baf926" -o ~/.config/hypr/wallpaper.jpg 2>/dev/null || echo "Wallpaper download failed, please add your own to ~/.config/hypr/wallpaper.jpg"

# Add auto-start to shell profile
echo "Setting up auto-start..."
if [ -f ~/.bash_profile ]; then
    PROFILE=~/.bash_profile
elif [ -f ~/.zprofile ]; then
    PROFILE=~/.zprofile
else
    PROFILE=~/.bash_profile
fi

if ! grep -q "exec Hyprland" "$PROFILE" 2>/dev/null; then
    cat >> "$PROFILE" << 'EOF'

# Auto-start Hyprland on login to TTY1
if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  exec Hyprland
fi
EOF
fi

echo ""
echo "========================================="
echo "Setup Complete!"
echo "========================================="
echo ""
echo "Your Hyprland desktop is now configured."
echo ""
echo "To start Hyprland:"
echo "  1. Logout or reboot"
echo "  2. Login to TTY1"
echo "  3. Hyprland will start automatically"
echo ""
echo "Key Bindings:"
echo "  SUPER + Return        - Open terminal (Kitty)"
echo "  SUPER + D             - Application launcher (Wofi)"
echo "  SUPER + Q             - Close window"
echo "  SUPER + E             - File manager"
echo "  SUPER + L             - Lock screen"
echo "  SUPER + 1-10          - Switch workspace"
echo "  SUPER + SHIFT + 1-10  - Move window to workspace"
echo "  Print                 - Screenshot area"
echo "  SHIFT + Print         - Screenshot full screen"
echo ""
echo "Config locations:"
echo "  ~/.config/hypr/hyprland.conf"
echo "  ~/.config/waybar/"
echo "  ~/.config/wofi/"
echo "  ~/.config/kitty/kitty.conf"
echo ""
echo "Customize your wallpaper at:"
echo "  ~/.config/hypr/wallpaper.jpg"
echo ""
echo "Reboot to start using your new desktop!"
echo "========================================="
