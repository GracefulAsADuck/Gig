#!/bin/bash
# Hyprland Desktop Setup Script - WARHAMMER 40K EDITION
# "The Emperor Protects"
# Run this script to install and configure your custom Wayland desktop

set -e

echo "========================================="
echo "HYPRLAND DESKTOP SETUP - FOR THE EMPEROR"
echo "========================================="
echo ""

# Check if running as root
if [ "$EUID" -eq 0 ]; then 
   echo "Please don't run this script as root"
   exit 1
fi

# Update system
echo "Updating system protocols... The Omnissiah provides..."
sudo pacman -Syu --noconfirm

# Install core components
echo "Installing sacred components of the Machine Spirit..."
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
echo "Deploying support systems..."
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

# Install custom fonts for the theme
echo "Installing Gothic fonts..."
sudo pacman -S --needed --noconfirm \
    ttf-dejavu \
    ttf-liberation \
    noto-fonts \
    ttf-jetbrains-mono-nerd

# Create config directories
echo "Initializing sacred configuration archives..."
mkdir -p ~/.config/{hypr,waybar,wofi,kitty,mako}

# Create Hyprland config
echo "Inscribing Hyprland protocols..."
cat > ~/.config/hypr/hyprland.conf << 'EOF'
# Hyprland Configuration - WARHAMMER 40K EDITION
# "In the grim darkness of the far future, there is only productivity"

# Monitor configuration
monitor=,preferred,auto,1

# Execute at launch - Machine Spirit initialization
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

# General settings - Imperial Gold and Blood Red theme
general {
    gaps_in = 6
    gaps_out = 12
    border_size = 3
    col.active_border = rgba(d4af37ff) rgba(8b0000ff) 45deg  # Gold and Blood Red
    col.inactive_border = rgba(1a1a1aaa)
    layout = dwindle
    allow_tearing = false
}

# Decoration - Gothic Cathedral aesthetic
decoration {
    rounding = 8
    blur {
        enabled = true
        size = 5
        passes = 2
        vibrancy = 0.2
    }
    drop_shadow = true
    shadow_range = 8
    shadow_render_power = 4
    col.shadow = rgba(8b0000ee)  # Blood red shadow
    col.shadow_inactive = rgba(000000cc)
}

