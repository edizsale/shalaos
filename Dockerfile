FROM archlinux:latest

# ISO uretimi icin archiso + temel araclar.
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm archiso git && \
    pacman -Scc --noconfirm

WORKDIR /build
