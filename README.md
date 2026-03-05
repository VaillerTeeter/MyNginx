# 🚀 Nginx 高级配置仓库

一个注释详尽、开箱即用的 Nginx 配置仓库，遵循安全最佳实践，内含精美自定义错误页面。

## ✨ 特性亮点

- **📚 详尽注释**：`nginx.conf` 配置文件包含全中文详细注释，新手友好
- **🔐 SSL/TLS 加固**：预配置现代加密套件，支持 TLS 1.2/1.3
- **🛡️ 安全响应头**：内置多重安全防护（HSTS、X-Frame-Options、CSP 等）
- **🎨 精美错误页**：为常见 HTTP 错误码提供美观的自定义页面
- **🔄 反向代理模板**：开箱即用的反向代理配置示例
- **⚡ 生产级优化**：性能与安全的完美平衡

## 📁 项目结构

```
.
├── .github/                        # GitHub 社区配置
│   ├── ISSUE_TEMPLATE/             # Issue 模板目录
│   │   ├── bug_report.md           # Bug 报告模板
│   │   └── feature_request.md      # 功能请求模板
│   └── pull_request_template.md    # PR 模板
├── conf.d/                         # 虚拟主机配置目录
│   ├── cert/                       # SSL 证书存放目录
│   │   └── example/                # 示例域名证书文件夹
│   ├── error/                      # 自定义错误页面目录
│   │   ├── 400.html                # 错误请求
│   │   ├── 401.html                # 未授权
│   │   ├── 403.html                # 禁止访问
│   │   ├── 404.html                # 页面未找到
│   │   ├── 405.html                # 方法不允许
│   │   ├── 407.html                # 需要代理身份验证
│   │   ├── 408.html                # 请求超时
│   │   ├── 409.html                # 冲突
│   │   ├── 410.html                # 已删除
│   │   ├── 411.html                # 需要Content-Length
│   │   ├── 412.html                # 先决条件失败
│   │   ├── 413.html                # 请求实体过大
│   │   ├── 416.html                # 请求范围不符合要求
│   │   ├── 418.html                # 我是茶壶 🫖
│   │   ├── 429.html                # 请求过多
│   │   ├── 500.html                # 内部服务器错误
│   │   ├── 502.html                # 网关错误
│   │   ├── 503.html                # 服务不可用
│   │   ├── 504.html                # 网关超时
│   │   └── 505.html                # HTTP 版本不支持
│   └── example.conf                # 示例服务器配置（含反向代理）
├── log/                            # 日志文件目录
│   └── .gitkeep                    # 保持目录结构
├── .gitignore                      # Git 忽略规则
├── nginx.conf                      # 主配置文件（含详细中文注释）
├── LICENSE                         # 开源协议
├── README.md                       # 项目说明文档（本文件）
├── CODEOWNERS                      # 代码所有者配置
├── CODE_OF_CONDUCT.md              # 社区行为准则
├── CONTRIBUTING.md                 # 贡献指南
└── SECURITY.md                     # 安全政策
```

## 🚀 快速开始

> 📝 部署文档正在编写中...

## 🔒 安全特性

本配置包含多项安全增强措施：

- **🔐 仅支持 TLS 1.2 & 1.3**：禁用过时的不安全协议
- **💪 强加密套件**：采用现代加密算法
- **🛡️ 安全响应头**：
  - `Strict-Transport-Security` (HSTS) - 强制 HTTPS
  - `X-Content-Type-Options` - 防止 MIME 类型嗅探
  - `X-Frame-Options` - 防止点击劫持
  - `X-XSS-Protection` - XSS 防护
  - `Referrer-Policy` - 引用来源策略
- **🎭 隐藏服务器信息**：不暴露 Nginx 版本号
- **🎨 专业错误页面**：避免泄露服务器详细信息

## ⚙️ 核心配置要点

### 工作进程配置
```nginx
worker_processes auto;          # 自动检测 CPU 核心数
worker_cpu_affinity auto;       # 自动绑定到 CPU
```

### 性能优化
```nginx
worker_connections 1024;        # 每个工作进程的最大连接数
keepalive_timeout 65;           # 长连接超时时间
```

### SSL 配置
```nginx
ssl_protocols TLSv1.2 TLSv1.3;          # 仅允许安全协议
ssl_prefer_server_ciphers on;           # 优先使用服务器加密套件
ssl_session_cache shared:SSL:10m;       # SSL 会话缓存
```

## 📝 自定义指南

### 添加新的虚拟主机

1. 复制示例配置：
   ```bash
   cp conf.d/example.conf conf.d/你的域名.conf
   ```

2. 编辑新文件，填入你的域名和配置

3. 测试并重载：
   ```bash
   sudo nginx -t && sudo systemctl reload nginx
   ```

### 修改错误页面

自定义错误页面位于 `conf.d/error/` 目录，直接编辑 HTML 文件即可。

## 🤝 参与贡献

欢迎贡献代码！在提交 PR 前，请先阅读我们的[贡献指南](CONTRIBUTING.md)和[行为准则](CODE_OF_CONDUCT.md)。

## 📄 开源协议

本项目采用 [LICENSE](LICENSE) 文件中指定的开源协议。

## 🔐 安全政策

如有安全问题，请查看我们的[安全政策](SECURITY.md)。

## 📞 获取帮助

- **问题反馈**：通过 [GitHub Issues](https://github.com/VaillerTeeter/MyNginx/issues) 报告 Bug 或请求新功能
- **讨论交流**：在 Discussions 中提问和分享想法

## 🙏 致谢

- Nginx 官方文档
- Mozilla SSL 配置生成器的安全最佳实践
- 社区贡献者的支持

---

**⚠️ 重要提示**：在生产环境部署前，请务必在测试环境中验证配置更改。
