FROM debian:latest

# Install packages
RUN apt update
RUN apt install -y zsh git sudo vim neovim python3 python3-pip clang gcc valgrind tmux libreadline-dev npm tldr man
RUN apt install -y curl openssh-client
RUN npm install --global pure-prompt

# Create user
RUN useradd --shell /usr/bin/zsh --create-home ellana
RUN usermod -aG sudo ellana
RUN echo 'ellana:password' | chpasswd

# Setup github access
ADD dotfiles/id_rsa /home/ellana/.ssh/id_rsa
RUN chmod +rwx /home/ellana/.ssh/id_rsa
RUN echo '[url ”git@github.com:”]\n\tinsteadOf = https://gethub.com/' >> /root/.gitconfig
RUN echo 'StrictHostKeyChecking no ' > /home/ellana/.ssh/config

# Switch to user
USER ellana
WORKDIR /home/ellana

# Install python packages
RUN pip install colour-valgrind norminette pandas termcolor

# Install base packages
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN mkdir /home/ellana/.config
RUN git clone git@github.com:chriskempson/base16-shell.git /home/ellana/.config/base16-shell
RUN git clone git@github.com:chriskempson/base16-vim.git /home/ellana/.config/base16-vim
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
RUN git clone https://github.com/jeffreytse/zsh-vi-mode ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode

# Get dotfiles
RUN mkdir ~/.config/nvim/
ADD dotfiles/init.vim dotfiles/plugins.vim dotfiles/plug_install.vim /home/ellana/.config/nvim/
ADD dotfiles/.zshrc /home/ellana/.zshrc
ADD dotfiles/.tmux.conf /home/ellana/

# Launch
CMD /usr/bin/zsh
