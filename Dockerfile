FROM debian:latest

# Install packages
RUN apt update
RUN apt install -y zsh git sudo vim neovim python3 python3-pip clang gcc valgrind tmux libreadline-dev npm tldr man

# Create user
RUN useradd --shell /usr/bin/zsh --create-home ellana
RUN usermod -aG sudo ellana
RUN echo 'ellana:password' | chpasswd

# Setup github access
ADD dotfiles/id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa
# RUN echo “[url \”git@github.com:\”]\n\tinsteadOf = 
# https://github.com/" >> /root/.gitconfig
RUN echo “StrictHostKeyChecking no “ > /root/.ssh/config

# Switch to user
USER ellana
WORKDIR /home/ellana

# Get dotfiles
RUN mkdir ~/.config ~/.config/nvim/
ADD dotfiles/init.vim dotfiles/plugins.vim /home/ellana/.config/nvim
ADD dotfiles/.zshrc /home/ellana/.zshrc

# Install python packages
RUN pip install colour-valgrind norminette pandas termcolor

# Install base packages
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN git clone git@github.com:chriskempson/base16-shell.git
RUN git clone git@github.com:chriskempson/base16-vim.git
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Launch
CMD /usr/bin/zsh
