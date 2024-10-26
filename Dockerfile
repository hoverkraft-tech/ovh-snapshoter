FROM python:3.12-slim-bullseye AS builder

# hadolint ignore=DL3008
RUN set -eux; export DEBIAN_FRONTEND=noninteractive; \
    apt-get update; \
    apt-get install -y --no-install-recommends build-essential gcc

WORKDIR /build

COPY requirements.txt requirements.txt
# hadolint ignore=DL3042
RUN --mount=type=cache,target=~/.cache/pip \
  pip install --user -r requirements.txt

FROM python:3.12-slim-bullseye

ENV PYTHONUNBUFFERED="1" \
    DRY_RUN="false" \
    CLEANUP="false" \
    OS_AUTH_URL=https://auth.cloud.ovh.net/v3/ \
    OS_IDENTITY_API_VERSION="3" \
    OS_PASSWORD="" \
    OS_PROJECT_DOMAIN_NAME=Default \
    OS_PROJECT_ID="" \
    OS_REGION_NAME=GRA5 \
    OS_TENANT_ID="" \
    OS_TENANT_NAME="" \
    OS_USER_DOMAIN_NAME=Default \
    OS_USERNAME="" \
    OS_VOLUMES="" \
    PATH=/root/.local/bin:$PATH

COPY --from=builder /root/.local /root/.local
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
