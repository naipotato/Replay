# syntax = docker/dockerfile:experimental
FROM fedora

RUN dnf install -y meson vala gtk4-devel vulkan-headers libgee-devel sassc git flatpak flatpak-builder

RUN flatpak remote-add --if-not-exists gnome-nightly https://nightly.gnome.org/gnome-nightly.flatpakrepo
RUN --security=insecure flatpak install -y --noninteractive gnome-nightly org.gnome.Platform//master \
        org.gnome.Sdk//master