# Animations - Ominous and powerful
animations {
    enabled = true
    bezier = imperial, 0.25, 0.1, 0.25, 1.0
    bezier = warp, 0.87, 0, 0.13, 1
    animation = windows, 1, 6, imperial, slide
    animation = windowsOut, 1, 5, warp, popin 90%
    animation = border, 1, 8, imperial
    animation = borderangle, 1, 20, imperial, loop
    animation = fade, 1, 6, imperial
    animation = workspaces, 1, 5, imperial, slide
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

# Keybindings - FOR THE EMPEROR
$mainMod = SUPER

# Applications
bind = $mainMod, Return, exec, kitty
bind = $mainMod, Q, killactive,  # Purge the heretic window
bind = $mainMod, M, exit,  # Abandon post
bind = $mainMod, E, exec, thunar
bind = $mainMod, V, togglefloating,
bind = $mainMod, D, exec, wofi --show drun
bind = $mainMod, P, pseudo,
bind = $mainMod, J, togglesplit,
bind = $mainMod, F, fullscreen,
bind = $mainMod, L, exec, hyprlock  # Engage defense protocols

# Screenshots - Pict capture
bind = , Print, exec, grim -g "$(slurp)" - | wl-copy
bind = SHIFT, Print, exec, grim - | wl-copy

# Move focus - Navigate the battlefield
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d

# Switch workspaces - Deploy to sectors 1-10
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

# Move window to workspace - Relocate forces
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

# Media keys - Vox controls
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
echo "Configuring status cogitator array..."
cat > ~/.config/waybar/config << 'EOF'
{
    "layer": "top",
    "position": "top",
    "height": 32,
    "spacing": 8,
    "modules-left": ["hyprland/workspaces", "hyprland/window"],
    "modules-center": ["clock"],
    "modules-right": ["pulseaudio", "network", "cpu", "memory", "battery", "tray"],
    
    "hyprland/workspaces": {
        "disable-scroll": false,
        "all-outputs": true,
        "format": "{icon}",
        "format-icons": {
            "1": "⚔ I",
            "2": "⚔ II",
            "3": "⚔ III",
            "4": "⚔ IV",
            "5": "⚔ V",
            "6": "⚔ VI",
            "7": "⚔ VII",
            "8": "⚔ VIII",
            "9": "⚔ IX",
            "10": "⚔ X"
        },
        "persistent-workspaces": {
            "*": 10
        }
    },
    
    "hyprland/window": {
        "format": "◈ {}",
        "max-length": 50
    },
    
    "clock": {
        "format": "⧖ {:%H:%M | %d.%m.%Y}",
        "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
        "format-alt": "⧖ {:%A, %B %d, %Y}"
    },
    
    "cpu": {
        "format": "⚙ {usage}%",
        "tooltip": true,
        "interval": 2
    },
    
    "memory": {
        "format": "⛨ {}%",
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

# Create Waybar styles - Imperial Gothic theme
cat > ~/.config/waybar/style.css << 'EOF'
* {
    border: none;
    border-radius: 0;
    font-family: "JetBrainsMono Nerd Font", "DejaVu Sans", monospace;
    font-size: 13px;
    font-weight: bold;
    min-height: 0;
}

window#waybar {
    background: linear-gradient(to bottom, #0a0a0a 0%, #1a1a1a 100%);
    color: #d4af37;
    border-bottom: 3px solid #d4af37;
    box-shadow: 0 2px 10px rgba(139, 0, 0, 0.5);
}

#workspaces button {
    padding: 0 12px;
    color: #d4af37;
    background: transparent;
    border: 1px solid transparent;
    transition: all 0.3s ease;
}

#workspaces button.active {
    background: linear-gradient(135deg, #d4af37 0%, #b8941e 100%);
    color: #0a0a0a;
    border: 1px solid #8b0000;
    box-shadow: 0 0 10px rgba(212, 175, 55, 0.5);
}

#workspaces button:hover {
    background: rgba(212, 175, 55, 0.2);
    border: 1px solid #d4af37;
    box-shadow: 0 0 5px rgba(212, 175, 55, 0.3);
}

#clock,
#battery,
#cpu,
#memory,
#network,
#pulseaudio,
#tray,
#window {
    padding: 0 12px;
    margin: 4px 2px;
    background: linear-gradient(135deg, #1a0000 0%, #2a0a0a 100%);
    color: #d4af37;
    border: 1px solid #d4af37;
    border-radius: 0;
    box-shadow: inset 0 0 5px rgba(139, 0, 0, 0.3);
}

#window {
    color: #c0c0c0;
    font-style: italic;
}

#clock {
    font-weight: bold;
    letter-spacing: 1px;
    background: linear-gradient(135deg, #1a1a00 0%, #2a2a00 100%);
    border-color: #d4af37;
}

#battery.charging {
    color: #00ff00;
    animation: pulse 2s ease-in-out infinite;
}

#battery.warning:not(.charging) {
    color: #ffaa00;
    border-color: #ffaa00;
}

#battery.critical:not(.charging) {
    color: #ff0000;
    border-color: #ff0000;
    animation: blink 1s ease-in-out infinite;
}

#cpu {
    color: #ff6b35;
}

#memory {
    color: #4ecdc4;
}

#network {
    color: #95e1d3;
}

#pulseaudio {
    color: #f38181;
}

