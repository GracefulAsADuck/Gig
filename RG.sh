#!/bin/bash
# Hyprland Desktop Setup Script - RAVEN GUARD EDITION
# "Victorus aut Mortis" - Victory or Death
# Run this script to install and configure your custom Wayland desktop

set -e

echo "========================================="
echo "HYPRLAND DESKTOP - RAVEN GUARD CHAPTER"
echo "========================================="
echo ""

# Check if running as root
if [ "$EUID" -eq 0 ]; then 
   echo "Please don't run this script as root"
   exit 1
fi

# Update system
echo "Updating system protocols... Deploying from the shadows..."
sudo pacman -Syu --noconfirm

# Install core components
echo "Installing stealth components..."
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
echo "Deploying tactical equipment..."
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
    firefox \
    ttf-font-awesome

# Install fonts
echo "Installing tactical fonts..."
sudo pacman -S --needed --noconfirm \
    ttf-dejavu \
    ttf-liberation \
    noto-fonts \
    ttf-jetbrains-mono-nerd

# Create config directories
echo "Establishing shadow operations base..."
mkdir -p ~/.config/{hypr,waybar,wofi,kitty,mako}

# Create Hyprland config
echo "Inscribing Raven Guard battle protocols..."
cat > ~/.config/hypr/hyprland.conf << 'EOF'
# Hyprland Configuration - RAVEN GUARD EDITION
# "We are the shadows, we are death"

# Monitor configuration
monitor=,preferred,auto,1

# Execute at launch - Silent deployment
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

# General settings - Shadow black and raven grey theme
general {
    gaps_in = 4
    gaps_out = 8
    border_size = 2
    col.active_border = rgba(50505088) rgba(a0a0a0ff) 45deg  # Dark grey to light grey
    col.inactive_border = rgba(20202088)
    layout = dwindle
    allow_tearing = false
}

# Decoration - Stealth aesthetic
decoration {
    rounding = 6
    blur {
        enabled = true
        size = 6
        passes = 3
        vibrancy = 0.15
        noise = 0.02
    }
    drop_shadow = true
    shadow_range = 12
    shadow_render_power = 3
    col.shadow = rgba(00000099)
    col.shadow_inactive = rgba(00000055)
}

