#!/bin/bash

# 启动服务器脚本
# Usage: ./start.sh [port]

PORT=${1:-8000}
PID_FILE=".server.pid"

# 检查是否已经在运行
if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    if ps -p $PID > /dev/null 2>&1; then
        echo "❌ 服务器已经在运行 (PID: $PID)"
        echo "   访问地址: http://localhost:$PORT"
        exit 1
    else
        # PID 文件存在但进程不存在，清理旧文件
        rm "$PID_FILE"
    fi
fi

# 检查端口是否被占用
if lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null 2>&1; then
    echo "❌ 端口 $PORT 已被占用"
    echo "   请使用其他端口: ./start.sh <port>"
    exit 1
fi

# 检查 node_modules 是否存在
if [ ! -d "node_modules" ]; then
    echo "📦 首次运行，正在安装依赖..."
    npm install
fi

# 启动服务器
echo "🚀 正在启动服务器..."
nohup npm run serve -- -p $PORT > server.log 2>&1 &
SERVER_PID=$!

# 保存 PID
echo $SERVER_PID > "$PID_FILE"

# 等待服务器启动
sleep 2

# 检查服务器是否成功启动
if ps -p $SERVER_PID > /dev/null 2>&1; then
    echo "✅ 服务器启动成功!"
    echo "   PID: $SERVER_PID"
    echo "   本地访问: http://localhost:$PORT"
    echo "   日志文件: server.log"
    echo ""
    echo "💡 使用 ./stop.sh 停止服务器"

    # 自动打开浏览器
    if command -v open > /dev/null 2>&1; then
        open "http://localhost:$PORT"
    elif command -v xdg-open > /dev/null 2>&1; then
        xdg-open "http://localhost:$PORT"
    fi
else
    echo "❌ 服务器启动失败"
    echo "   查看日志: cat server.log"
    rm "$PID_FILE"
    exit 1
fi
