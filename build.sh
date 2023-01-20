mkdir dotfiles
cp ~/dotfiles/.zshrc dotfiles/
cp ~/dotfiles/nvim/init.vim dotfiles/
cp ~/dotfiles/nvim/plugins.vim dotfiles/
cp ~/dotfiles/nvim/plug_install.vim dotfiles/
cp ~/dotfiles/.tmux.conf dotfiles/
cp ~/.ssh/id_rsa dotfiles/
cp ~/.ssh/id_ed25519 dotfiles/
docker build -t full_setup .
