FROM quay.io/fedora/fedora-bootc:40@sha256:2bbc61bf1c0095ae0fb754a8129cd1cb736dcf0c09c179c641ccf556422f1d69

COPY build.sh /tmp/build.sh
COPY system_files /

RUN mkdir -p /var/lib/alternatives && \
    /tmp/build.sh && \
    ostree container commit
    
