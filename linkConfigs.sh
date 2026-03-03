rm ~/.tmux.conf && ln -snf "$(pwd)/source/tmux/.tmux.conf" ~/.tmux.conf
rm ~/.zshrc && ln -snf "$(pwd)/source/zsh/.zshrc" ~/.zshrc
rm -rf ~/.config/nvim && ln -snf "$(pwd)/source/nvim" ~/.config/nvim
rm -rf ~/.config/hypr && ln -snf "$(pwd)/source/hypr" ~/.config/hypr
rm -rf ~/.config/jiffy && ln -snf "$(pwd)/source/jiffy" ~/.config/jiffy
rm -rf ~/.config/kitty && ln -snf "$(pwd)/source/kitty" ~/.config/kitty
rm -rf ~/.config/waybar && ln -snf "$(pwd)/source/waybar" ~/.config/waybar
