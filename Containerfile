FROM scratch AS ctx
COPY build_files /

FROM quay.io/fedora/fedora-bootc:45@sha256:4ded9b20e4988ed4eca8e336b0aafe7340788d1d1fc82f88e8ef381eea671bb4

COPY system_files /

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    --mount=type=tmpfs,dst=/boot \
    /ctx/build.sh && \
    ostree container commit

RUN bootc container lint
