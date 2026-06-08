---
name: HTML交互界面渲染
description: 在对话中嵌入可操作的HTML界面（五子棋、花束卡、宠物空间、小游戏等）。当用户需要对话内交互时触发。
---

# HTML交互界面渲染

## 触发条件
- 用户提出对话内小游戏（五子棋、象棋、井字棋等）
- 用户想展示花束卡、宠物空间、可视化面板
- 用户需要可点击/可输入的交互界面
- 渡渡觉得某个场景用交互界面比纯文字更好

## 渲染原理
Operit 聊天检测到 `<html>...</html>` 标签 → 不转义 → 直接解析为真实 DOM。支持完整 HTML/CSS/JS，按钮可点击、输入框可打字、动画可跑。

## 使用规则
1. 最外层必须包裹 `<html>...</html>`
2. `<html>` 标签内可以设置内联 class 控制卡片样式（status-card / info-card / warning-card / success-card）
3. 禁止使用 Markdown 代码块包裹——直接输出纯文本标签
4. CSS 写在 `<style>` 标签里，JS 写在 `<script>` 标签里
5. 保持界面简洁，适配手机屏幕（宽度建议 ≤ 360px）

## 示例：五子棋
参考已实现版本——15x15棋盘，点击落子，胜负判定。核心：`display:grid` 布局 + `onclick` 事件 + 方向遍历判定五连。

## 可用组件（Operit 内置）
- `<metric label="..." value="..." icon="..." color="..." />` — 数据指标
- `<badge type="success|info|warning|error" icon="...">文本</badge>` — 状态徽章
- `<progress value="80" label="..." />` — 进度条

## 注意事项
- 不是每轮都输出 HTML——只在需要交互时用
- 复杂游戏先做精简原型，再迭代
- HTML 内不要引用外部资源（CSS/JS 内联）