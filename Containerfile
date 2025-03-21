FROM quay.io/fedora/fedora-bootc:40

COPY build.sh /tmp/build.sh
COPY system_files /

RUN mkdir -p /var/lib/alternatives && \
    /tmp/build.sh && \
    ostree container commit && \
    bootc container lint
