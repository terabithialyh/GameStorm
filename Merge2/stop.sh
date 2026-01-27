#!/bin/bash

# 停止服务器脚本
# Usage: ./stop.sh

PID_FILE=".server.pid"

# 检查 PID 文件是否存在
if [ ! -f "$PID_FILE" ]; then
    echo "❌ 未找到运行中的服务器"
    echo "   (PID 文件不存在)"
    exit 1
fi

# 读取 PID
PID=$(cat "$PID_FILE")

# 检查进程是否存在
if ! ps -p $PID > /dev/null 2>&1; then
    echo "❌ 服务器进程不存在 (PID: $PID)"
    echo "   清理 PID 文件..."
    rm "$PID_FILE"
    exit 1
fi

# 停止服务器
echo "🛑 正在停止服务器 (PID: $PID)..."
kill $PID

# 等待进程结束
sleep 1

# 如果进程还在运行，强制终止
if ps -p $PID > /dev/null 2>&1; then
    echo "⚠️  进程未响应，强制终止..."
    kill -9 $PID
    sleep 1
fi

# 验证进程已停止
if ps -p $PID > /dev/null 2>&1; then
    echo "❌ 无法停止服务器"
    exit 1
else
    echo "✅ 服务器已停止"
    rm "$PID_FILE"
fi
