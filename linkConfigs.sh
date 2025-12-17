ln -snf "$(pwd)/lua/configs/tmux/.tmux.conf" ~/.tmux.conf
ln -snf "$(pwd)/lua/configs/zsh/.zshrc" ~/.zshrc
ln -snf "$(pwd)" ~/.config/nvim

# -s: символическая ссылка.
# -n: не разыменовывать существующий симлинк (не заходить внутрь него).
# -f: удалить старую ссылку перед созданием новой.
