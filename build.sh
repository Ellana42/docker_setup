mkdir dotfiles
cp ~/dotfiles/.zshrc dotfiles/
cp ~/dotfiles/nvim/init.vim dotfiles/
cp ~/dotfiles/nvim/plugins.vim dotfiles/
cp ~/.ssh/id_rsa dotfiles/
docker build -t full_setup .
