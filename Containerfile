FROM quay.io/fedora/fedora-bootc:41

COPY build.sh /tmp/build.sh
COPY system_files /

RUN mkdir -p /var/lib/alternatives && \
    /tmp/build.sh && \
    ostree container commit
    
