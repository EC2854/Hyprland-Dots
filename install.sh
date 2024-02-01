#! /bin/bash

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

# clone function
clone_repository() {
    local repository_url="$1"
    local destination="$2"

    print_info "Cloning $repository_url..."
    if git clone --quiet "$repository_url" "$destination"; then
        print_success "Cloned $destination successfully"
    else
        print_error "Error cloning $repository_url to $destination"
        exit 1
    fi
}

# copy function
copy_folder() {
    local source=("$1"/*)  # Capture the list of files and directories
    local destination="$2"
    local message_success="$3"
    local message_error="$4"

    if ! ls "$destination" > /dev/null; then
        mkdir -p $destination
    fi

    print_info "Copying files from $1 to $destination"
    if cp -rf "${source[@]}" "$destination"; then
        print_success "$message_success"
    else
        print_error "$message_error"
        exit 1
    fi
}
copy_files() {
    local source=$1  # Capture the list of files and directories
    local destination="$2"
    local message_success="$3"
    local message_error="$4"

    print_info "Copying files from $1 to $destination"
    if cp -f "$source" "$destination"; then
        print_success "$message_success"
    else
        print_error "$message_error"
        exit 1
    fi
}

# confirmation
ask_for_confirmation() {
    print_warning "This script will overwrite config files for certain programs. (TIP: check resolution under ./.config/hypr/hyprland.conf)"
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
if [[ $(lsb_release -si) != "Arch" ]]; then
    print_error "This script is only for Arch Linux"
    exit 1
fi

# Check for internet connection
if ! ping -q -c 1 -W 1 github.com > /dev/null; then
    print_error "No internet connection. Exiting..."
    exit 1
fi

# Check Folder
if ! ls $(pwd)/install.sh > /dev/null; then
    print_error "Please open folder with this script before running it"
    exit 1
fi

# TODO
print_warning "I was too lazy to add installing programs sooooo install them before running this script :P"

# Ask for confirmation before continuing
ask_for_confirmation

# Copy files to ~/.config directory
copy_folder ./.config ~/.config/ "Configs copied successfully" "Error copying files to ~/.config"

sleep 1

# Copy .zshrc
copy_files ./.zshrc ~/ ".zshrc copied successfully" "Error copying .zshrc"

# Copy Bashrc
copy_files ./.bashrc ~/ ".bashrc copied successfully" "Error copying .bashrc"
sleep 1 

# Clone zsh plugins
clone_repository https://github.com/Aloxaf/fzf-tab ~/home/.config/zsh/fzf-tab
clone_repository https://github.com/zsh-users/zsh-autosuggestions.git ~/home/.config/zsh/zsh-autosuggestions
clone_repository https://github.com/zsh-users/zsh-history-substring-search.git ~/home/.config/zsh/zsh-history-substring-search
clone_repository https://github.com/zsh-users/zsh-syntax-highlighting.git ~/home/.config/zsh/zsh-syntax-highlighting

sleep 1

# Copy Wallpapers
mkdir -p ~/Pictures/Wallpapers
copy_folder ./Wallpapers ~/Pictures/Wallpapers/ "Wallpapers copied successfully" "Error while copying wallpapers to ~/Pictures/Wallpapers"

print_info "That's it! Uncopied files are: .badapple.py, .frames-ascii, and web folder"
print_info "Logout and log back in."
