# run this file by
# docker build -t lihebi/arch-server .

FROM base/archlinux
RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm base-devel
RUN pacman -S --noconfirm clang llvm
RUN pacman -S --noconfirm clang-tools-extra
RUN pacman -S --noconfirm pugixml gtest r rapidjson boost
RUN pacman -S --noconfirm python python2
RUN pacman -S --noconfirm docker docker-compose
RUN pacman -S --noconfirm emacs

RUN pacman -S --noconfirm git cmake
# need to install at least a font so that the png file can be outputed
RUN pacman -S --noconfirm graphviz ttf-dejavu



RUN pacman -S --noconfirm tmux

# change the locale
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen

RUN echo "LANG=en_US.UTF-8" >> /etc/locale.conf

ENV TERM screen-256color

WORKDIR /root

RUN git clone https://github.com/lihebi/emacs.d .emacs.d
RUN emacs --script .emacs.d/init.el

ENV DOCKER_TTY 1
RUN git clone https://github.com/lihebi/dothebi .hebi && sh .hebi/install.sh

# set up git??
# set up this manually, because this will set the name to me ..
# RUN sh .hebi/setup-git.sh

# WORKDIR /root
# need manually perform this because it needs password
# RUN git clone https://github.com/lihebi/helium
