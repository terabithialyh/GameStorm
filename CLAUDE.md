# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

GameStorm is a collection of HTML5 mobile puzzle games built with vanilla JavaScript:

1. **Fashion Match** (时尚消消乐) - `FashionMatch/index.html` - Match-3 puzzle game
2. **Merge2** (时尚逆袭：璀璨之星) - `Merge2/index.html` - Merge puzzle game
3. **MagicBean** (魔豆登天) - `MagicBean/index.html` - Vertical platformer game

All games use a **single-file architecture** with no build system. All HTML, CSS, and JavaScript are contained in their respective `index.html` files.

## Development Commands

### Start All Games (Root Level)
```bash
# Recommended: Use shell scripts
./start.sh              # Auto-installs deps, opens browser on port 8000
./start.sh 3000         # Use custom port
./stop.sh               # Stop server gracefully

# Alternative: Use npm
npm install             # First time only
npm start               # Start with browser (port 8000)
npm run dev             # No-cache mode for development
npm run serve           # Server only (no browser)
```

Server runs on http://localhost:8000 and serves:
- Navigation page: http://localhost:8000/
- Fashion Match: http://localhost:8000/FashionMatch/
- Merge2: http://localhost:8000/Merge2/

**Shell Scripts Features:**
- Automatic dependency installation
- PID management (prevents duplicate servers)
- Port conflict detection
- Auto-open browser
- Background process with logging to `server.log`
- Uses `npx http-server` directly to allow dynamic port configuration

## Architecture

### Two Different Approaches

| Aspect | Fashion Match | Merge2 | MagicBean |
|--------|--------------|--------|-----------|
| **File** | `FashionMatch/index.html` (434 lines) | `Merge2/index.html` (799 lines) | `MagicBean/index.html` |
| **Pattern** | Class-based OOP | Imperative + Functional modules | Class-based OOP |
| **Rendering** | HTML5 Canvas 2D API | DOM manipulation | HTML5 Canvas 2D API |
| **Animation** | Manual (requestAnimationFrame) | GSAP 3.12.2 library | Mixed (Lerp + rAF) |
| **Styling** | Inline CSS | Tailwind CSS (CDN) | Inline CSS |
| **Graphics** | Emoji characters | Inline SVG library | HTML5 Canvas Shapes |
| **Grid** | 7×9 (63 cells) | 6×7 (42 cells) | Infinite Vertical |

### Fashion Match Architecture

**Location:** `FashionMatch/index.html`

**Entry Point:** Line 430 - `const game = new Game()`

**Core Class:** `Game` (lines 121-413)
- Canvas-based rendering engine
- Match-3 detection algorithm (horizontal/vertical)
- Gravity system with cascade mechanics
- Touch and mouse input support

**Key Methods:**
- `handleClick()` (lines 175-203) - Input processing
- `swapTiles()` (lines 205-234) - Async tile exchange with validation
- `findMatches()` (lines 236-283) - Detect 3+ matches
- `applyGravity()` (lines 285-318) - Drop tiles to fill gaps
- `processMatches()` (lines 320-362) - Chain reaction handler

**Game Loop:** RequestAnimationFrame-based continuous rendering (lines 409-412)

### Merge2 Architecture

**Location:** `Merge2/index.html`

**Entry Point:** Line 798 - `window.onload = init`

**State Management:** Centralized object (lines 349-361)
```javascript
let state = {
    energy: 100,        // Regenerates 1/120s
    gold: 0,
    level: 1,
    grid: Array(42),    // 6x7 board
    tasks: [],
    // ... drag state
}
```

**Core Systems:**
- **Grid System** (lines 661-675): DOM-based rendering with `renderGrid()`
- **Animator Module** (lines 407-532): GSAP-powered effects
  - `createParticleBurst()`, `mergeJuice()`, `flyGold()`, `flyIntoBoard()`
- **Drag System** (lines 551-594): Pointer event handlers
- **Merge Logic** (lines 596-648): Item combination rules
- **Task System** (lines 677-750): Dynamic quest generation
- **Story System** (lines 363-367, 751-795): Narrative progression

**SVG Assets:** 8-level item library (lines 332-341)
- Hanger → Perfume → Lipstick → Bag → Dress → Heels → Gown → Crown

**Key Functions:**
- `init()` (lines 370-395) - Setup grid, listeners, energy regen
- `spawnNewItem()` - Add level 1 item (costs 10 energy)
- `handleMergeLogic()` - Merge two items or move to empty cell
- `checkTaskCompletion()` - Scan grid for quest items
- `showStory()` - Display narrative cutscenes

- `checkTaskCompletion()` - Scan grid for quest items
- `showStory()` - Display narrative cutscenes

### MagicBean Architecture

**Location:** `MagicBean/index.html`

**Entry Point:** `window.onload` -> `new Game()`

**Core Classes:**
- `Game`: Main controller, loop, UI state
- `Player`: Physics, jumping logic, stun state
- `Beanstalk`: Procedural leaf generation
- `Utils`: Helper functions (Lerp, random)

**Key Mechanics:**
- **Procedural Generation:** `Beanstalk.generate()` creates path ahead
- **Input Handling:** Screen split into Left/Right touch zones
- **Camera Logic:** Smoothly follows player height (`cameraY` lerp)
- **Audio:** Web Audio API oscillator for simple generated SFX

## Making Changes

### Fashion Match

**File:** `FashionMatch/index.html`

