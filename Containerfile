FROM quay.io/fedora/fedora-bootc:41@sha256:5fa65b521fab1f60c8d53d20ae845719855cc780561737165996aca5af48bcac

COPY build.sh /tmp/build.sh
COPY system_files /

RUN mkdir -p /var/lib/alternatives && \
    /tmp/build.sh && \
    ostree container commit
    