# Animations - Swift and silent like a raven
animations {
    enabled = true
    bezier = raven, 0.25, 0.1, 0.25, 1.0
    bezier = swoop, 0.68, -0.55, 0.265, 1.55
    bezier = silent, 0.33, 0, 0.67, 1
    animation = windows, 1, 5, silent, slide
    animation = windowsOut, 1, 4, raven, popin 85%
    animation = border, 1, 8, silent
    animation = borderangle, 1, 30, silent, loop
    animation = fade, 1, 5, silent
    animation = workspaces, 1, 4, raven, slidevert
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

# Keybindings - RAVEN GUARD TACTICS
$mainMod = SUPER

# Applications
bind = $mainMod, Return, exec, kitty
bind = $mainMod, Q, killactive,  # Silent elimination
bind = $mainMod, M, exit,  # Tactical withdrawal
bind = $mainMod, E, exec, thunar
bind = $mainMod, V, togglefloating,
bind = $mainMod, D, exec, wofi --show drun
bind = $mainMod, P, pseudo,
bind = $mainMod, J, togglesplit,
bind = $mainMod, F, fullscreen,
bind = $mainMod, L, exec, hyprlock  # Engage stealth protocols

# Screenshots - Reconnaissance capture
bind = , Print, exec, grim -g "$(slurp)" - | wl-copy
bind = SHIFT, Print, exec, grim - | wl-copy

# Move focus - Tactical repositioning
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d

# Switch workspaces - Shadow operations sectors
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

# Move window to workspace - Redeploy forces
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
echo "Configuring tactical display..."
cat > ~/.config/waybar/config << 'EOF'
{
    "layer": "top",
    "position": "top",
    "height": 28,
    "spacing": 6,
    "modules-left": ["hyprland/workspaces", "hyprland/window"],
    "modules-center": ["clock"],
    "modules-right": ["pulseaudio", "network", "cpu", "memory", "battery", "tray"],
    
    "hyprland/workspaces": {
        "disable-scroll": false,
        "all-outputs": true,
        "format": "{icon}",
        "format-icons": {
            "1": "🗡 I",
            "2": "🗡 II",
            "3": "🗡 III",
            "4": "🗡 IV",
            "5": "🗡 V",
            "6": "🗡 VI",
            "7": "🗡 VII",
            "8": "🗡 VIII",
            "9": "🗡 IX",
            "10": "🗡 X"
        },
        "persistent-workspaces": {
            "*": 10
        }
    },
    
    "hyprland/window": {
        "format": "◆ {}",
        "max-length": 50
    },
    
    "clock": {
        "format": "⧗ {:%H:%M | %d.%m.%Y}",
        "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
        "format-alt": "⧗ {:%A, %B %d, %Y}"
    },
    
    "cpu": {
        "format": "⚙ {usage}%",
        "tooltip": true,
        "interval": 2
    },
    
    "memory": {
        "format": "▣ {}%",
        "tooltip": true
    },
    
    "battery": {
        "states": {
            "warning": 30,
            "critical": 15
        },
        "format": "{icon} {capacity}%",
        "format-charging": "⚡ {capacity}%",
        "format-plugged": "⚡ {capacity}%",
        "format-icons": ["", "", "", "", ""]
    },
    
    "network": {
        "format-wifi": "📡 {essid}",
        "format-ethernet": "📡 Connected",
        "format-disconnected": "⚠ OFFLINE",
        "tooltip-format": "{ifname}: {ipaddr}/{cidr}"
    },
    
    "pulseaudio": {
        "format": "{icon} {volume}%",
        "format-muted": "🔇 MUTED",
        "format-icons": {
            "headphone": "🎧",
            "default": ["🔈", "🔉", "🔊"]
        },
        "on-click": "pavucontrol"
    },
    
    "tray": {
        "spacing": 10
    }
}
EOF

# Create Waybar styles - Raven Guard stealth theme
cat > ~/.config/waybar/style.css << 'EOF'
* {
    border: none;
    border-radius: 0;
    font-family: "JetBrainsMono Nerd Font", "DejaVu Sans", monospace;
    font-size: 12px;
    font-weight: 500;
    min-height: 0;
}

window#waybar {
    background: linear-gradient(to bottom, #0d0d0d 0%, #1a1a1a 100%);
    color: #a0a0a0;
    border-bottom: 2px solid #404040;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.7);
}

#workspaces button {
    padding: 0 10px;
    color: #707070;
    background: transparent;
    border: 1px solid transparent;
    transition: all 0.25s ease;
}

#workspaces button.active {
    background: linear-gradient(135deg, #505050 0%, #606060 100%);
    color: #e0e0e0;
    border: 1px solid #707070;
    box-shadow: 0 0 8px rgba(96, 96, 96, 0.4);
}

#workspaces button:hover {
    background: rgba(80, 80, 80, 0.2);
    border: 1px solid #505050;
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
    margin: 3px 2px;
    background: linear-gradient(135deg, #151515 0%, #202020 100%);
    color: #a0a0a0;
    border: 1px solid #303030;
    border-radius: 2px;
}

#window {
    color: #808080;
    font-style: italic;
}

#clock {
    font-weight: 600;
    letter-spacing: 0.5px;
    background: linear-gradient(135deg, #1a1a1a 0%, #252525 100%);
    border-color: #404040;
    color: #b0b0b0;
}

#battery.charging {
    color: #70c070;
    animation: pulse 2s ease-in-out infinite;
}

#battery.warning:not(.charging) {
    color: #c0a050;
    border-color: #c0a050;
}

#battery.critical:not(.charging) {
    color: #c05050;
    border-color: #c05050;
    animation: blink 1s ease-in-out infinite;
}

