FROM alpine

RUN \
  apk update && apk upgrade && \
  apk add \
    bash \
    build-base \
    gcc \
    make \
    ruby \
    ruby-dev \
    openssl \
    openssl-dev \
    zlib \
    zlib-dev \
    sudo \
    which

RUN \
  gem install --no-user-install \
    bundler \
    rake

RUN \
  adduser native-package-installer -G wheel -D -h /home/native-package-installer

RUN \
  echo "native-package-installer ALL=(ALL:ALL) NOPASSWD:ALL" | \
    EDITOR=tee visudo -f /etc/sudoers.d/native-package-installer

USER native-package-installer
WORKDIR /home/native-package-installer
