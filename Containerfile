FROM ghcr.io/containerpak/gtk3:main

LABEL org.opencontainers.image.source="https://github.com/Containerpak/minecraft"

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates libcurl4t64 libnss3 libsecret-1-0 libxss1 x11-xserver-utils xdg-utils && \
    mkdir -p /usr/share/icons/hicolor/scalable/apps && \
    ln -sf /usr/share/icons/hicolor/symbolic/apps/minecraft-launcher.svg /usr/share/icons/hicolor/scalable/apps/minecraft.svg && \
    cpak-clean-junk

COPY minecraft.desktop /usr/share/applications/minecraft.desktop
