FROM ubuntu:26.04 AS source

ADD --checksum=sha256:cd9f0b44fc9cec42829cb2e71145ee599f3d34c7715b55963514d0a8d36214ab https://launcher.mojang.com/download/linux/x86_64/minecraft-launcher_1.0.1221.tar.gz /tmp/app.tar.gz

RUN mkdir -p /out && \
    tar -xzf /tmp/app.tar.gz --strip-components=1 -C /out

FROM ghcr.io/containerpak/gtk3:main

LABEL org.opencontainers.image.source="https://github.com/Containerpak/minecraft"

COPY --from=source /out /opt/minecraft-launcher

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates libcurl4t64 libnss3 libsecret-1-0 libxss1 x11-xserver-utils xdg-utils && \
    ln -sf /opt/minecraft-launcher/minecraft-launcher /usr/bin/minecraft-launcher && \
    cpak-clean-junk

COPY icon.png /usr/share/icons/hicolor/128x128/apps/minecraft.png
COPY minecraft.desktop /usr/share/applications/minecraft.desktop
