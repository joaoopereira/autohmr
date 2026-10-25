# Project rules

- Everything in the repo is in English (commits, branches, PRs, comments, README and other docs). Only the visitor-facing site text in `index.html` is Portuguese.
- Commits follow Conventional Commits (`type(scope): description`); see `CONTRIBUTING.md` for allowed types. `scripts/check-commits.sh <base> <head>` validates a range.
- History is linear: rebase, never merge; no merge commits on `main` or `development`.
- Do not edit `CHANGELOG.md` or `version.txt` by hand; release-please generates them from the commits on `main`.
