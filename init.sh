#!/bin/bash
# ============================================
# Nginx 初始化脚本
# ============================================
# 功能：初始化 Git 子模块并生成自签名证书
# 使用：./init.sh
# 说明：需要在仓库根目录执行

set -e  # 遇到错误立即退出

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'  # No Color

# 脚本信息
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_NAME="MyNginx"

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Nginx 配置初始化脚本${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# ============================================
# 1. 初始化 Git 子模块
# ============================================
echo -e "${YELLOW}[1/2]${NC} 初始化 Git 子模块..."

if [ ! -d ".git" ]; then
    echo -e "${RED}✗ 错误：此脚本必须在 Git 仓库根目录执行${NC}"
    exit 1
fi

if [ ! -f ".gitmodules" ]; then
    echo -e "${YELLOW}⚠ 警告：未检测到 .gitmodules 文件，跳过子模块初始化${NC}"
else
    echo "  初始化子模块中..."
    git submodule update --init --recursive
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ 子模块初始化成功${NC}"
    else
        echo -e "${YELLOW}⚠ 子模块初始化出现警告，继续执行...${NC}"
    fi
fi

echo ""

# ============================================
# 2. 生成自签名证书
# ============================================
echo -e "${YELLOW}[2/2]${NC} 生成自签名证书..."

CERT_DIR="${SCRIPT_DIR}/conf.d/cert/default"
CERT_FILE="${CERT_DIR}/selfsigned.crt"
KEY_FILE="${CERT_DIR}/selfsigned.key"

# 检查证书是否已存在
if [ -f "$CERT_FILE" ] && [ -f "$KEY_FILE" ]; then
    echo -e "${YELLOW}⚠ 自签名证书已存在${NC}"
    echo "  路径: $CERT_DIR"
    echo -n "  是否重新生成？(y/N): "
    read -r response
    
    if [[ "$response" != "y" && "$response" != "Y" ]]; then
        echo "  已跳过证书生成"
        SKIP_CERT=1
    else
        SKIP_CERT=0
    fi
else
    SKIP_CERT=0
fi

if [ $SKIP_CERT -eq 0 ]; then
    # 创建证书目录
    mkdir -p "$CERT_DIR"
    
    echo "  生成自签名证书 (RSA 2048, 有效期 10 年)..."
    openssl req -x509 -nodes -days 3650 -newkey rsa:2048 \
        -keyout "$KEY_FILE" \
        -out "$CERT_FILE" \
        -subj "/C=XX/ST=Unknown/L=Unknown/O=Default/CN=invalid.local" \
        -batch 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ 证书生成成功${NC}"
        
        # 设置证书权限
        chmod 600 "$KEY_FILE"
        chmod 644 "$CERT_FILE"
        
        # 显示证书信息
        echo ""
        echo "  证书详情："
        openssl x509 -in "$CERT_FILE" -noout \
            -subject -dates -noout 2>/dev/null | sed 's/^/    /'
    else
        echo -e "${RED}✗ 证书生成失败（缺少 openssl 工具）${NC}"
        exit 1
    fi
fi

echo ""

# ============================================
# 完成
# ============================================
echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}✓ 初始化完成！${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

echo "后续步骤："
echo "  1. 验证配置语法："
echo -e "     ${YELLOW}nginx -t${NC}"
echo ""
echo "  2. 启动 Nginx:"
echo -e "     ${YELLOW}systemctl start nginx${NC}"
echo "     或"
echo -e "     ${YELLOW}docker-compose up${NC}"
echo ""
echo "  3. 测试访问:"
echo -e "     ${YELLOW}curl http://yourdomain.com/${NC}    (应正常访问)"
echo -e "     ${YELLOW}curl http://YOUR_SERVER_IP/${NC}     (应返回 403)"
echo ""
