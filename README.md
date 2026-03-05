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
│   ├── error-pages/                # 错误页面（Git Submodule）
│   │   └── noise/                  # tarampampam/error-pages noise 主题
│   │       ├── 400.html ～ 505.html  # 20+ 种精美错误页面
│   └── example.conf                # 示例服务器配置（含反向代理）
├── log/                            # 日志文件目录
│   └── .gitkeep                    # 保持目录结构
├── .gitignore                      # Git 忽略规则
├── .gitmodules                     # Git 子模块配置
├── nginx.conf                      # 主配置文件（含详细中文注释）
├── LICENSE                         # 开源协议
├── README.md                       # 项目说明文档（本文件）
├── CODEOWNERS                      # 代码所有者配置
├── CODE_OF_CONDUCT.md              # 社区行为准则
├── CONTRIBUTING.md                 # 贡献指南
└── SECURITY.md                     # 安全政策
```

##  快速开始

> 📝 **部署和使用文档正在整理中...** 敬请期待！

部署此配置前：
1. 根据您的环境修改 `nginx.conf` 和 `conf.d/example.conf` 中的关键参数
2. 放置 SSL 证书到 `conf.d/cert/` 目录下
3. 运行 `nginx -t` 验证配置语法
4. 详细的步骤和配置说明文档即将发布

## 🎯 预配置场景支持

本仓库提供了生产级别的配置，支持以下使用场景：

### 1. **FRP 长连接代理** 🔄
- 优化的 upstream keepalive 连接池
- 支持 TCP 长连接和持续数据流
- 大文件上传优化（支持 1GB+）
- 示例配置：`conf.d/example.conf` 中的 `upstream backend` 块

### 2. **国际网站反向代理** 🌍
- nyaa.si 和 sukebei.nyaa.si 反向代理示例
- 国外网站友好的限流配置（5r/s）
- DNS 缓存优化（支持本地 DNS 和公共 DNS）
- 多层缓存策略（搜索短期、种子中期、资源长期）

### 3. **大文件服务与流媒体** 📹
- 无缓冲流式传输支持
- 范围请求优化（支持断点续传和视频快进）
- 媒体文件防热链接保护
- 优化的缓冲配置

### 4. **安全加固网站** 🔐
- 现代 TLS 1.2/1.3 配置
- 强加密套件（ECDHE + AES-GCM + ChaCha20）
- 完整的安全响应头防护
- HTTP 强制升级到 HTTPS

## ⚡ 性能优化清单

| 优化项 | 状态 | 说明 |
|--------|------|------|
| **Upstream Keepalive** | ✅ | TCP 连接复用，减少握手延迟 |
| **TLS Session 缓存** | ✅ | 客户端 + 上游双向会话复用 |
| **Gzip 压缩** | ✅ | 智能压缩（level 6），支持多种文件类型 |
| **DNS 缓存** | ✅ | 5 分钟 TTL，支持本地/公共 DNS |
| **防热链接** | ✅ | Referer 验证，保护媒体资源 |
| **文件缓存** | ✅ | 5000 个文件描述符缓存 |
| **多层缓存策略** | ✅ | 按内容类型差异化缓存时间 |
| **限流防护** | ✅ | 区域化限流，防止滥用 |

## 🔒 安全特性

本配置包含多项安全增强措施：

### 传输安全
- **🔐 仅支持 TLS 1.2 & 1.3**：禁用过时的不安全协议
- **💪 强加密套件**：采用现代加密算法组合（ECDHE + AES-GCM + ChaCha20）
- **🔑 会话复用优化**：SSL 会话缓存 + Session Ticket 支持，减少握手次数

### HTTP 安全响应头
- `Strict-Transport-Security` (HSTS) - 强制 HTTPS，预加载列表支持
- `X-Content-Type-Options` - 防止 MIME 类型嗅探
- `X-Frame-Options` - 防止点击劫持
- `X-XSS-Protection` - XSS 防护（向后兼容）
- `Referrer-Policy` - 隐私友好的引用来源策略
- `Permissions-Policy` - 限制浏览器特性权限
- `Cross-Origin-*` - Spectre/Meltdown 防护

### 应用层防护
- **🎭 隐藏服务器信息**：不暴露 Nginx 版本号，移除 X-Powered-By 头
- **🛡️ 防热链接**：Referer 验证，保护媒体和下载资源被盗链
- **⏱️ 限流防护**：多层限流策略，防止 DDoS 和资源滥用
- **📝 灵活的日志**：访问日志缓冲和定期刷新，便于审计和分析

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
