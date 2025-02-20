#!/usr/bin/env bash

FONT="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.tar.xz"

not_arch_btw=false

packages_needed=(
    "git" "curl" # Bloated script XD
)
packages_to_install=(
    "hyprland" "mpvpaper" "swww" "mako" "polkit-kde-agent" "eww" "tofi" "hyprwayland-scanner" "hypridle" "hyprlock" "jq" "uwsm" "xdg-desktop-portal-hyprland" "xdg-desktop-portal-gtk" # important stuff
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
check_needed() {
    local installed
    installed=$(pacman -Qq)
    for package in "${packages_needed[@]}"; do
        grep -q "$package" <<< "$installed" || {
            print_info "Installing dependencies for install script..."
            sudo pacman -S --noconfirm --needed "${packages_needed[@]}" 
            return
        }
    done

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
    local mpv_dir
    mpv_dir=$(mktemp -d) &&

    print_info "Installing mpv theme"
    clone_repository https://github.com/Samillion/ModernZ "$mpv_dir" 

    mkdir -p ~/.config/mpv/scripts
    mkdir -p ~/.config/mpv/fonts

    mv "$mpv_dir/modernz.lua" ~/.config/mpv/scripts
    mv "$mpv_dir/fluent-system-icons.ttf" ~/.config/mpv/fonts
    rm -rf "$mpv_dir"

    print_success "Successfully installed mpv theme"
}
install_font() {
    local fonts_dir="$HOME/.local/share/fonts"
    local font_dir
    font_dir=$(mktemp -d)

    print_info "Downloading nerd font"
    curl -s -o "$font_dir"/Meslo.tar.xz -L "$FONT" 
    tar xJf "$font_dir/Meslo.tar.xz" -C "$font_dir"

    mkdir -p "$fonts_dir"
    mv "$font_dir"/MesloLGLNerdFont* "$fonts_dir/"
    rm -rf "$font_dir"

    print_success "Successfully downloaded nerd font"
}
ask_for_confirmation() {
    read -p "Do you want to continue? (y/n): " choice
    case "$choice" in 
        y|Y ) return 0 ;;
        n|N ) exit 0 ;;
        * ) 
            echo "Invalid choice. Please enter 'y' or 'n'."
            ask_for_confirmation 
        ;;
    esac
}
# Check Distro
command -v  pacman &>/dev/null || { 
    print_warning "This script is intended for Arch Linux. You can still run this script, but it won't install any packages." 
    not_arch_btw=true
}


# Check for internet connection
ping -q -c 1 github.com &>/dev/null || {
    print_error "No internet connection. Exiting..." 
    exit 1 
}
# Check Folder
cd "$(dirname "$(realpath "$0")")" || { 
    print_error "Please open folder with this script before running it" 
    exit 1 
}

if [[ $not_arch_btw = false ]]; then
    check_needed
    check_aur
fi

print_warning "Check monitor config in ./config/hypr/hyprland.conf before running the script. RTFM: https://wiki.hyprland.org/Configuring/Monitors/"
ask_for_confirmation

[ -z "$aur_helper" ] && {
    print_info "Starting package installation..."
    $aur_helper -S --noconfirm "${packages_to_install[@]}"
}

# copy configs
for file in .config/*; do
   copy "$file" ~/"$file"
done

copy .local/share/matugen ~/.local/share/matugen &
copy .local/share/scripts ~/.local/share/matugen &
copy .zshrc ~/.zshrc &

install_modernz &
install_font &

clone_repository https://github.com/EC2854/wallpapers ~/Pictures/Wallpapers &

wait
print_info "That's it!"
print_info "Reboot ur system :3"
