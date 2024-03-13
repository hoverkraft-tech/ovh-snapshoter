FROM python:3.12-slim-bullseye

ENV PYTHONUNBUFFERED="1"
ENV OS_AUTH_URL: https://auth.cloud.ovh.net/v3/
ENV OS_IDENTITY_API_VERSION: "3"
ENV OS_PASSWORD: ""
ENV OS_PROJECT_DOMAIN_NAME: Default
ENV OS_PROJECT_ID: ""
ENV OS_REGION_NAME: GRA5
ENV OS_TENANT_ID: ""
ENV OS_TENANT_NAME: ""
ENV OS_USER_DOMAIN_NAME: Default
ENV OS_USERNAME: ""
ENV OS_VOLUMES: ""

USER 1000:1000

WORKDIR /app
COPY requirements.txt requirements.txt
# hadolint ignore=DL3042
RUN --mount=type=cache,target=~/.cache/pip \
  pip install --user -r requirements.txt

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
