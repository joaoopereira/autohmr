#!/usr/bin/env bash
# Checks that a commit range is linear and follows Conventional Commits.
# Usage: scripts/check-commits.sh <base> <head> [pr-title]
set -euo pipefail

base=$1
head=$2
title=${3:-}

pattern='^(feat|fix|perf|revert|docs|style|refactor|test|build|ci|chore)(\([a-z0-9._/-]+\))?!?: [^ ].{0,71}$'
status=0

check() {
  local label=$1 header=$2
  if ! grep -Eq "$pattern" <<<"$header"; then
    echo "::error::$label is not a Conventional Commit: $header"
    status=1
  fi
}

merges=$(git rev-list --merges "$base..$head")
if [ -n "$merges" ]; then
  for sha in $merges; do
    echo "::error::Merge commit $sha breaks linear history; rebase instead of merging."
  done
  status=1
fi

for sha in $(git rev-list --no-merges "$base..$head"); do
  check "Commit ${sha:0:7}" "$(git log -1 --format=%s "$sha")"
done

if [ -n "$title" ]; then
  check "PR title" "$title"
fi

exit $status
