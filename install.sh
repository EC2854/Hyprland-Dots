#!/bin/bash

# ⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⣿⡿⠻⣟⣻⣻⠿⣿⣿⣿⣿⣿⣿⣿⣿  _____ ____ ____  ___ ____  _  _   
# ⣿⣿⣿⣿⣿⣿⣿⢿⣿⣾⣿⣿⣿⣷⣜⢉⣟⣾⡷⣽⡻⣿⣿⣿⣿⣿ | ____/ ___|___ \( _ ) ___|| || |  
# ⣿⣿⣿⣿⣿⡿⣡⣾⣿⣿⣿⣿⡿⢿⣿⣷⡩⡽⣛⢷⣿⡪⡻⣿⣿⣿ |  _|| |     __) / _ \___ \| || |_ 
# ⣿⣿⣿⣿⡟⡾⡋⣼⣿⡿⠛⣩⣾⣿⡿⣫⣶⣿⡾⣿⣮⣿⡦⡙⣿⣿ | |__| |___ / __/ (_) |__) |__   _|
# ⣿⣿⣿⣿⢁⠞⣼⡏⡷⣡⡬⡿⣹⡿⣹⣿⢹⣧⢿⢨⡹⢨⡺⢷⡹⣿ |_____\____|_____\___/____/   |_|  
# ⣿⣿⣿⡟⢪⣸⣿⠸⣉⡟⠜⡵⡟⣼⣿⡇⣿⣿⣿⢸⡍⣔⢸⣸⢷⢹ -----------------------------------
# ⣿⣿⣿⣷⣎⠟⢸⣸⣭⠁⡞⣁⡇⣿⡿⣹⣿⣿⡻⠀⡇⣿⠎⢼⠺⢸ Ewa (EC2854)
# ⣿⣿⣿⣿⡛⠸⡇⢹⡏⠀⠈⠭⠘⡘⢣⠟⢡⠃⠑⠀⢸⠏⠚⠘⡆⣸ https://github.com/EC2854
# ⣿⣿⣿⣿⣷⡀⠩⡸⠁⢲⣤⣼⣷⠃⣀⡄⣠⣀⣸⠆⠀⠀⡄⣸⣷⣿ https://www.reddit.com/user/EC2854
# ⣿⣿⣿⣿⣿⣿⡦⠀⠨⡂⠨⣛⣧⣾⣯⢾⣿⣛⠁⠀⠀⠀⣿⣿⣿⣿ -----------------------------------
# ⣿⣿⣿⣿⣿⡿⣡⣶⣿⣷⣶⡌⣙⣛⣓⣾⡭⠁⠀⠀⢠⢰⣿⣿⣿⣿ Install script for https://github.com/EC2854/Hyprland-Dots
# ⣿⣿⣿⡿⢏⣾⣿⣿⣿⣿⣿⣷⠘⠿⣻⣥⡀⣀⣴⣧⣿⣿⣿⣿⣿⣿
# ⣿⣟⣽⠊⣾⠟⠀⢀⢹⣿⣿⣿⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
# ⡿⠾⠇⠀⣿⡐⣨⣧⣾⣿⣿⡇⠈⢻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
# ⡗⡟⠀⠀⣿⣿⣾⣿⣿⣿⠉⢰⡄⠘⢷⣮⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿

not_arch_btw=false # variable to skip installing packages 
packages_to_install=( # list of packages to install
    "hyprland" "swww" "hyprpicker-git" "avizo" "polkit-gnome" "aylurs-gtk-shell-git" "anyrun-git" "cpio" "sddm" "bc" "wget" # important stuff
    "networkmanager" "blueman" 
    "bibata-cursor-theme" # Themes
    "loupe" "nautilus" # Gnome Stuff
    "zsh" "eza" "bat" "ripgrep" "fzf" "lf" "foot" "neovim" "fastfetch" "starship" # terminal stuff
    "pavucontrol" "helvum" 
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
    paru -S --noconfirm ${packages_to_install[@]}
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
# Install Hyprland Plugins
install_plugin() {
    local name=$1
    hyprpm add $name && print_success "$name installed successfully" || print_error "Error while installing $name"
}

install_icons() {
    wget -qO- https://git.io/papirus-icon-theme-install | env DESTDIR="$HOME/.local/share/icons" sh
    rm -r ~/.local/share/icons/Papirus-Dark ~/.local/share/icons/Papirus-Light ~/.local/share/icons/ePapirus*
    cat_folder=$(mktemp -d /tmp/cat-folder.XXXXXX)
    clone_repository https://github.com/catppuccin/papirus-folders "$cat_folder"
    [ -z $cat_folder ] && exit 1
    for icon in $(ls $cat_folder/src/); do
         rm ${cat_folder}/src/${icon}/places/*latte*
         rm ${cat_folder}/src/${icon}/places/*frappe*
         rm ${cat_folder}/src/${icon}/places/*macchiato*
    done
    cp -r ${cat_folder}/src/* ~/.local/share/icons/Papirus
    curl -Lo ~/.local/share/icons/papirus-folders https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-folders/master/papirus-folders 
    chmod +100 ~/.local/share/icons/papirus-folders
    rm -r $cat_folder
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
# Copy .zshrc
copy ./.zshrc ~/ &
# Copy Bashrc
copy ./.bashrc ~/ &

# install zsh plugins
clone_repository https://github.com/Aloxaf/fzf-tab ~/.config/zsh/fzf-tab &
clone_repository https://github.com/zsh-users/zsh-autosuggestions.git ~/.config/zsh/zsh-autosuggestions &
clone_repository https://github.com/zsh-users/zsh-history-substring-search.git ~/.config/zsh/zsh-history-substring-search &
clone_repository https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/zsh/zsh-syntax-highlighting &

# Clone Wallpapers
clone_repository https://github.com/EC2854/wallpapers ~/Pictures/Wallpapers &

# install gtk themes
clone_repository https://github.com/EC2854/catppuccin-mocha-gtk ~/.local/share/themes


# Install icons
install_icons

# set temporary gtk theme
ln -sf ~/.local/share/themes/catppuccin-mocha-mauve-Dark/gtk-4.0 ~/.config/gtk-4.0

# Hyprland Plugins
print_info "Plugins time!"
print_warning "this part can fail. i don't know what to do about it."
print_info "if it will fail install hyprland-plugins and Hyprspace plugins manually (or rerun script inside hyprland)"

install_plugin https://github.com/hyprwm/hyprland-plugins
install_plugin https://github.com/KZDKM/Hyprspace

# Final message
print_info "That's it!"
print_info "Reboot ur system :3"
print_warning "Run 'hyprpm enable Hyprspace' after installation"
