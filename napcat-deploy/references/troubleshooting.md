# NapCat 部署故障排除参考

> 基于 EMBER-001/002/003 工程经验 | 2026-05-28

---

## S1: 首次部署QQ+NapCat

### 前置条件
- 远程服务器已安装QQ：`dpkg -l linuxqq`
- 本机或远程有 NapCat.zip
- 远程已安装 xvfb：`which xvfb-run`

### 完整步骤

1. **文件传输**（优先检查本机缓存）
2. **解压NapCat**：确保 loadNapCat.js 在 app/ 根目录，napcat.mjs 在 napcat/ 子目录
3. **修改 package.json**：main 指向 loadNapCat.js，备份原值到 orig_main
4. **rsync 恢复QQ原生文件**：`rsync -av --ignore-existing`
5. **修复权限**：chown + chmod 755
6. **安装依赖**：libvips42, xvfb
7. **脚本启动**：写入 /tmp/start_qq.sh
8. **验证**：12秒后检查日志中的二维码

---

## S2: GitHub下载卡住

原则：**永远不要假设GitHub在国内能正常访问。**

优先级：
1. 本机缓存 → scp
2. ghproxy 镜像
3. timeout + connect-timeout 双重保护

---

## S3: 找不到napcat.mjs

loadNapCat.js 期望：`./napcat/napcat.mjs`
实际结构必须是：
```
app/
├── loadNapCat.js
└── napcat/
    └── napcat.mjs
```

---

## S4: QQ原生文件丢失

永远用 `rsync --ignore-existing` 从 deb 恢复，不要手动逐个处理。

---

## S5: 系统依赖

常见缺失：
- libvips-cpp.so.42 → `apt install libvips42`
- libbugly.so → 从deb恢复（S4）
- sharp-lib/* → 从deb恢复（S4）

---

## S6: 权限

NapCat目录需要运行QQ的用户可写。
`chown -R user:user napcat/ && chmod -R 755 napcat/`

---

## S7: 二维码过期

1. 杀进程（单独SSH）
2. 启动（单独SSH，用脚本文件）
3. 等12秒
4. base64 → 本地Download

---

## S8: 跨设备扫码

QQ登录二维码不允许自扫相册。解决方案：
- 新手机显示二维码
- 旧手机（目标QQ号）扫码

---

## S9: 终端问题

原则：
- 杀进程和启动分两次SSH
- 复杂命令写入脚本文件再执行
- 避免引号嵌套

---

## S10: 进程挂了

检查：`ps aux | grep qq | wc -l`（正常6-20）
重启：`bash /tmp/start_qq.sh`

---

## 关键命令速查

```bash
# 检查进程
ssh user@host 'ps aux | grep "/opt/QQ/qq" | grep -v grep | wc -l'

# 启动
ssh user@host 'bash /tmp/start_qq.sh'

# 看日志
ssh user@host 'tail -20 /tmp/qq_napcat.log'

# 拉二维码
ssh user@host 'python3 -c "import base64; print(base64.b64encode(open(\"/opt/QQ/resources/app/napcat/cache/qrcode.png\",\"rb\").read()).decode())"' > /tmp/qr_b64.txt

# 恢复文件
ssh user@host 'sudo rsync -av --ignore-existing /tmp/qq_restore/opt/QQ/resources/app/ /opt/QQ/resources/app/'
```