@keyframes pulse {
    0%, 100% {
        opacity: 1;
    }
    50% {
        opacity: 0.7;
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
    background: #0a0a0a;
    border: 2px solid #d4af37;
    border-radius: 0;
    color: #d4af37;
}

tooltip label {
    color: #d4af37;
}
EOF

# Create Wofi config
echo "Initializing application sanctum protocols..."
cat > ~/.config/wofi/config << 'EOF'
width=700
height=450
location=center
show=drun
prompt=⚔ DEPLOY COGITATOR PROGRAM...
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

# Create Wofi styles - Gothic Imperial launcher
cat > ~/.config/wofi/style.css << 'EOF'
window {
    margin: 0px;
    border: 4px solid #d4af37;
    background-color: #0a0a0a;
    border-radius: 0;
    box-shadow: 0 0 30px rgba(212, 175, 55, 0.6), inset 0 0 50px rgba(139, 0, 0, 0.3);
}

#input {
    margin: 8px;
    padding: 12px;
    border: 2px solid #d4af37;
    color: #d4af37;
    background: linear-gradient(to right, #1a0000 0%, #0a0a0a 100%);
    border-radius: 0;
    font-weight: bold;
    font-size: 14px;
    box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.5);
}

#input:focus {
    border-color: #8b0000;
    box-shadow: 0 0 10px rgba(212, 175, 55, 0.5), inset 0 2px 5px rgba(0, 0, 0, 0.5);
}

#inner-box {
    margin: 8px;
    border: none;
    background-color: transparent;
}

#outer-box {
    margin: 0px;
    border: none;
    background: linear-gradient(to bottom, #0a0a0a 0%, #1a0000 100%);
}

#scroll {
    margin: 0px;
    border: none;
}

#text {
    margin: 5px;
    border: none;
    color: #c0c0c0;
    font-weight: normal;
}

#entry {
    border: 1px solid transparent;
    border-radius: 0;
    padding: 8px;
    margin: 2px;
    transition: all 0.2s ease;
}

#entry:selected {
    background: linear-gradient(135deg, #d4af37 0%, #b8941e 100%);
    color: #0a0a0a;
    border: 1px solid #8b0000;
    box-shadow: 0 0 15px rgba(212, 175, 55, 0.7);
}

#entry:selected #text {
    color: #0a0a0a;
    font-weight: bold;
}

#entry:hover {
    background: rgba(212, 175, 55, 0.15);
    border: 1px solid #d4af37;
}
EOF

# Create Kitty config - Imperial Terminal
echo "Configuring command terminal protocols..."
cat > ~/.config/kitty/kitty.conf << 'EOF'
# Kitty Terminal - WARHAMMER 40K EDITION
# "Knowledge is power, guard it well"

# Font configuration
font_family      JetBrainsMono Nerd Font
bold_font        JetBrainsMono Nerd Font Bold
italic_font      JetBrainsMono Nerd Font Italic
bold_italic_font JetBrainsMono Nerd Font Bold Italic
font_size 11.0

# Cursor - Imperial Aquila style
cursor_shape beam
cursor_beam_thickness 2.0
cursor_blink_interval 0

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

# Window layout - Fortress monastery aesthetic
remember_window_size  yes
initial_window_width  900
initial_window_height 500
window_padding_width 12
window_border_width 2pt

# Tab bar - Chapter markings
tab_bar_edge bottom
tab_bar_style powerline
tab_powerline_style slanted

# WARHAMMER 40K Color Scheme - Imperial Gothic
# Background: Deep void black with red undertones
foreground              #d4af37
background              #0a0a0a
selection_foreground    #0a0a0a
selection_background    #d4af37

# Cursor colors - Imperial Gold
cursor                  #d4af37
cursor_text_color       #0a0a0a

# URL underline color - Blood Red
url_color               #8b0000

# Window border colors - Gold and Blood
active_border_color     #d4af37
inactive_border_color   #3a3a3a
bell_border_color       #8b0000

# Tab bar colors - Imperial Heraldry
active_tab_foreground   #0a0a0a
active_tab_background   #d4af37
inactive_tab_foreground #808080
inactive_tab_background #1a1a1a
tab_bar_background      #000000

