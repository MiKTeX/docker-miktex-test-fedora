FROM fedora:41

LABEL Description="MiKTeX test environment, Fedora 41"
LABEL Vendor="Christian Schenk"
LABEL Version="24.12.22"

RUN \
    dnf install -y \
        binutils \
        cmake \
        curl \
        diffutils \
        ghostscript \
        gpg \
        make \
        unzip \
        zip

RUN \
    export GNUPGHOME="$(mktemp -d)"; \
    gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
    curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.14/gosu-amd64"; \
    curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.14/gosu-amd64.asc"; \
    gpg --batch --verify /usr/local/bin/gosu.asc; \
    rm /usr/local/bin/gosu.asc; \
    chmod +x /usr/local/bin/gosu

RUN mkdir /miktex
WORKDIR /miktex

COPY scripts/*.sh /miktex/
COPY entrypoint.sh /miktex/

ENTRYPOINT ["/miktex/entrypoint.sh"]
CMD ["/miktex/test.sh"]
