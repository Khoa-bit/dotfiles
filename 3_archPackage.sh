#!/usr/bin/env sh

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

set -o errexit -o nounset

echo -e "${BLUE}\n<> Disable conda auto activate...${NC}"
conda config --set auto_activate_base false

echo -e "${BLUE}\n<> Installing global PNPM package...${NC}"
pnpm add -g tldr npm-check
