---
name: napcat-deploy
description: >-
  QQ+NapCat远程服务器部署与故障排除。支持首次部署、二维码重拉、依赖修复、
  文件恢复等场景。触发短语：部署NapCat、QQ机器人部署、NapCat二维码过期、
  NapCat启动失败、QQ登录二维码、远程QQ部署、NapCat缺依赖、wrapper.node丢失。
  基于EMBER工程经验库的实战踩坑记录。
license: MIT
metadata:
  author: 渡渡 (dodo026)
  version: 1.0.0
  based_on: EMBER-001, EMBER-002, EMBER-003
compatibility: Operit (Android)
---

# /napcat-deploy — QQ+NapCat 远程部署与故障排除

你是渡渡，初尘的AI伙伴。这个skill让你在遇到QQ+NapCat部署相关的任何问题时，不用去记忆库里翻——直接按下面的情景执行。

## 触发条件

当用户提到以下任意关键词或场景时激活本skill：
- 部署NapCat / QQ机器人 / 远程QQ
- NapCat启动失败 / 二维码过期 / 需要重新扫码
- wrapper.node丢失 / 缺依赖 / libvips / libbugly
- QQ进程挂了 / 服务器上的QQ

---

## 情景索引

| 编号 | 情景 |
|------|------|
| S1 | 首次部署QQ+NapCat |
| S2 | GitHub下载NapCat卡住 |
| S3 | NapCat找不到napcat.mjs |
| S4 | QQ原生文件丢失(wrapper.node等) |
| S5 | 缺少系统依赖(libvips等) |
| S6 | 权限被拒(EACCES) |
| S7 | 二维码过期/需要重新扫码 |
| S8 | 二维码无法自扫(需跨设备) |
| S9 | 终端命令引号嵌套/进程管理问题 |
| S10 | 进程挂了需要重启 |

详细内容见 references/ 目录下的各情景文档。

## 通用部署原则（来自EMBER-003）

1. **缓存优先**：任何文件先查本机/本地缓存
2. **原子操作**：部署用解压/rsync等原子操作
3. **非破坏恢复**：rsync --ignore-existing
4. **脚本化**：超过2步的远程操作用脚本文件
5. **进程管理分离**：杀进程和启进程分两次SSH
6. **依赖预检**：启动前用rsync确保关键文件存在
