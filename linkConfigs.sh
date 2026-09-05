#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

config_dirs=(
    nvim
    hypr
    kitty
    mouseless
    yazi
    opencode
    herdr
    niri
    fuzzel
    matugen
		cava
)

file_pairs=(
    tmux
		tmux_collors
    zsh
)

tmux_pair=("$SCRIPT_DIR/source/tmux/.tmux.conf" "$HOME/.tmux.conf")
tmux_collors_pair=("$SCRIPT_DIR/source/tmux/.tmux.colors.conf" "$HOME/.config/.tmux.colors.conf")
zsh_pair=("$SCRIPT_DIR/source/zsh/.zshrc" "$HOME/.zshrc")

for name in "${config_dirs[@]}"; do
    rm -rf "$HOME/.config/$name"
    ln -snf "$SCRIPT_DIR/source/$name" "$HOME/.config/$name"
    echo "linked ~/.config/$name"
done

for name in "${file_pairs[@]}"; do
    declare -n pair="${name}_pair"
    mkdir -p "$(dirname "${pair[1]}")"
    ln -snf "${pair[0]}" "${pair[1]}"
    echo "linked ${pair[1]}"
done