# The 16 terminal colors - Imperial Palette

# black - Void black and ash grey
color0 #0a0a0a
color8 #404040

# red - Blood red and bright crimson
color1 #8b0000
color9 #ff0000

# green - Toxic green and Necron glow
color2  #2d5016
color10 #4a7c2e

# yellow - Imperial gold and warning amber
color3  #d4af37
color11 #ffd700

# blue - Warp blue and psychic cyan
color4  #1e3a8a
color12 #3b82f6

# magenta - Purple chaos and bright magenta
color5  #6b21a8
color13 #a855f7

# cyan - Tech cyan and bright aqua
color6  #0e7490
color14 #06b6d4

# white - Parchment and bright white
color7  #c0c0c0
color15 #ffffff

# Background opacity for Gothic effect
background_opacity 0.95

# Window decorations
window_margin_width 0
window_padding_width 8
EOF

# Create Hyprlock config - Fortress Defense Screen
echo "Establishing security sanctum protocols..."
cat > ~/.config/hypr/hyprlock.conf << 'EOF'
# Hyprlock - IMPERIAL DEFENSE PROTOCOLS
# "The Emperor Protects"

background {
    monitor =
    path = screenshot
    blur_passes = 4
    blur_size = 10
    brightness = 0.4
    contrast = 1.2
}

# Gothic border decoration
shape {
    monitor =
    size = 400, 400
    color = rgba(212, 175, 55, 0.1)
    rounding = 0
    border_size = 4
    border_color = rgba(212, 175, 55, 0.8)
    rotate = 0
    position = 0, 0
    halign = center
    valign = center
}

input-field {
    monitor =
    size = 350, 60
    outline_thickness = 4
    dots_size = 0.25
    dots_spacing = 0.3
    dots_center = true
    outer_color = rgba(212, 175, 55, 1)
    inner_color = rgba(10, 10, 10, 0.9)
    font_color = rgba(212, 175, 55, 1)
    fade_on_empty = false
    placeholder_text = <span foreground="##d4af37" weight="bold">◈ ENTER AUTHORIZATION ◈</span>
    hide_input = false
    check_color = rgba(139, 0, 0, 1)
    fail_color = rgba(255, 0, 0, 1)
    fail_text = <span foreground="##ff0000" weight="bold">⚠ ACCESS DENIED ⚠</span>
    position = 0, -150
    halign = center
    valign = center
}

# Imperial Aquila symbol (using text)
label {
    monitor =
    text = ⚔
    color = rgba(212, 175, 55, 0.9)
    font_size = 100
    font_family = JetBrains Mono
    position = 0, 100
    halign = center
    valign = center
}

# Time display - Chronometer
label {
    monitor =
    text = cmd[update:1000] echo "⧖ $(date +'%H:%M') ⧖"
    color = rgba(212, 175, 55, 1)
    font_size = 80
    font_family = JetBrains Mono
    position = 0, 350
    halign = center
    valign = center
    shadow_passes = 2
    shadow_size = 3
    shadow_color = rgba(139, 0, 0, 0.8)
}

# Date display
label {
    monitor =
    text = cmd[update:60000] echo "$(date +'%A, %B %d, %Y' | tr '[:lower:]' '[:upper:]')"
    color = rgba(192, 192, 192, 1)
    font_size = 20
    font_family = JetBrains Mono
    position = 0, 250
    halign = center
    valign = center
}

# User identification
label {
    monitor =
    text = ◈ USER: $USER ◈
    color = rgba(212, 175, 55, 1)
    font_size = 18
    font_family = JetBrains Mono
    position = 0, -230
    halign = center
    valign = center
}

# Imperial motto
label {
    monitor =
    text = THE EMPEROR PROTECTS
    color = rgba(139, 0, 0, 0.8)
    font_size = 16
    font_family = JetBrains Mono
    position = 0, -300
    halign = center
    valign = center
}
EOF

