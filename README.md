# GameStorm

一个纯前端的 HTML5 迷你游戏合集仓库。所有游戏都采用**单文件架构**：每个游戏目录下只有一个 `index.html`（包含 HTML / CSS / JS），无需构建步骤，开箱即用。

## 在线入口（本地运行后）

启动本地服务器后：

- 项目索引页：`http://localhost:8000/`
- 各游戏：`http://localhost:8000/<GameDir>/`

## 游戏列表

| 游戏 | 目录 | 简介 |
|---|---|---|
| Fashion Match（时尚消消乐） | `FashionMatch/` | 经典三消玩法（Canvas 2D） |
| Merge2（时尚逆袭：璀璨之星） | `Merge2/` | 拖拽合成 + 任务系统（DOM + 动画） |
| MagicBean（魔豆登天） | `MagicBean/` | 向上攀登的平台挑战（Canvas 2D） |
| JumpUp（跳跳芭蕉树） | `JumpUp/` | 左右跳跃闯关（Canvas 2D） |

对应的导航入口维护在根目录 `index.html`。

## 目录结构

```text
.
├── index.html            # 游戏导航页
├── FashionMatch/         # 游戏：时尚消消乐
├── Merge2/               # 游戏：合成玩法（含 Merge2/README.md）
├── MagicBean/            # 游戏：魔豆登天
├── JumpUp/               # 游戏：跳跳芭蕉树
├── start.sh / stop.sh    # 启停本地静态服务器
├── package.json          # http-server 开发依赖
└── CLAUDE.md             # 项目架构/开发说明（更偏实现细节）
```

## 本地运行

### 方式 A：脚本启动（推荐）

```bash
./start.sh          # 默认端口 8000
./start.sh 3000     # 自定义端口
./stop.sh           # 停止服务器
```

脚本会：

- 首次运行自动 `npm install`
- 使用 `npx http-server` 启动静态服务
- 写入 `.server.pid`，日志输出到 `server.log`

> 注：`start.sh` 依赖 `bash`/`lsof`/`nohup`，在 Windows 上可能不可用，可改用下面的 npm 命令。

### 方式 B：npm 命令

```bash
npm install
npm start       # http-server -p 8000 -o（自动打开浏览器）
npm run dev     # 禁用缓存（-c-1），开发更方便
npm run serve   # 仅启动服务，不自动打开浏览器
```

## 开发约定

- 每个游戏尽量保持“单文件”与“零构建”原则：优先只改对应目录的 `index.html`
- 新增/删除游戏时请同步更新：
  - 根目录 `index.html` 的卡片导航
  - `CLAUDE.md`（若需要反映项目概览/架构对比）

更详细的协作/风格约定见 `AGENTS.md`。

## License

MIT