#cpu {
    color: #8090b0;
}

#memory {
    color: #90a0c0;
}

#network {
    color: #7090a0;
}

#pulseaudio {
    color: #a08090;
}

@keyframes pulse {
    0%, 100% {
        opacity: 1;
    }
    50% {
        opacity: 0.6;
    }
}

@keyframes blink {
    0%, 100% {
        opacity: 1;
    }
    50% {
        opacity: 0.3;
    }
}

tooltip {
    background: #0d0d0d;
    border: 2px solid #404040;
    border-radius: 2px;
    color: #a0a0a0;
}

tooltip label {
    color: #a0a0a0;
}
EOF

# Create Wofi config
echo "Initializing stealth deployment interface..."
cat > ~/.config/wofi/config << 'EOF'
width=650
height=420
location=center
show=drun
prompt=🗡 DEPLOY FROM SHADOWS...
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

# Create Wofi styles - Raven Guard tactical interface
cat > ~/.config/wofi/style.css << 'EOF'
window {
    margin: 0px;
    border: 3px solid #505050;
    background-color: #0d0d0d;
    border-radius: 4px;
    box-shadow: 0 0 25px rgba(0, 0, 0, 0.9), inset 0 0 30px rgba(20, 20, 20, 0.5);
}

#input {
    margin: 6px;
    padding: 10px;
    border: 2px solid #404040;
    color: #a0a0a0;
    background: linear-gradient(to right, #101010 0%, #1a1a1a 100%);
    border-radius: 2px;
    font-weight: 500;
    font-size: 13px;
}

#input:focus {
    border-color: #606060;
    box-shadow: 0 0 8px rgba(80, 80, 80, 0.4);
}

#inner-box {
    margin: 6px;
    border: none;
    background-color: transparent;
}

#outer-box {
    margin: 0px;
    border: none;
    background: linear-gradient(to bottom, #0d0d0d 0%, #151515 100%);
}

#scroll {
    margin: 0px;
    border: none;
}

#text {
    margin: 4px;
    border: none;
    color: #909090;
    font-weight: normal;
}

#entry {
    border: 1px solid transparent;
    border-radius: 2px;
    padding: 6px;
    margin: 2px;
    transition: all 0.2s ease;
}

#entry:selected {
    background: linear-gradient(135deg, #404040 0%, #505050 100%);
    color: #e0e0e0;
    border: 1px solid #606060;
    box-shadow: 0 0 10px rgba(80, 80, 80, 0.5);
}

#entry:selected #text {
    color: #e0e0e0;
    font-weight: 600;
}

#entry:hover {
    background: rgba(60, 60, 60, 0.15);
    border: 1px solid #404040;
}
EOF

# Create Kitty config - Raven Guard Terminal
echo "Configuring tactical terminal..."
cat > ~/.config/kitty/kitty.conf << 'EOF'
# Kitty Terminal - RAVEN GUARD EDITION
# "Swift and Silent"

# Font configuration
font_family      JetBrainsMono Nerd Font
bold_font        JetBrainsMono Nerd Font Bold
italic_font      JetBrainsMono Nerd Font Italic
bold_italic_font JetBrainsMono Nerd Font Bold Italic
font_size 11.0

# Cursor - Swift strike
cursor_shape beam
cursor_beam_thickness 1.8
cursor_blink_interval 0.5

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

# Window layout - Stealth aesthetic
remember_window_size  yes
initial_window_width  850
initial_window_height 500
window_padding_width 10
window_border_width 2pt

# Tab bar
tab_bar_edge bottom
tab_bar_style powerline
tab_powerline_style slanted

# RAVEN GUARD Color Scheme - Shadow Operations
# Background: Deep shadow black
foreground              #a0a0a0
background              #0d0d0d
selection_foreground    #e0e0e0
selection_background    #404040

# Cursor colors - Grey steel
cursor                  #707070
cursor_text_color       #0d0d0d

