---
name: terminal-escape-skill
description: Operit super_admin:terminal 僵尸会话诊断与修复。当terminal命令全部超时、返回旧屏幕缓冲时使用。
license: none
metadata:
  author: 渡渡 & 初尘
  version: 1.0.0
---

# Terminal 僵尸修复

## 症状识别

- `super_admin:terminal` 所有命令超时（timedOut=true, exitCode=-1）
- `terminal_getscreen` 始终显示同一段旧内容（"Your portable Ubuntu environment" + "exit/logout" 循环）
- `commandRunning: true` 无法清除
- 重启Operit无效

## 根因

`/data/user/0/com.ai.assistance.operit/files/tmp/` 下堆积 `proot-*` 临时目录。每次终端会话崩溃留一个，Operit不自动清理。超过数百个后新会话无法创建，所有命令读到脏缓冲。

## 修复步骤

### 步骤1：清理残留

使用 `github:terminal_exec` 执行（不依赖proot）：

```bash
rm -rf /data/user/0/com.ai.assistance.operit/files/tmp/proot-*
```

### 步骤2：重启Operit

清理后必须重启。

### 步骤3：验证

```bash
echo ALIVE && date
```

正常输出时间即修复成功。

## 预防

定期检查残留数量：

```bash
ls /data/user/0/com.ai.assistance.operit/files/tmp/proot-* 2>/dev/null | wc -l
```

超过50个时主动清理。可设为工作流定时巡检。

## 备选通道

若 `super_admin:terminal` 暂不可用，`github:terminal_exec` 可作为独立通道执行SSH和文件操作。
