# run this file by
# docker build -t lihebi/arch-server .

FROM base/archlinux

ENV PACMAN_OPTIONS="--noconfirm --needed"
ENV TERM screen-256color
ENV DOCKER_TTY 1
     
RUN pacman $PACMAN_OPTIONS -Syu
RUN pacman $PACMAN_OPTIONS -S base-devel
RUN pacman $PACMAN_OPTIONS -S clang llvm
RUN pacman $PACMAN_OPTIONS -S clang-tools-extra
RUN pacman $PACMAN_OPTIONS -S pugixml gtest r rapidjson boost
RUN pacman $PACMAN_OPTIONS -S python python2
RUN pacman $PACMAN_OPTIONS -S docker docker-compose
RUN pacman $PACMAN_OPTIONS -S emacs

RUN pacman $PACMAN_OPTIONS -S git cmake
# need to install at least a font so that the png file can be outputed
RUN pacman $PACMAN_OPTIONS -S graphviz ttf-dejavu

RUN pacman $PACMAN_OPTIONS -S tmux man


RUN pacman $PACMAN_OPTIONS -S wget gradle

# change the locale
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen

RUN echo "LANG=en_US.UTF-8" >> /etc/locale.conf

# RUN useradd -m admin
# RUN echo "admin ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/admin && chmod 0440 /etc/sudoers.d/admin
# USER admin
# WORKDIR /home/admin

# aur
# RUN git clone https://aur.archlinux.org/rtags-git && cd rtags-git && makepkg -si --noconfirm
# RUN rm -r rtags-git
ENV HOME /root
WORKDIR $HOME

RUN git clone https://github.com/lihebi/emacs.d .emacs.d
RUN emacs --script .emacs.d/init.el

RUN git clone https://github.com/lihebi/dothebi .hebi && sh .hebi/install.sh
RUN sh .hebi/setup-git.sh
