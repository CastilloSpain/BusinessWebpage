# AGENTS.md

> Canonical, platform-agnostic guidance for AI coding assistants working in this repository.
>
> Codex reads this file directly. Claude Code imports it from [CLAUDE.md](CLAUDE.md). Tool-specific files configure permissions and agents; shared project guidance belongs here.

## 1. Mission

This repository is a real-estate website being migrated from a static HTML template to a standalone SvelteKit application.

The immediate priority is a faithful, maintainable conversion of the existing site. Preserve its content, visual identity, URLs, metadata, responsive behavior, and working interactions while replacing page-level HTML duplication with Svelte components and typed local data. Do not redesign the site or add product scope unless the user asks.

The final application is entirely static and deploys to GitHub Pages through GitHub Actions. There is no production backend, database, or companion application in this repository.

## 2. Repository state

The SvelteKit migration has not started yet. The current files are source material for the port:

- Root-level HTML pages: `index.html`, `portfolio-details.html`, `service-details.html`, and `starter-page.html`.
- Shared browser assets under `assets/`, including the current stylesheet, JavaScript, images, fonts, and vendored libraries.
- An existing [GitHub Pages workflow](.github/workflows/static.yml) that currently uploads the repository directly. It must be converted to install and build SvelteKit when the scaffold is introduced.
- Original reference files under `stash/`. Treat these as preserved source material, not runtime application files.
- A development container configured for Node, Svelte tooling, Claude Code, Codex, and port 2275.
- A dual Claude Code/Codex assistant harness rooted in this file.

