# Contributing

## Language

Everything in the repository is written in English: commit messages, branch names, pull requests, code comments, the README and any other written instructions or docs.
The only exception is the website content itself (the text visitors read in `public/index.html`), which is in Portuguese.

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

## Branches

- `main` — production; Cloudflare Pages deploys it to `autohmr.pt`.
- `development` — integration branch; all changes land here first.

## Releases and changelog

A release is promoting `development` to `main`. Versions follow [Semantic Versioning](https://semver.org/) and are recorded in `CHANGELOG.md`, generated from the commits with [git-cliff](https://git-cliff.org/) (config in `cliff.toml`).

1. On `development`, pick the next version (`feat` → minor, `fix`/`perf` → patch, breaking change → major) and add its changelog section:
   ```sh
   scripts/changelog.sh 1.1.0
   git add CHANGELOG.md
   git commit -m "chore(release): 1.1.0"
   git push origin development
   ```
2. Fast-forward `main` to `development`:
   ```sh
   git push origin development:main
   ```

The script lists the `feat`, `fix`, `perf` and `revert` commits since the last `chore(release)` commit, so that commit message format matters. Don't edit released sections of `CHANGELOG.md` by hand.
