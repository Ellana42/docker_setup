FROM debian:latest

RUN apt update
RUN apt install -y zsh git sudo vim neovim python3 python3-pip clang gcc valgrind tmux libreadline-dev npm

RUN useradd --shell /usr/bin/zsh --create-home ellana
RUN usermod -aG sudo ellana
RUN echo 'ellana:password' | chpasswd

RUN echo 'set -o vi\nalias c="clear"\nPROMPT="[%1~] - "' > /home/ellana/.zshrc
RUN echo 'export PATH="$HOME/.local/bin:$PATH"' >> /home/ellana/.zshrc
# RUN echo 'alias valgrind=colour-valgrind' >> /home/ellana/.zshrc
RUN echo 'unbind C-b\nset-option -g prefix `\nbind-key ` send-prefix\nbind - split-window -v -c "#{pane_current_path}"\n bind = split-window -h -c "#{pane_current_path}"\nbind h select-pane -L\n bind j select-pane -D \n bind k select-pane -U\n bind l select-pane -R\n bind x kill-pane' >> /home/ellana/.tmux.conf


USER ellana
RUN pip install colour-valgrind norminette pandas termcolor

WORKDIR /home/ellana
CMD /usr/bin/zsh
