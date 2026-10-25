# Auto HMR

Single-page website for the **Auto HMR — Reparação e Comércio Automóvel** garage (Campo, Valongo).

Static HTML + CSS, no build step.

```
index.html            page
assets/css/style.css  styles (brand colours in :root)
assets/img/           logo (SVG), favicon and social sharing image
_headers              HTTP headers for Cloudflare Pages
```

## Local development

```sh
python3 -m http.server 8000
# open http://localhost:8000
```

## Deploying to Cloudflare Pages

1. Cloudflare Dashboard → **Workers & Pages** → **Create** → **Pages** → **Connect to Git**.
2. Pick the `joaoopereira/autohmr` repository and the production branch (`main`).
3. Build settings:
   - Framework preset: **None**
   - Build command: *(empty)*
   - Build output directory: `/`
4. **Save and Deploy**.
5. Under **Custom domains**, add `autohmr.pt` (and `www.autohmr.pt`).

Every push to the production branch deploys automatically; other branches get preview deployments.

CLI alternative: `npx wrangler pages deploy . --project-name autohmr`.

## Editing content

The address, phone number, email and opening hours live in `index.html` (the `#contactos` section) and also in the JSON-LD block in `<head>` — update both.

The site content itself is in Portuguese; everything else in the repository (code, comments, docs, commits) is in English.

## Contributing and releases

See [CONTRIBUTING.md](CONTRIBUTING.md) for the commit conventions and release process, and [CHANGELOG.md](CHANGELOG.md) for the release history.
