# Repository Guidelines

## Project Structure & Module Organization

GameStorm is a static HTML5 mini‑games collection (no build step). Each game is self-contained in a single HTML file:

- `index.html` — root navigation page that links to each game.
- `FashionMatch/index.html` — match‑3 game.
- `Merge2/index.html` + `Merge2/README.md` — merge game (DOM + animations).
- `MagicBean/index.html` — vertical platformer.
- `JumpUp/index.html` — vertical jumping game.
- `start.sh` / `stop.sh` — local server helpers (PID + logs).
- `package.json` — dev dependency on `http-server`.

When adding/removing a game, update the root `index.html` cards and (if applicable) `CLAUDE.md`.

## Build, Test, and Development Commands

- `./start.sh [port]` — starts `http-server` (default `8000`), writes `.server.pid`, logs to `server.log`.
- `./stop.sh` — stops the server using `.server.pid`.
- `npm start` — starts server on `8000` and opens a browser tab.
- `npm run dev` — server on `8000` with no-cache (`-c-1`), useful while editing.
- `npm run serve` — server only (no browser open).

## Coding Style & Naming Conventions

- Keep the single-file architecture: HTML/CSS/JS in each game’s `index.html`.
- Use 4-space indentation and the existing inline style patterns in each file.
- Prefer clear, descriptive names (`gameState`, `CONFIG`, `renderGrid`) over abbreviations.
- Avoid introducing new toolchains (bundlers, transpilers) unless explicitly agreed.

## Testing Guidelines

There is no automated test suite. Do a quick manual smoke check:

- Run `./start.sh` and open `http://localhost:8000/`.
- Launch each game and verify there are no console errors and touch/mouse controls work.

## Commit & Pull Request Guidelines

Recent history uses short, imperative summaries (English or Chinese), e.g. “Add …”, “Restructure …”, “Remove …”.

For PRs:

- Describe what changed and why; include screenshots/GIFs for UI changes.
- Confirm you updated `index.html` navigation when a game is added/removed.
- Note manual smoke-check steps and the port used (e.g. `8000`).

## Agent-Specific Instructions

- 请与我用中文对话。
- 本仓库后续由 Agent 生成的文档（如 `README.md`、设计说明、变更说明等）请使用中文撰写。
