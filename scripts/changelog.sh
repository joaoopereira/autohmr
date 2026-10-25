#!/usr/bin/env bash
# Adds a section for a new release to CHANGELOG.md from the Conventional
# Commits since the last `chore(release)` commit.
# Usage: scripts/changelog.sh <version>
set -euo pipefail

version=${1:?usage: scripts/changelog.sh <version>}
last=$(git log -1 --format=%H --grep='^chore(release): ')
range=${last:+$last..}HEAD

section=$(npx -y git-cliff@2.6.1 --strip header --tag "v$version" "$range")
if [ -z "$section" ]; then
  echo "No feat/fix/perf/revert commits since the last release." >&2
  exit 1
fi

# Insert the new section before the previous release, keeping the header.
awk -v section="$section" '
  !done && /^## / { print section "\n"; done = 1 }
  { print }
  END { if (!done) print "\n" section }
' CHANGELOG.md > CHANGELOG.md.tmp
mv CHANGELOG.md.tmp CHANGELOG.md
echo "Added v$version to CHANGELOG.md"
