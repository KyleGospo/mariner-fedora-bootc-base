FROM scratch AS ctx
COPY build_files /

FROM quay.io/fedora/fedora-bootc:44@sha256:c8ba1bbf06e618dd9e87049f227d8ef73a1352f7b6f81c574d62cf58fb99c25e

COPY system_files /

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    --mount=type=tmpfs,dst=/boot \
    /ctx/build.sh && \
    ostree container commit

RUN bootc container lint
