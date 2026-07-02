#!/bin/bash
# WebSocket 服务启动脚本
# 启动时动态安装依赖，无需重新构建镜像

set -e

cd /app

echo "=== WebSocket 服务启动 ==="
echo "当前时间: $(date)"
echo "工作目录: $(pwd)"

# 检查 pyproject.toml 是否存在
if [ -f /app/websocket/pyproject.toml ]; then
    echo "=== 从 pyproject.toml 安装依赖 ==="
    
    # 提取依赖并安装
    python -c "
import tomllib
import subprocess
import sys

deps = tomllib.load(open('/app/websocket/pyproject.toml', 'rb')).get('project', {}).get('dependencies', [])
# 过滤掉 Windows 平台专属依赖（pyautogui）
deps = [d for d in deps if 'sys_platform == \"win32\"' not in d]

print(f'发现 {len(deps)} 个依赖，开始安装...')
for dep in deps:
    print(f'  - {dep}')

# 使用 pip 安装
subprocess.check_call([sys.executable, '-m', 'pip', 'install', '--no-cache-dir', *deps])
print('依赖安装完成！')
"
else
    echo "警告: pyproject.toml 不存在，跳过依赖安装"
fi

# 检查 Playwright 浏览器
echo "=== 检查 Playwright 浏览器 ==="
if ! python -c "from playwright.sync_api import sync_playwright; print('Playwright OK')" 2>/dev/null; then
    echo "安装 Playwright 浏览器..."
    python -m playwright install chromium || echo "Playwright 浏览器已存在或安装失败（可能已安装）"
fi

echo "=== 启动 WebSocket 服务 ==="
exec python websocket/main.py