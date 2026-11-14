#!/bin/bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

# Existing selected snapshots must remain unchanged during a dry run.
cinder() {
	case "$*" in
	"--os-volume-api-version 3.59 snapshot-list --metadata createdBy=ovh-snapshoter" | \
		"--os-volume-api-version 3.59 snapshot-list --metadata cleanup=true")
		printf '| 11111111-1111-4111-8111-111111111111 | existing-snapshot |\n'
		;;
	"--os-volume-api-version 3.59 snapshot-metadata-show 11111111-1111-4111-8111-111111111111")
		printf '| snapshotOf | test-volume |\n'
		;;
	*)
		echo "Unexpected Cinder command during dry run: $*" >&2
		return 1
		;;
	esac
}
export -f cinder

export OS_AUTH_URL=https://example.invalid/v3 OS_IDENTITY_API_VERSION=3
export OS_PROJECT_DOMAIN_NAME=Default OS_USER_DOMAIN_NAME=Default
export OS_PASSWORD=test OS_PROJECT_ID=test OS_REGION_NAME=test
export OS_TENANT_ID=test OS_TENANT_NAME=test OS_USERNAME=test OS_VOLUMES=test-volume

output=$(DRY_RUN=true CLEANUP=true bash entrypoint.sh)
grep -q 'would mark snapshot 11111111-1111-4111-8111-111111111111 for cleanup' <<<"$output"
grep -q 'would create snapshot .*test-volume' <<<"$output"
grep -q 'would remove snapshot with id=11111111-1111-4111-8111-111111111111' <<<"$output"
echo 'Dry run preserved the existing snapshot.'
