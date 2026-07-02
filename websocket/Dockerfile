# WebSocket 服务 Dockerfile
# 优化版：依赖在启动时动态安装，代码映射后重启即可生效

# 基础镜像
FROM python:3.11-slim

ENV PLAYWRIGHT_BROWSERS_PATH=/ms-playwright

# 配置国内镜像源
RUN sed -i 's|deb.debian.org|mirrors.aliyun.com|g' /etc/apt/sources.list.d/debian.sources 2>/dev/null || \
    sed -i 's|deb.debian.org|mirrors.aliyun.com|g' /etc/apt/sources.list 2>/dev/null || true
RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

WORKDIR /app

# 安装基础工具（构建时一次性安装）
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    gcc \
    bash \
    && update-ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 预安装 Playwright 浏览器（这个很慢，构建时安装）
# 注意：如果需要更新 Playwright 版本，需要重新构建镜像
RUN pip install playwright && \
    python -m playwright install --with-deps chromium

# 创建目录结构
RUN mkdir -p /app/websocket/logs /app/static /app/browser_data

# 复制启动脚本（构建时复制，但映射后会使用映射的版本）
COPY websocket/start.sh /app/start.sh
RUN chmod +x /app/start.sh

# 暴露端口
EXPOSE 8090

ENV PYTHONUNBUFFERED=1
ENV PYTHONPATH=/app
ENV TZ=Asia/Shanghai

# 使用启动脚本（依赖在启动时动态安装）
CMD ["bash", "/app/start.sh"]
