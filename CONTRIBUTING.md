# Contributing

## Language

Everything in the repository is written in English: commit messages, branch names, pull requests, code comments, the README and any other written instructions or docs.
The only exception is the website content itself (the text visitors read in `index.html`), which is in Portuguese.

## Commit messages

Commits follow [Conventional Commits 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/):

```
<type>[optional scope][!]: <description>

[optional body]

[optional footer(s)]
```

Allowed types:

| Type       | Use for                                             | Release impact |
|------------|-----------------------------------------------------|----------------|
| `feat`     | a new feature or visible content/section            | minor          |
| `fix`      | a bug fix or content correction                     | patch          |
| `perf`     | a performance improvement                           | patch          |
| `revert`   | reverting a previous commit                         | patch          |
| `docs`     | documentation only                                  | none           |
| `style`    | formatting that does not change behaviour           | none           |
| `refactor` | code change that is neither a fix nor a feature     | none           |
| `test`     | adding or fixing tests                              | none           |
| `build`    | build system or dependencies                        | none           |
| `ci`       | CI configuration                                    | none           |
| `chore`    | anything else that doesn't touch the site           | none           |

A `!` after the type/scope, or a `BREAKING CHANGE:` footer, marks a breaking change (major bump).

Rules:

- Description in the imperative mood, lower case, no trailing period, header up to 72 characters.
- Examples: `feat(contacts): add WhatsApp link`, `fix: correct Saturday opening hours`, `docs: explain release process`.

## Linear history

`main` and `development` must have a strictly linear history — no merge commits.

- Update your branch with `git rebase`, never `git merge` (`git config pull.rebase true` helps).
- Pull requests are merged with **Squash and merge** or **Rebase and merge** only. When squashing, the PR title becomes the commit message, so it must also follow Conventional Commits.
- The `Commit lint` workflow rejects pull requests that contain merge commits or non-conventional commit messages or titles.

Recommended repository settings (GitHub → Settings):

- **General → Pull Requests**: disable *Allow merge commits*; keep *Allow squash merging* and *Allow rebase merging*.
- **Rules / Branch protection** for `main` and `development`: enable *Require linear history* and require the `Commit lint` check.
- **Actions → General**: enable *Allow GitHub Actions to create and approve pull requests* (needed by the release workflow).

## Branches

- `main` — production; Cloudflare Pages deploys it to `autohmr.pt`.
- `development` — integration branch; changes land here first and reach `main` by fast-forward (or rebase).

## Versioning and changelog

The project uses [Semantic Versioning](https://semver.org/). The current version is in `version.txt` and the release history in `CHANGELOG.md`.

Releases are generated automatically with [release-please](https://github.com/googleapis/release-please) from the commit history:

1. On every push to `main`, the `Release` workflow opens (or updates) a release PR titled `chore(main): release X.Y.Z`, which bumps `version.txt` and adds the new section to `CHANGELOG.md` from the `feat`, `fix`, `perf` and `revert` commits since the last release.
2. Merging that PR (squash) creates the `vX.Y.Z` tag and the GitHub release.
3. Bring `development` back in line with `main` afterwards (`git checkout development && git rebase origin/main && git push`).

Never edit released `CHANGELOG.md` sections by hand; fix the commit history going forward instead.
