# Project rules

- Everything in the repo is in English (commits, branches, PRs, comments, README and other docs). Only the visitor-facing site text in `index.html` is Portuguese.
- Commits follow Conventional Commits (`type(scope): description`); see `CONTRIBUTING.md` for allowed types. `scripts/check-commits.sh <base> <head>` validates a range.
- History is linear: rebase, never merge; no merge commits on `main` or `development`.
- A release is promoting `development` to `main` (fast-forward). Before promoting, run `scripts/changelog.sh <version>` and commit `chore(release): <version>`; see `CONTRIBUTING.md`.
