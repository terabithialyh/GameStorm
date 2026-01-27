# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Single-file HTML5 mobile merge puzzle game (时尚逆袭：璀璨之星). No build system - entire application in `index.html`.

## Development

### Quick Start (推荐)
```bash
# 启动服务器 (自动安装依赖、打开浏览器)
./start.sh

# 停止服务器
./stop.sh

# 使用自定义端口
./start.sh 3000
```

### NPM Commands
```bash
# Install dependencies (first time only)
npm install

# Start development server (opens browser automatically)
npm start

# Start dev server with no cache (for development)
npm run dev

# Start server without opening browser
npm run serve
```

Server runs on http://localhost:8000

**Shell Scripts Features:**
- Automatic dependency installation
- PID management (prevents duplicate servers)
- Port conflict detection
- Auto-open browser
- Background process with logging (server.log)

## Architecture

### Single-File Structure (index.html - 702 lines)
- **Lines 13-294**: CSS with custom properties
- **Lines 296-331**: HTML (header, 6x7 grid, footer, modals)
- **Lines 333-702**: JavaScript game logic

### Tech Stack
- Vanilla JavaScript (ES6+)
- Tailwind CSS (CDN)
- GSAP 3.12.2 (animations via CDN)

### State Management (line 351)
Centralized imperative state object:
```javascript
let state = {
    energy: 100,
    gold: 0,
    level: 1,
    grid: Array(42),  // 6x7 board
    tasks: [],
    // ... drag state
}
```

### Core Systems

**Grid System**: 6x7 (42 cells), drag-and-drop merge mechanics
- `renderGrid()` (lines 598-603) - Manual DOM updates
- `attemptMerge()` (lines 573-588) - Merge logic

**Animation System**: `Animator` object (lines 409-532)
- Uses GSAP for all animations
- Methods: `mergeJuice()`, `flyGold()`, `createParticleBurst()`, etc.

**Task System**: (lines 604-695)
- Dynamic generation based on player level
- Horizontal scrolling with enter/exit animations
- `checkTaskCompletion()` (lines 590-596) scans grid

**Resource Management**:
- Energy: 10 per spawn, regenerates 1/120s (lines 387-392)
- Gold: Earned from tasks
- Level: Increments with task completion

### Key Entry Points
- `window.onload = init` (line 701)
- `init()` (lines 370-395) - Creates grid, attaches listeners
- `spawnItem()` (lines 397-407) - Adds items to board
- Pointer event handlers (lines 534-571) - Drag logic

## Making Changes

**Item levels**: Edit `SVG_LIB` (lines 334-343)

**Game balance**: Edit `CONFIG` (lines 345-349)
- `SPAWN_COST`, `ENERGY_REGEN_INTERVAL`, `ENERGY_REGEN_AMOUNT`

**Grid size**: Update `state.grid` size (line 354), `init()` loop (line 373), CSS `.board-grid` (line 127)

**Animations**: Add methods to `Animator` object using GSAP

## Code Style
- No semicolons (ASI style)
- Arrow functions preferred
- Template literals for strings
- Imperative DOM manipulation (`innerHTML`, `classList`, `style`)