Until the SvelteKit scaffold exists, do not claim it is operational. When the application layout changes, update this section and [§4](#4-target-application-shape) in the same change.

## 3. Target stack and deployment

| Concern | Choice | Constraint |
| --- | --- | --- |
| Application | SvelteKit 2 with Svelte 5 | TypeScript and runes syntax |
| Build target | `@sveltejs/adapter-static` | No production server runtime |
| Package manager | npm | Root-level `package.json`, lockfile, and `node_modules/` |
| Styling | Existing CSS first | Preserve the current design before considering a styling migration |
| Hosting | GitHub Pages | Deployment is performed by GitHub Actions |
| Source content | Repository files | No runtime content service |

Do not introduce another frontend framework, a server runtime, a database, or a SaaS dependency without explicit user approval.

## 4. Target application shape

The intended root-level SvelteKit layout is:

```text
/
├── src/
│   ├── lib/
│   │   ├── components/       # Reusable site-wide and section components
│   │   ├── data/             # Typed local content shared by routes
│   │   └── utils/            # Shared pure helpers with real consumers
│   ├── routes/               # SvelteKit file-based routes
│   ├── app.css               # Global styles and design tokens
│   ├── app.d.ts
│   └── app.html
├── static/                   # Assets copied unchanged into the built site
├── node_modules/             # Root dependency installation; ignored by Git
├── package.json
├── package-lock.json
├── svelte.config.js
├── vite.config.ts
└── .github/workflows/        # Checks and GitHub Pages deployment
```

Use the conventional SvelteKit root layout. Do not create a nested package or another workspace layer. During migration, move runtime assets into `static/` deliberately and preserve `stash/` as reference material until the user decides it can be removed.

## 5. Application conventions

### 5.1 TypeScript and organization

- Use TypeScript with `strict: true`. Avoid `any`; use `unknown` and narrow it at external boundaries.
- Use 2-space indentation, single quotes in TypeScript and JavaScript, and the repository formatter once configured.
- Prefer editing an existing component or helper over creating a parallel implementation.
- Extract a shared component or utility on the second substantive occurrence of equivalent markup or behavior. Do not abstract a one-off in anticipation of reuse.
- Keep route composition in `src/routes`, reusable rendering in `src/lib/components`, typed local content in `src/lib/data`, and broadly reusable pure helpers in `src/lib/utils`.
- Test files use `.test.ts` or `.test.js`, never `.spec`.
- Comments explain non-obvious constraints or decisions, not code that already explains itself.
- Do not add compatibility shims for the pre-Svelte static implementation. The migration may replace it cleanly once equivalence is verified.

### 5.2 Svelte 5

- Use runes: `$state`, `$derived`, `$derived.by`, `$effect`, `$props`, and `$bindable` where appropriate.
- Do not introduce legacy Svelte syntax: `export let`, `$:` reactive statements, `on:click` event directives, or `<slot>`.
- Destructure props with `let { ... } = $props()` and use prop shorthand in markup.
- Prefer `$derived` for computed values. Reserve `$effect` for actual side effects.
- Prefer component-local state. Use context for state owned by a component subtree; use module-scope rune state only when its lifetime is intentionally application-wide.
- Release timers, listeners, observers, object URLs, and other acquired resources in an effect cleanup or `onMount` teardown.
- Key `{#each}` blocks when identity matters.
- Use semantic landmarks and headings, meaningful alternative text, labeled controls, keyboard operation, and visible focus states.

Use the configured Svelte MCP server for current framework documentation and run `svelte-autofixer` on every changed `.svelte` file before finishing. Load the first-party [`svelte-core-bestpractices`](.agents/skills/svelte-core-bestpractices/SKILL.md) skill for Svelte component or module work. If MCP tools are unavailable, follow the first-party [`svelte-code-writer`](.agents/skills/svelte-code-writer/SKILL.md) skill to use the equivalent `npx @sveltejs/mcp` CLI.

### 5.3 SvelteKit and static output

- Use file-based routing under `src/routes`.
- Generate the production artifact with `adapter-static`; it must have no runtime server dependency.
- Prerender every public route. Do not add `+server.ts`, `+page.server.ts`, form actions, server hooks, or other features requiring a deployed SvelteKit server.
- Use `load` only when route data genuinely benefits from it. Static local content can be imported directly.
- Resolve internal links and asset paths so they work both at the domain root and beneath a GitHub Pages project base path. Use SvelteKit path utilities instead of scattering root-relative URLs.
- Do not read browser globals during server-side prerendering. Gate browser-only behavior with `browser` from `$app/environment` or component lifecycle.
- Prerendering renders routes in a shared Node process. Avoid mutable module state that can leak between routes and become embedded in output.
- Preserve direct navigation and refresh behavior for every route in the deployed artifact. Prefer fully prerendered HTML over an SPA fallback.
- Do not fetch local content from a server at runtime when it can be bundled or prerendered.

### 5.4 Styling and assets

- Treat the existing HTML, CSS, JavaScript, and images as the visual and behavioral baseline.
- Preserve the current design first. Do not introduce a CSS framework, component library, or CSS rewrite unless the user asks.
- Reuse existing assets instead of downloading replacements or generating near-duplicates.
- Prefer semantic component markup over copying entire template sections between routes.
- Replace legacy DOM-manipulation code with Svelte behavior as its owning markup is ported. Do not load two implementations of the same interaction.
- Keep third-party browser libraries only when they still provide real value after componentization. Remove one only after its behavior has been replaced and exercised.
- Optimize assets only when the result remains visually equivalent and the original source is retained or recoverable.

## 6. Porting workflow

Use the current static pages as an executable specification. For each migration slice:

1. Inventory the source page's sections, assets, links, metadata, responsive behavior, and interactive behavior.
2. Identify markup shared with already-ported pages before authoring new components.
3. Port a coherent page or section using Svelte 5 and static-safe paths.
4. Compare the result at desktop and mobile widths against the source page.
5. Exercise navigation, keyboard behavior, forms or outbound actions, animations, and direct route loads.
6. Run the relevant checks and a production build.

Do not delete or overwrite the reference HTML during the early port unless the user explicitly asks. A successful type-check is not evidence of visual or behavioral equivalence.

## 7. Development environment

- Work from `/workspace` in the development container.
- The application package and npm lockfile belong at the repository root. Dependencies install into `/workspace/node_modules`.
- Run the SvelteKit development server on port 2275 and bind it to an address reachable through the devcontainer forwarding configuration.
- The development container setup must install dependencies from the root `package-lock.json` once the scaffold exists. If its current script still expects `src/package.json`, update that script as part of scaffolding rather than adopting a nested package layout.
- Do not add Docker Compose services for this static application.

## 8. GitHub Pages

- Deployment stays in `.github/workflows/` and uses the official Pages actions.
- When SvelteKit is scaffolded, update the workflow to install root dependencies with `npm ci`, run checks as appropriate, build the application, and upload only the generated static output directory.
- Configure the SvelteKit base path from deployment context so project Pages and local root hosting both work. Do not hard-code a repository name into components.
- Keep the deployment artifact free of source files, development configuration, and secrets.
- Validate workflow or path-configuration changes against the built artifact, including nested-route HTML and asset URLs.

## 9. Verification

Before declaring application work complete:

- Run `npm run check` after the SvelteKit scaffold exists.
- Run the configured unit tests for touched logic.
- Run `npm run build` for changes that can affect routes, prerendering, assets, configuration, or deployment.
- Inspect the generated output when base paths, routes, or the Pages workflow change.
- Load and exercise UI changes in a browser at representative desktop and mobile widths.
- Run `svelte-autofixer` on every changed Svelte component and resolve its actionable findings.
- Search the touched scope for duplicated logic and markup that should now be shared.

If a command cannot run because the migration scaffold does not exist yet, state that plainly; do not claim the corresponding verification passed.

## 10. Git and safety

- Git history is human-owned. Assistants must not create or switch branches; commit, amend, merge, rebase, cherry-pick, revert, tag, or stash; push refs; or open pull requests.
- Preserve unrelated user changes in a dirty working tree.
- Do not commit secrets or read local secret files unless the task explicitly requires it.
- Do not recursively delete the repository, `static/`, `assets/`, or `stash/`.
- Confirm exact targets before deleting source or reference assets. Prefer a recoverable move when practical.
- Do not modify GitHub repository settings or trigger a deployment unless the user explicitly requests that external action.

## 11. Documentation

- Documentation must describe files and behavior that actually exist. Mark target-state guidance as target state until implemented.
- Markdown headings form one hierarchy without skipped levels.
- Keep each prose paragraph and list item on one physical line; do not hard-wrap prose.
- Declare a language on every code fence.
- Use repository-relative links in repository documentation.
- Do not reflow unrelated prose during a focused edit.
- Use American English in documentation, comments, and identifiers.

## 12. Dual-harness layout

The two assistant integrations share project rules while keeping tool-specific configuration separate:

```text
SHARED SCOPE AND RULES      AGENTS.md
FIRST-PARTY SVELTE SKILLS  .agents/skills/svelte-*/**
CLAUDE CODE ADAPTER        CLAUDE.md
                           .claude/agents/*.md
                           .claude/skills/svelte-* (symlinks)
                           .claude/settings.json
CODEX ADAPTER              .codex/agents/*.toml
                           .codex/config.toml
                           .codex/rules/*.rules
SVELTE MCP                 .mcp.json (Claude Code)
                           .codex/config.toml (Codex)
```

- Shared project rules belong in this file, not duplicated in agent manifests.
- Same-purpose agents exist as same-named pairs under `.claude/agents/` and `.codex/agents/`; update both sides together.
- Agent manifests stay thin: role, scope, tools, and references to this file.
- Claude Code permissions and Codex execution rules express the same policy in their respective schemas. Keep their destructive Git and filesystem restrictions aligned.
- Svelte documentation and validation come from the first-party MCP server configured in `.mcp.json` and `.codex/config.toml`. Do not vendor framework documentation.
- Svelte's first-party skills are generated by `sv add ai-tools`, stored canonically under `.agents/skills/`, and exposed to Claude through relative symlinks under `.claude/skills/`. Treat their contents as vendored: regenerate them with `sv`; do not hand-edit them.
- The first-party `svelte-file-editor` Claude agent is likewise generated by `sv add ai-tools` and remains byte-identical to that output. The Codex counterpart expresses the same workflow in Codex's required TOML format.
- Do not reference a skill, agent, directory, or command that is absent from the repository.

Current shared Svelte skills:

| Skill | Responsibility |
| --- | --- |
| [`svelte-core-bestpractices`](.agents/skills/svelte-core-bestpractices/SKILL.md) | First-party Svelte 5 authoring guidance with focused reference files |
| [`svelte-code-writer`](.agents/skills/svelte-code-writer/SKILL.md) | First-party CLI fallback for documentation lookup and autofixer validation |

Current paired agents:

| Agent | Responsibility |
| --- | --- |
| `code-reviewer` | Read-only review against this file and the requested scope |
| `svelte-ui-expert` | Route architecture, component boundaries, static build, styling, assets, and migration slices |
| `svelte-file-editor` | Individual Svelte component or module authoring with MCP documentation and autofixer validation |
