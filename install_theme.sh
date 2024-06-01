#!/bin/bash
release="v1.0.2"
tmp_dir=$(mktemp -d /tmp/install_themes.XXXXXX)


# sanity check
[ -z $tmp_dir ] || {
    mkdir $tmp_dir/zip
    mkdir $tmp_dir/themes

    install_theme() {
        local accent="$1"
        local file="catppuccin-mocha-${accent}-Dark"
        curl -fsSL "https://github.com/catppuccin/gtk/releases/download/${release}/catppuccin-mocha-${accent}-standard+default.zip" --output $tmp_dir/zip/${file}.zip
        unzip -qq $tmp_dir/zip/${file}.zip -d $tmp_dir/themes/
        rm -r $tmp_dir/themes/*hdpi
        mv $tmp_dir/themes/$(ls $tmp_dir/themes | head -n 1) ~/.themes/${file}

    }
    install_theme "red"
    install_theme "mauve"
    install_theme "peach"
    install_theme "yellow"
    install_theme "pink"
    install_theme "green"
    install_theme "sapphire"
    rm -r $tmp_dir
}