# URL underline color
url_color               #606060

# Window border colors
active_border_color     #505050
inactive_border_color   #252525
bell_border_color       #606060

# Tab bar colors - Shadow grey
active_tab_foreground   #e0e0e0
active_tab_background   #404040
inactive_tab_foreground #606060
inactive_tab_background #1a1a1a
tab_bar_background      #0a0a0a

# The 16 terminal colors - Stealth Palette

# black - Deep shadows
color0 #0d0d0d
color8 #404040

# red - Tactical red
color1 #804040
color9 #a05050

# green - Stealth green
color2  #406040
color10 #508050

# yellow - Warning amber
color3  #808040
color11 #a0a050

# blue - Night blue
color4  #405080
color12 #5060a0

# magenta - Tactical purple
color5  #604080
color13 #7050a0

# cyan - Recon cyan
color6  #406080
color14 #5080a0

# white - Smoke grey to light grey
color7  #808080
color15 #c0c0c0

# Background opacity for stealth
background_opacity 0.92

# Window decorations
window_margin_width 0
window_padding_width 8
EOF

# Create Hyprlock config - Shadow Defense
echo "Establishing shadow defense protocols..."
cat > ~/.config/hypr/hyprlock.conf << 'EOF'
# Hyprlock - RAVEN GUARD SHADOW PROTOCOLS
# "Victorus aut Mortis"

background {
    monitor =
    path = screenshot
    blur_passes = 5
    blur_size = 12
    brightness = 0.3
    contrast = 1.3
}

# Tactical border
shape {
    monitor =
    size = 380, 380
    color = rgba(40, 40, 40, 0.1)
    rounding = 4
    border_size = 3
    border_color = rgba(80, 80, 80, 0.6)
    rotate = 0
    position = 0, 0
    halign = center
    valign = center
}

input-field {
    monitor =
    size = 340, 55
    outline_thickness = 3
    dots_size = 0.23
    dots_spacing = 0.3
    dots_center = true
    outer_color = rgba(80, 80, 80, 1)
    inner_color = rgba(13, 13, 13, 0.9)
    font_color = rgba(160, 160, 160, 1)
    fade_on_empty = false
    placeholder_text = <span foreground="##707070" weight="normal">◆ AUTHORIZATION CODE ◆</span>
    hide_input = false
    check_color = rgba(60, 60, 60, 1)
    fail_color = rgba(160, 80, 80, 1)
    fail_text = <span foreground="##a05050" weight="bold">⚠ ACCESS DENIED ⚠</span>
    position = 0, -140
    halign = center
    valign = center
}

# Raven symbol
label {
    monitor =
    text = 🗡
    color = rgba(112, 112, 112, 0.8)
    font_size = 90
    font_family = JetBrains Mono
    position = 0, 90
    halign = center
    valign = center
}

# Time display
label {
    monitor =
    text = cmd[update:1000] echo "⧗ $(date +'%H:%M') ⧗"
    color = rgba(160, 160, 160, 1)
    font_size = 72
    font_family = JetBrains Mono
    position = 0, 320
    halign = center
    valign = center
    shadow_passes = 2
    shadow_size = 3
    shadow_color = rgba(0, 0, 0, 0.8)
}

# Date display
label {
    monitor =
    text = cmd[update:60000] echo "$(date +'%A, %B %d, %Y' | tr '[:lower:]' '[:upper:]')"
    color = rgba(128, 128, 128, 1)
    font_size = 18
    font_family = JetBrains Mono
    position = 0, 235
    halign = center
    valign = center
}

# User identification
label {
    monitor =
    text = ◆ OPERATIVE: $USER ◆
    color = rgba(144, 144, 144, 1)
    font_size = 16
    font_family = JetBrains Mono
    position = 0, -215
    halign = center
    valign = center
}

# Chapter motto
label {
    monitor =
    text = VICTORUS AUT MORTIS
    color = rgba(96, 96, 96, 0.7)
    font_size = 14
    font_family = JetBrains Mono
    position = 0, -280
    halign = center
    valign = center
}
EOF

