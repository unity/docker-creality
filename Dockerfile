# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-selkies:ubuntunoble

# set version label
ARG BUILD_DATE
ARG VERSION
ARG CREALITY_VERSION=v6.2.1
ARG CREALITY_FILE=CrealityPrint_Ubuntu2404-V6.2.1.3044-x86_64-Release.AppImage
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="aptalca"

ENV \
  CUSTOM_PORT="8080" \
  CUSTOM_HTTPS_PORT="8181" \
  HOME="/config" \
  TITLE="CrealityPrint" \
  QTWEBENGINE_DISABLE_SANDBOX="1" \
  CREALITY_VERSION="${CREALITY_VERSION}" \
  CREALITY_FILE="${CREALITY_FILE}"

RUN \
  echo "**** install runtime packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libmspack-dev \
    libgstreamerd-3-dev \
    libsecret-1-dev \
    libwebkit2gtk-4.1-dev \
    libosmesa6-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    eglexternalplatform-dev \
    libudev-dev \
    libdbus-1-dev \
    extra-cmake-modules \
    libgtk-3-dev \
    libglew-dev \
    cmake \
    git \
    texinfo \
    libwebkit2gtk-4.1-0 \
    libgtk-3-0t64 \
    libgdk-pixbuf2.0-0 \
    libcairo2 \
    libpango-1.0-0 \
    libatk1.0-0 \
    libx11-6 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    libnss3 \
    libcups2 \
    libdrm2 \
    libxkbcommon0 \
    libatspi2.0-0 \
    libxcb1 \
    libxcb-dri3-0 \
    libgbm1 && \
  echo "**** install creality ****" && \
  mkdir -p /opt/creality && \
  curl -o /tmp/CrealityPrint.AppImage -L \
  "https://github.com/CrealityOfficial/CrealityPrint/releases/download/${CREALITY_VERSION}/${CREALITY_FILE}" && \
  chmod +x /tmp/CrealityPrint.AppImage && \
  mv /tmp/CrealityPrint.AppImage /opt/creality/CrealityPrint.AppImage && \
  dbus-uuidgen > /etc/machine-id && \
  printf "Creality Print ${CREALITY_VERSION}\nBuild-date: ${BUILD_DATE}" > /build_version && \
  echo "**** cleanup ****" && \
  apt-get clean && \
  rm -rf \
  /tmp/* \
  /var/lib/apt/lists/* \
  /var/tmp/*

# add local files
COPY root/ /