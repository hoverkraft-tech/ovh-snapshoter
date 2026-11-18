FROM ghcr.io/hoverkraft-tech/docker-base-images/super-linter:2.0.2@sha256:12dedee667b43856a9cc792628fecc4723fc0868bf8090d268981407a7402b2c AS linter

HEALTHCHECK --interval=5m --timeout=10s --start-period=30s --retries=3 CMD ["/bin/sh", "-c", "test -d /github/home"]
ARG UID=1000
ARG GID=1000
USER ${UID}:${GID}

FROM python:3.12-slim-trixie AS builder

# hadolint ignore=DL3008
RUN --mount=type=cache,target=/var/cache/apt \
    set -eux; export DEBIAN_FRONTEND=noninteractive; \
    apt-get update; \
    apt-get install -y --no-install-recommends build-essential gcc

WORKDIR /build

COPY requirements.txt requirements.txt

# hadolint ignore=DL3042
RUN --mount=type=cache,target=~/.cache/pip \
  python -m venv /opt/venv \
  && /opt/venv/bin/pip install -r requirements.txt

FROM python:3.12-slim-trixie

ENV PYTHONUNBUFFERED="1" \
    DRY_RUN="false" \
    CLEANUP="false" \
    PATH=/opt/venv/bin:$PATH

COPY --from=builder /opt/venv /opt/venv
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