**Modify grid size:**
- Update `ROWS` and `COLS` constants (lines 123-124)
- Adjust canvas dimensions in CSS (lines 30-34)

**Change tile types:**
- Edit `TILE_TYPES` array (line 125) - Currently uses emoji
- Update `COLORS` array (line 126) for background colors

**Adjust game balance:**
- Match detection: `findMatches()` (lines 236-283)
- Gravity speed: `applyGravity()` (lines 285-318)
- Score multiplier: `processMatches()` (lines 320-362)

### Merge2

**File:** `Merge2/index.html`

**Modify item levels:**
- Edit `SVG_LIB` object (lines 332-341)
- Add/remove SVG definitions for new items

**Adjust game balance:**
- Edit `CONFIG` object (lines 343-347):
  - `SPAWN_COST`: Energy cost per spawn (default: 10)
  - `ENERGY_REGEN_INTERVAL`: Milliseconds between regen (default: 120000)
  - `ENERGY_REGEN_AMOUNT`: Energy per regen tick (default: 1)

**Change grid size:**
- Update `state.grid` array size (line 354)
- Modify `init()` loop (line 373)
- Adjust CSS `.board-grid` (line 127) - Currently `grid-template-columns: repeat(6, 1fr)`

**Add animations:**
- Add methods to `Animator` object (lines 407-532) using GSAP
- Example: `Animator.newEffect = (x, y) => { gsap.to(...) }`

**Modify tasks:**
- Edit `createTasks()` function (lines 677-750)
- Task structure: `{ id, desc, targetLevel, targetCount, reward }`

### MagicBean

**File:** `MagicBean/index.html`

**Adjust Difficulty:**
- Modify `CONFIG` object:
  - `GAME_DURATION`: Time limit (default 60s)
  - `GRAVITY`: Fall speed (unused for climbing but used for visual)
  - `STUN_DURATION`: Penalty time for missing jump (ms)
  - `SCROLL_SPEED`: Camera smooting

**Visuals:**
- Update `ASSETS.COLORS` for theming
- `Beanstalk.drawLeaf()` to change leaf shapes

### Navigation Page

**File:** `index.html` (root)

Simple landing page with game cards. To add a new game:
1. Create new game folder with `index.html`
2. Add game card to navigation page
3. Update this documentation

## Code Style

### Fashion Match
- Semicolons used
- Class-based OOP
- Traditional function declarations
- Canvas API patterns

### Merge2
- No semicolons (ASI style)
- Arrow functions preferred
- Template literals for strings
- Imperative DOM manipulation (`innerHTML`, `classList`, `style`)

### Navigation Page
- Inline CSS (no external dependencies)
- Gradient background
- Card-based responsive layout
- Mobile-first design

## Technical Notes

### Fashion Match
- Mobile-first responsive (9:16 aspect ratio)
- Touch and mouse events both supported
- Canvas coordinate transformation for input
- Cascade matching with score multipliers
- No external dependencies

### Merge2
- PWA-ready with fullscreen support
- Safe area insets for notched devices
- Energy regeneration (idle game mechanic)
- Particle effects and "juice" animations
- Task/quest system with rewards
- Story-driven progression
- Dependencies: Tailwind CSS, GSAP (both via CDN)

## File Structure

```
GameStorm/
├── index.html              # Navigation/landing page
├── package.json            # Dev dependencies (http-server)
├── start.sh                # Server startup script
├── stop.sh                 # Server shutdown script
├── .server.pid             # Server PID file (generated)
├── server.log              # Server log file (generated)
├── node_modules/           # Dependencies (generated)
├── .gitignore              # Git ignore rules
├── CLAUDE.md               # This file
├── FashionMatch/           # Fashion Match game folder
│   └── index.html          # Game file (434 lines)
└── Merge2/                 # Merge2 game folder
    ├── index.html          # Game file (799 lines)
    ├── CLAUDE.md           # Game-specific architecture docs
    └── README.md           # Game description
```

**Key Design Decisions:**
- All deployment infrastructure at root level
- Game folders contain ONLY game files (HTML, assets)
- Single `npm install` at root serves all games
- Single server instance serves all games
- Easy to add new games (create folder + add to navigation)

## Common Patterns

### Adding New Features to Games

Both games follow similar patterns for new features:

1. **Read the entire file first** - Everything is in one HTML file
2. **Locate the relevant section:**
   - CSS: Top of `<style>` tag
   - HTML: Inside `<body>` tag
   - JavaScript: Bottom `<script>` tag
3. **Follow existing patterns:**
   - Fashion Match: Add methods to `Game` class
   - Merge2: Add functions or extend `Animator` object
4. **Test in browser** - No build step needed, just refresh

### Adding New Games

1. Create new folder in root (e.g., `NewGame/`)
2. Add `index.html` with game code
3. Update root `index.html` to add game card
4. Update this CLAUDE.md with game documentation

### Debugging

Both games use browser DevTools:
- Console logs for state inspection
- Canvas inspector for Fashion Match
- DOM inspector for Merge2
- Network tab (Merge2 only - for CDN resources)

### Performance Considerations

**Fashion Match:**
- Canvas rendering is efficient for 63 cells
- Avoid excessive `clearRect()` calls
- Use `requestAnimationFrame` for smooth animations

**Merge2:**
- DOM manipulation can be expensive
- GSAP handles animation performance
- Minimize `renderGrid()` calls
- Use CSS transforms for smooth drag feedback

