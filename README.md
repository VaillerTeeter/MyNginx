# Example-of-Github-Repo

个人代码示例仓库，收录各类语言和框架的代码片段与实践示例。

## 目录结构

```text
.
├── .clineignore
├── .clinerules/
│   ├── git-workflow.md            # Cline Git 工作流规范
│   └── project-identity.md        # 项目身份声明
├── .editorconfig
├── .github/
│   ├── ISSUE_TEMPLATE/            # Issue 模板（中英文 bug/feature）
│   │   ├── bug_report_en.md
│   │   ├── bug_report_zh.md
│   │   ├── config.yml
│   │   ├── feature_request_en.md
│   │   └── feature_request_zh.md
│   ├── PULL_REQUEST_TEMPLATE.md   # PR 模板（中英双语）
│   ├── dependabot.yml             # 自动更新 GitHub Actions + npm 依赖（每周一）
│   ├── docs/
│   │   ├── ci/
│   │   │   └── ci-checks.md       # CI 检查说明
│   │   └── settings/              # GitHub 仓库配置文档（19 个）
│   ├── scripts/
│   │   └── ai-review.mjs          # AI 代码审查脚本（/review 命令）
│   └── workflows/
│       ├── lint.yml               # 多语言 CI Lint 矩阵（100+ job）
│       └── review-command.yml     # PR Review 命令触发器
├── .gitignore
├── .lintrc/                       # 30+ 语言/工具的 Lint 配置（按功能分类）
│   ├── backend/                   # C/C++, Go, Rust, Python, Java 等 26 种语言
│   ├── frontend/                  # JS, TS, CSS, HTML, Prettier, 前端框架
│   ├── data-formats/              # YAML, TOML, SQL, GraphQL, OpenAPI, Protobuf
│   ├── docs/                      # Markdown, LaTeX, Vale
│   ├── general/                   # CSpell（拼写）, 文件命名, YAML lint
│   ├── git/                       # Commitlint
│   ├── infrastructure/            # Docker, K8s, Terraform, Shell 等
│   ├── security/                  # Gitleaks, Semgrep, License 合规, Trivy
│   └── testing/                   # Gherkin, Robot Framework
├── .vscode/
│   ├── extensions.json            # 推荐 VS Code 扩展
│   └── settings.json              # 工作区设置
├── CODE_OF_CONDUCT.md
├── CONTRIBUTING.md
├── LICENSE                        # GPL-3.0
├── README.md
└── SECURITY.md
```

## CI 检查说明

> 详细的 CI 检查规则文档已独立维护，请参阅 [ci-checks.md](.github/docs/ci/ci-checks.md)。

## 相关链接

- [GitHub Profile](https://github.com/VaillerTeeter)
