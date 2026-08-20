# Castillo Real Estate Group Holdings

Static SvelteKit 2 and Svelte 5 site for Castillo Real Estate Group Holdings LLC. The main page is componentized under `src/lib/components`, local content is typed under `src/lib/data`, and Tailwind CSS v4 provides the styling layer.

## Development

Install dependencies at the repository root:

```sh
npm ci
```

Run the development server on the devcontainer's forwarded port, `2275`:

```sh
npm run dev
```

## Verification

npm run check
npm run lint
npm run build

```

The static production artifact is written to `build/`. Set `BASE_PATH` during the build for GitHub Pages project-site deployment.

The original HTML template and vendor files under `_legacy-starters/` are preserved as reference-only source material and are not part of the runtime build.
```
