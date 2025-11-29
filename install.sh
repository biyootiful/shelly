#!/bin/bash

# Shelly Installation Script
# Usage: curl -fsSL https://raw.githubusercontent.com/yourusername/shelly/main/install.sh | bash

set -e

INSTALL_DIR="${SHELLY_INSTALL_DIR:-$HOME/.shelly}"
BIN_DIR="${HOME}/.local/bin"
REPO_URL="https://raw.githubusercontent.com/yourusername/shelly/main"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Installing Shelly...${NC}\n"

# Create directories
mkdir -p "$INSTALL_DIR"
mkdir -p "$BIN_DIR"

# Download main script
echo -e "${YELLOW}Downloading shelly script...${NC}"
curl -fsSL "${REPO_URL}/shelly" -o "${INSTALL_DIR}/shelly"
chmod +x "${INSTALL_DIR}/shelly"

# Download trap script
echo -e "${YELLOW}Downloading error catching script...${NC}"
curl -fsSL "${REPO_URL}/shelly-trap" -o "${INSTALL_DIR}/shelly-trap"

# Create symlink
ln -sf "${INSTALL_DIR}/shelly" "${BIN_DIR}/shelly"

echo -e "\n${GREEN}Shelly installed successfully!${NC}\n"

# Check if bin directory is in PATH
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    echo -e "${YELLOW}Note: $BIN_DIR is not in your PATH${NC}"
    echo -e "Add this line to your ~/.zshrc or ~/.bashrc:\n"
    echo -e "  ${BLUE}export PATH=\"\$HOME/.local/bin:\$PATH\"${NC}\n"
fi

# Check for Ollama
if ! command -v ollama &> /dev/null; then
    echo -e "${YELLOW}Ollama is not installed.${NC}"
    echo -e "Install it with:\n"
    echo -e "  ${BLUE}curl -fsSL https://ollama.com/install.sh | sh${NC}"
    echo -e "  ${BLUE}ollama pull llama3.2${NC}\n"
else
    echo -e "${GREEN}Ollama is already installed${NC}"

    # Check if recommended model is available
    if ! ollama list | grep -q "llama3.2"; then
        echo -e "${YELLOW}Recommended model not found. Pull it with:${NC}"
        echo -e "  ${BLUE}ollama pull llama3.2${NC}\n"
    fi
fi

# Install Oh My Zsh plugin if Oh My Zsh is detected
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${YELLOW}Oh My Zsh detected. Installing plugin...${NC}"
    OMZ_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
    mkdir -p "$OMZ_CUSTOM/plugins/shelly"
    curl -fsSL "${REPO_URL}/shelly-plugin/shelly.plugin.zsh" -o "$OMZ_CUSTOM/plugins/shelly/shelly.plugin.zsh"

    echo -e "${GREEN}Plugin installed!${NC}"
    echo -e "Add ${BLUE}shelly${NC} to your plugins in ~/.zshrc:\n"
    echo -e "  ${BLUE}plugins=(git shelly ...)${NC}\n"
else
    echo -e "${YELLOW}Optional: Enable automatic error catching${NC}"
    echo -e "Add this line to your ~/.zshrc or ~/.bashrc:\n"
    echo -e "  ${BLUE}source ${INSTALL_DIR}/shelly-trap${NC}\n"
fi

echo -e "${GREEN}Installation complete!${NC}"
echo -e "Try: ${BLUE}shelly \"what's the command for listing files?\"${NC}\n"
