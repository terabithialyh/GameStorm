# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

GameStorm is a collection of two HTML5 mobile puzzle games built with vanilla JavaScript:

1. **Fashion Match** (时尚消消乐) - Root `index.html` - Match-3 puzzle game
2. **Merge2** (时尚逆袭：璀璨之星) - `Merge2/index.html` - Merge puzzle game

Both games use a **single-file architecture** with no build system. All HTML, CSS, and JavaScript are contained in their respective `index.html` files.

## Development Commands

### Fashion Match (Root Game)
```bash
# Open directly in browser (no server needed)
open index.html

# Or serve with any static server
python3 -m http.server 8080
# Then visit http://localhost:8080
```

### Merge2 Game
```bash
cd Merge2

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

## Architecture

### Two Different Approaches

| Aspect | Fashion Match | Merge2 |
|--------|--------------|--------|
| **File** | `index.html` (434 lines) | `Merge2/index.html` (799 lines) |
| **Pattern** | Class-based OOP | Imperative + Functional modules |
| **Rendering** | HTML5 Canvas 2D API | DOM manipulation |
| **Animation** | Manual (requestAnimationFrame) | GSAP 3.12.2 library |
| **Styling** | Inline CSS | Tailwind CSS (CDN) |
| **Graphics** | Emoji characters | Inline SVG library |
| **Grid** | 7×9 (63 cells) | 6×7 (42 cells) |

### Fashion Match Architecture

**Entry Point:** `index.html:430` - `const game = new Game()`

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

**Entry Point:** `Merge2/index.html:798` - `window.onload = init`

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

## Making Changes

### Fashion Match

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

### Shell Scripts (Merge2 only)

**start.sh features:**
- Automatic `npm install` if needed
- PID management (prevents duplicate servers)
- Port conflict detection
- Auto-open browser
- Background process with logging to `server.log`
- Uses `npx http-server` directly to avoid port duplication issues

**stop.sh features:**
- Graceful server shutdown
- PID cleanup

**Note:** The script uses `npx http-server` directly instead of npm scripts to allow dynamic port configuration.

## File Structure

```
GameStorm/
├── index.html              # Fashion Match game (434 lines)
├── CLAUDE.md               # This file
└── Merge2/
    ├── index.html          # Merge2 game (799 lines)
    ├── package.json        # Dev dependencies (http-server)
    ├── start.sh            # Server startup script
    ├── stop.sh             # Server shutdown script
    ├── README.md           # Project documentation
    ├── CLAUDE.md           # Merge2-specific guide
    └── node_modules/       # Dependencies (http-server)
```

## Common Patterns

### Adding New Features

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
