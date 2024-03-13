#!/bin/bash

set -euo pipefail

# variables
CINDER_OPTS="${CINDER_OPTS:---os-volume-api-version 3.59}"
CLEANUP="${CLEANUP:-false}"
DRY_RUN="${DRY_RUN:-false}"

# functions
check_var() {
  if [ -z "${!1}" ]; then
    echo "$1 is not set"
    exit 1
  fi
}

snapshot-metadata() {
  local key="$1"
  local snapshot="$2"
  cinder $CINDER_OPTS snapshot-metadata-show "$snapshot" | grep -E "^\| $key " | awk '{print $4}'
}

snapshot-mark-for-cleanup() {
  local snapshot="$1"
  cinder $CINDER_OPTS snapshot-metadata $snapshot set cleanup=true
}

cleanup-pre() {
  echo "removing all existing snapshots"
  for snap in $(cinder $CINDER_OPTS snapshot-list --metadata createdBy=ovh-snapshoter \
                  | grep -E '[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}' \
                  | awk '{print $2}' ); do
    vol="$(snapshot-metadata snapshotOf $snap)"
    if (echo "${OS_VOLUMES}" | grep -q "$vol"); then
      echo "Volume $vol is planned to be snapshoted again, marking snapshot $snap for cleanup"
      snapshot-mark-for-cleanup $snap
    else
      echo "Volume $vol is not planned for backup again, skipping cleanup of snapshot $snap"
    fi
  done
}

cleanup-post() {
  echo "removing snapshots marked for cleanup"
  for snap in $(cinder $CINDER_OPTS snapshot-list --metadata cleanup=true \
                  | grep -E '[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}' \
                  | awk '{print $2}' ); do
    if [ "$DRY_RUN" = "true" ]; then
      echo "would remove snapshot with id=$snap"
      continue
    fi
    echo "removing snapshot with id=$snap"
    cinder $CINDER_OPTS snapshot-delete $snap
  done
}

# sanity checks
check_var "OS_AUTH_URL"
check_var "OS_IDENTITY_API_VERSION"
check_var "OS_PASSWORD"
check_var "OS_PROJECT_DOMAIN_NAME"
check_var "OS_PROJECT_ID"
check_var "OS_REGION_NAME"
check_var "OS_TENANT_ID"
check_var "OS_TENANT_NAME"
check_var "OS_USER_DOMAIN_NAME"
check_var "OS_USERNAME"
check_var "OS_VOLUMES"

# main
if [ "$CLEANUP" = "true" ]; then
  cleanup-pre
fi

for vol in $(echo $OS_VOLUMES | tr ',' '\n'); do
  now=$(date +%Y%m%d%H%M%S)
  if [ "$DRY_RUN" = "true" ]; then
    echo "would create snapshot ${now}-$vol"
    continue
  fi
  echo "snapshoting vol $vol"
  cinder snapshot-create \
    --force=True \
    --metadata createdBy=ovh-snapshoter snapshotOf=$vol snapshotedAt=${now} \
    --name "${now}-$vol" "$vol"
done

# defer real cleanup of snapshots
if [ "$CLEANUP" = "true" ]; then
  cleanup-post
fi