# Create Hypridle config
echo "Configuring standby defense protocols..."
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
echo "Preparing sacred imagery display..."
cat > ~/.config/hypr/hyprpaper.conf << 'EOF'
preload = ~/.config/hypr/wallpaper.jpg
wallpaper = ,~/.config/hypr/wallpaper.jpg
splash = false
ipc = off
EOF

# Create Mako config - Imperial Notifications
echo "Configuring vox-caster notification systems..."
cat > ~/.config/mako/config << 'EOF'
# Mako Notifications - Imperial Vox System

font=JetBrainsMono Nerd Font Bold 10
background-color=#0a0a0a
text-color=#d4af37
border-color=#d4af37
border-size=3
border-radius=0
width=350
height=120
margin=15
padding=15
default-timeout=5000
ignore-timeout=0
icon-path=/usr/share/icons/

[urgency=low]
border-color=#808080
text-color=#c0c0c0

[urgency=normal]
border-color=#d4af37
text-color=#d4af37

[urgency=high]
border-color=#8b0000
text-color=#ff0000
default-timeout=0

[app-name=volume]
border-color=#4a7c2e

[app-name=brightness]
border-color=#ffd700
EOF

# Download a Warhammer 40k themed wallpaper
echo "Retrieving sacred battle imagery from the Librarium..."
mkdir -p ~/.config/hypr
# Using a generic dark/gothic wallpaper as placeholder
curl -L "https://images.unsplash.com/photo-1579546929518-9e396f3cc809" -o ~/.config/hypr/wallpaper.jpg 2>/dev/null || \
curl -L "https://images.unsplash.com/photo-1518709268805-4e9042af9f23" -o ~/.config/hypr/wallpaper.jpg 2>/dev/null || \
echo "Wallpaper download failed. Please add your own Warhammer 40k wallpaper to ~/.config/hypr/wallpaper.jpg"

# Add auto-start to shell profile
echo "Inscribing auto-initialization protocols..."
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
echo "  INSTALLATION COMPLETE - FOR THE EMPEROR"
echo "========================================="
echo ""
echo "The Machine Spirit has been appeased."
echo "Your Hyprland fortress is now operational."
echo ""
echo "⚔ DEPLOYMENT PROTOCOLS ⚔"
echo "  1. Logout or reboot your system"
echo "  2. Login to TTY1"
echo "  3. Hyprland will initialize automatically"
echo ""
echo "⚔ TACTICAL COMMANDS ⚔"
echo "  SUPER + Return        - Deploy terminal cogitator"
echo "  SUPER + D             - Access application sanctum"
echo "  SUPER + Q             - Purge active window"
echo "  SUPER + E             - Open data archives"
echo "  SUPER + L             - Engage defense protocols"
echo "  SUPER + F             - Maximize viewport"
echo "  SUPER + 1-10          - Deploy to sector"
echo "  SUPER + SHIFT + 1-10  - Relocate forces"
echo "  Print                 - Capture pict (area)"
echo "  SHIFT + Print         - Capture pict (full)"
echo ""
echo "⚔ SACRED CONFIGURATION ARCHIVES ⚔"
echo "  ~/.config/hypr/hyprland.conf"
echo "  ~/.config/waybar/"
echo "  ~/.config/wofi/"
echo "  ~/.config/kitty/kitty.conf"
echo ""
echo "⚔ CUSTOMIZATION NOTES ⚔"
echo "  Color Scheme: Imperial Gold (#d4af37) + Blood Red (#8b0000)"
echo "  Replace wallpaper at: ~/.config/hypr/wallpaper.jpg"
echo "  Recommended: Search for Warhammer 40k wallpapers"
echo ""
echo "THE EMPEROR PROTECTS"
echo "========================================="
echo ""
echo "Reboot to begin your crusade!"
