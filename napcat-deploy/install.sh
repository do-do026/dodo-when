#!/bin/bash
# napcat-deploy install script
SKILL_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET="/sdcard/Download/Operit/skills/napcat-deploy"

echo "安装 napcat-deploy skill..."
if [ -d "$TARGET" ]; then
    echo "目标已存在，跳过复制"
else
    cp -r "$SKILL_DIR" "$TARGET"
    echo "已安装到 $TARGET"
fi
echo "完成！重启 Operit 后生效。"
