@AGENTS.md

# Claude Code adapter

Shared project guidance lives in [AGENTS.md](AGENTS.md). This file contains only Claude Code-specific discovery and configuration notes.

## Agents

Project agents live in [`.claude/agents/`](.claude/agents/):

- `code-reviewer` performs read-only review against the repository rules and requested scope.
- `svelte-ui-expert` handles route architecture, component boundaries, static builds, assets, and multi-file migration work.
- `svelte-file-editor` handles individual `.svelte`, `.svelte.ts`, and `.svelte.js` files and validates them with the Svelte MCP server.

The same roles have counterparts under [`.codex/agents/`](.codex/agents/). Keep same-named manifests aligned while leaving shared methodology in `AGENTS.md`.

## Svelte MCP

[`.mcp.json`](.mcp.json) registers Svelte's first-party MCP server. Use it to discover and fetch current documentation, and run `svelte-autofixer` on changed Svelte code before finishing. Codex uses the matching server entry in [`.codex/config.toml`](.codex/config.toml).

## First-party Svelte skills

The `sv add ai-tools` output is stored canonically under [`.agents/skills/`](.agents/skills/):

- `svelte-core-bestpractices` provides Svelte 5 authoring guidance and progressive-disclosure references.
- `svelte-code-writer` documents the `npx @sveltejs/mcp` fallback workflow.

Claude discovers the same files through relative symlinks under [`.claude/skills/`](.claude/skills/). Treat the generated skills and [`.claude/agents/svelte-file-editor.md`](.claude/agents/svelte-file-editor.md) as vendored first-party output; regenerate them with `sv`, never hand-edit them.

## Permissions

Project-wide Claude Code permissions live in [`.claude/settings.json`](.claude/settings.json). Their command policy is mirrored for Codex in [`.codex/rules/default.rules`](.codex/rules/default.rules), subject to each tool's configuration format.

Keep machine-specific grants out of the repository. Do not add AI co-author trailers, create commits, or perform branch operations.
