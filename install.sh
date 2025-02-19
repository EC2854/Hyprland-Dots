#!/usr/bin/env bash
packages_to_install=( # list of packages to install
    "hyprland" "mpvpaper" "swww" "mako" "polkit-kde-agent" "eww" "tofi" "hyprwayland-scanner" "hypridle" "hyprlock" "jq" "uwsm" # important stuff
    "zsh" "eza" "fzf" "lf" "foot" "neovim" "fastfetch" "starship" "tmux" "kew" "zoxide" # terminal stuff
    "noto-fonts-cjk" "ttf-noto-emoji-monochrome" # non nerd fonts
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

check_aur() {
    if command -v paru &>/dev/null; then
        aur_helper=paru
        print_info "Using paru as the AUR helper."
    elif command -v yay &>/dev/null; then
        aur_helper=yay
        print_info "Using yay as the AUR helper."
    else
        print_warning "No AUR helper found. The script will continue, but it won't install packages."
    fi
}

clone_repository() {
    local repository_url="$1"
    local destination="$2"

    print_info "Cloning $repository_url"
    git clone --quiet "$repository_url" "$destination" && print_success "Cloned $destination successfully" || print_error "Error cloning $repository_url to $destination"
    ls "$destination"/.git &>/dev/null && rm -rf "$destination"/.git
}
copy() {
    local source=$1 
    local destination="$2"

    print_info "Copying files from $source to $destination"
    if ls "$destination" &> /dev/null; then
        mv "$destination" "$destination.bak"
        print_info "Moved existing $destination to $destination.bak"
    fi
    cp -rf "$source" "$destination" && print_success "Files copied successfully to $destination" || print_error "Error while copying to $destination"
}
install_modernz() {
    mpv_dir=$(mktemp -d) &&
    clone_repository https://github.com/Samillion/ModernZ "$mpv_dir" &&
    mkdir ~/.config/mpv/scripts &&
    mkdir ~/.config/mpv/fonts &&
    cp "$mpv_dir/modernz.lua" ~/.config/mpv/scripts &&
    cp "$mpv_dir/fluent-system-icons.ttf" ~/.config/mpv/fonts &&
    rm -rf "$mpv_dir" &&
    print_success "Successfully installed mpv theme"
}
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
}

# Check for internet connection
ping -q -c 1 github.com &>/dev/null || {
    print_error "No internet connection. Exiting..." 
    exit 1 
}
# Check Folder
ls "$(pwd)"/install.sh &>/dev/null || { 
    print_error "Please open folder with this script before running it" 
    exit 1 
}
check_aur
ask_for_confirmation

[ -z "$aur_helper" ] && {
    print_info "Starting package installation..."
    $aur_helper -S --noconfirm "${packages_to_install[@]}"
}

# copy files
for file in .config/*; do
   copy "$file" ~/"$file"
done
copy .local/share/matugen ~/.local/share/matugen &
copy .local/share/scripts ~/.local/share/matugen &
copy .zshrc ~/.zshrc &
install_modernz &
clone_repository https://github.com/EC2854/wallpapers ~/Pictures/Wallpapers &

wait
print_info "That's it!"
print_info "Reboot ur system :3"
