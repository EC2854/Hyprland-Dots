#!/usr/bin/env bash
not_arch_btw=false # variable to skip installing packages 
packages_to_install=( # list of packages to install
    "hyprland" "mpvpaper" "swww" "mako" "polkit-kde-agent" "eww" "tofi" "hyprwayland-scanner" "hypridle" "hyprlock" "jq" # important stuff
    "zsh" "eza" "fzf" "lf" "foot" "neovim" "fastfetch" "starship" "tmux" "kew" # terminal stuff
    "acpi" "inotify-tools" # optional - for laptop eww
) 

# Print Functions
print_message() {
    local color="$1"
    local marker="$2"
    local message="$3"
    echo -e "\e[1;${color}m[${marker}] \e[0m$message\e[0m"
}
## errors
print_error() {
    print_message 31 "ERROR" "$1"  # Red color for errors (31)
}
## warnings
print_warning() {
    print_message 33 "WARNING" "$1"  # Yellow color for warnings (33)
}
## success
print_success() {
    print_message 32 "SUCCESS" "$1"  # Green color for successes (32)
}
## general 
print_info() {
    print_message 36 "INFO" "$1"  # Cyan color for general messages (36)
}

# Install programs (Arch linux only)
install_packages() {
    print_info "installing packages"
    paru -S --noconfirm "${packages_to_install[@]}"
}

# clone function
clone_repository() {
    local repository_url="$1"
    local destination="$2"

    print_info "Cloning $repository_url"
    git clone --quiet "$repository_url" "$destination" && print_success "Cloned $destination successfully" || print_error "Error cloning $repository_url to $destination"
    ls $destination/.git >/dev/null 2>&1 && rm -rf $destination/.git
}
# copy function
copy() {
    local source=$1 
    local destination="$2"
    print_info "Copying files from $source to $destination"
    cp -rf "$source" "$destination" && print_success "Files copied successfully to $destination" || print_error "Error while copying to $destination"
}

# confirmation
ask_for_confirmation() {
    print_warning "Caution: This script overwrites config files. Change resolution in ./config/hypr/hyprland.conf. RTFM: https://wiki.hyprland.org/Configuring/Monitors/"
    read -p "Do you want to continue? (y/n): " choice
    case "$choice" in 
        y|Y ) return 0 ;; # Continue
        n|N ) exit 0 ;;   # Exit script
        * ) 
            echo "Invalid choice. Please enter 'y' or 'n'."
            ask_for_confirmation ;;
    esac
}
# Check Distro
command -v  pacman &>/dev/null || { 
    print_warning "This script is intended for Arch Linux. You can still run this script, but it won't install any packages." 
    not_arch_btw=true 
}

# Check for paru
command -v paru &>/dev/null || { 
    print_warning "paru not found. You can still run this script, but it won't install any packages." 
    not_arch_btw=true 
}

# Check for internet connection
ping -q -c 1 -W 1 github.com &>/dev/null || {
    print_error "No internet connection. Exiting..." 
    exit 1 
}

# Check Folder
ls $(pwd)/install.sh &>/dev/null || { 
    print_error "Please open folder with this script before running it" 
    exit 1 
}

# Ask for confirmation before continuing
ask_for_confirmation

[[ $not_arch_btw == false ]] && install_packages

# Copy files to ~/.config directory
copy ./.config ~/ &
copy ./.local ~/ &
# Copy .zshrc
copy ./.zshrc ~/ &

# Clone Wallpapers
clone_repository https://github.com/EC2854/wallpapers ~/Pictures/Wallpapers &

# Hyprland Plugin
# Final message
print_info "That's it!"
print_info "Reboot ur system :3"
# print_warning "Run 'hyprpm enable Hyprspace' after installation"