# Create Hypridle config
echo "Configuring stealth standby mode..."
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
echo "Preparing shadow imagery..."
cat > ~/.config/hypr/hyprpaper.conf << 'EOF'
preload = ~/.config/hypr/wallpaper.jpg
wallpaper = ,~/.config/hypr/wallpaper.jpg
splash = false
ipc = off
EOF

# Create Mako config - Shadow Notifications
echo "Configuring tactical notification system..."
cat > ~/.config/mako/config << 'EOF'
# Mako Notifications - Raven Guard Tactical System

font=JetBrainsMono Nerd Font 10
background-color=#0d0d0d
text-color=#a0a0a0
border-color=#404040
border-size=2
border-radius=3
width=340
height=110
margin=12
padding=12
default-timeout=5000
ignore-timeout=0
icon-path=/usr/share/icons/

[urgency=low]
border-color=#303030
text-color=#707070

[urgency=normal]
border-color=#505050
text-color=#a0a0a0

[urgency=high]
border-color=#806060
text-color=#c08080
default-timeout=0

[app-name=volume]
border-color=#607060

[app-name=brightness]
border-color=#808060
EOF

# Download a dark/stealth themed wallpaper
echo "Retrieving shadow operations imagery..."
mkdir -p ~/.config/hypr
# Using a dark atmospheric wallpaper
curl -L "https://images.unsplash.com/photo-1518709268805-4e9042af9f23" -o ~/.config/hypr/wallpaper.jpg 2>/dev/null || \
curl -L "https://images.unsplash.com/photo-1579546929518-9e396f3cc809" -o ~/.config/hypr/wallpaper.jpg 2>/dev/null || \
echo "Wallpaper download failed. Please add your own Raven Guard themed wallpaper to ~/.config/hypr/wallpaper.jpg"

# Add auto-start to shell profile
echo "Inscribing auto-deployment protocols..."
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
echo "  DEPLOYMENT COMPLETE - RAVEN GUARD"
echo "========================================="
echo ""
echo "Shadow operations base established."
echo "Your Hyprland tactical station is ready."
echo ""
echo "🗡 DEPLOYMENT PROTOCOLS 🗡"
echo "  1. Logout or reboot your system"
echo "  2. Login to TTY1"
echo "  3. Hyprland will deploy automatically"
echo ""
echo "🗡 TACTICAL COMMANDS 🗡"
echo "  SUPER + Return        - Deploy terminal"
echo "  SUPER + D             - Access operations menu"
echo "  SUPER + Q             - Eliminate target window"
echo "  SUPER + E             - Access data archives"
echo "  SUPER + L             - Engage stealth protocols"
echo "  SUPER + F             - Maximize viewport"
echo "  SUPER + 1-10          - Deploy to sector"
echo "  SUPER + SHIFT + 1-10  - Redeploy forces"
echo "  Print                 - Capture reconnaissance (area)"
echo "  SHIFT + Print         - Capture reconnaissance (full)"
echo ""
echo "🗡 TACTICAL CONFIGURATION 🗡"
echo "  ~/.config/hypr/hyprland.conf"
echo "  ~/.config/waybar/"
echo "  ~/.config/wofi/"
echo "  ~/.config/kitty/kitty.conf"
echo ""
echo "🗡 THEME SPECIFICATIONS 🗡"
echo "  Color Scheme: Shadow Black + Raven Grey"
echo "  Primary: #505050 (Steel Grey)"
echo "  Secondary: #a0a0a0 (Light Grey)"
echo "  Background: #0d0d0d (Deep Shadow)"
echo ""
echo "  Replace wallpaper at: ~/.config/hypr/wallpaper.jpg"
echo "  Recommended: Search for Raven Guard or stealth ops wallpapers"
echo ""
echo "VICTORUS AUT MORTIS"
echo "========================================="
echo ""
echo "Reboot to begin shadow operations!"
