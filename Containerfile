FROM quay.io/fedora/fedora-bootc:43@sha256:431fc56347287d2e3e985689958b6a359741cc7d3ff63295f026dbb112a073f4

COPY build.sh /tmp/build.sh
COPY system_files /

RUN mkdir -p /var/lib/alternatives && \
    /tmp/build.sh && \
    ostree container commit
    
