#!/bin/bash

# Скрипт удаления Ubuntu System Updater

# Цвета
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Удаление Ubuntu System Updater        ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""

# Проверка прав root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}✗ Ошибка: Требуются права root${NC}"
    echo "Запустите: sudo ./uninstall.sh"
    exit 1
fi

# Путь установки
INSTALL_PATH="/usr/local/bin/aupdate"

# Проверка существования
if [ ! -f "$INSTALL_PATH" ]; then
    echo -e "${YELLOW}⚠ Программа не установлена в системе${NC}"
    exit 0
fi

# Подтверждение
read -p "Вы уверены, что хотите удалить программу? (y/n): " confirm

if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
    echo -e "${YELLOW}Удаление отменено${NC}"
    exit 0
fi

# Удаление
echo -e "${YELLOW}Удаление программы...${NC}"
rm "$INSTALL_PATH"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Программа успешно удалена${NC}"
else
    echo -e "${RED}✗ Ошибка при удалении${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}Спасибо за использование Ubuntu System Updater!${NC}"
echo ""
