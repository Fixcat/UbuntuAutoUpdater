#!/bin/bash

# Установочный скрипт для Ubuntu System Updater
# Устанавливает программу с командой 'aupdate'

# Цвета
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Установка Ubuntu System Updater       ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""

# Проверка прав root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}✗ Ошибка: Требуются права root${NC}"
    echo "Запустите: sudo ./install.sh"
    exit 1
fi

# Путь установки
INSTALL_PATH="/usr/local/bin/aupdate"

# Проверка существующей установки
if [ -f "$INSTALL_PATH" ]; then
    echo -e "${YELLOW}⚠ Программа уже установлена${NC}"
    read -p "Переустановить? (y/n): " reinstall
    
    if [ "$reinstall" != "y" ] && [ "$reinstall" != "Y" ]; then
        echo -e "${BLUE}Установка отменена${NC}"
        exit 0
    fi
    echo ""
fi

# Проверка существования файла
if [ ! -f "system-updater.sh" ]; then
    echo -e "${RED}✗ Ошибка: Файл system-updater.sh не найден${NC}"
    echo "Убедитесь, что вы находитесь в директории проекта"
    exit 1
fi

# Копирование файла
echo -e "${YELLOW}📦 Копирование файлов...${NC}"
cp system-updater.sh "$INSTALL_PATH"

if [ $? -ne 0 ]; then
    echo -e "${RED}✗ Ошибка при копировании файла${NC}"
    exit 1
fi

# Установка прав на выполнение
echo -e "${YELLOW}🔧 Установка прав доступа...${NC}"
chmod +x "$INSTALL_PATH"

if [ $? -ne 0 ]; then
    echo -e "${RED}✗ Ошибка при установке прав${NC}"
    exit 1
fi

# Проверка установки
if command -v aupdate &> /dev/null; then
    echo -e "${GREEN}✓ Программа успешно установлена!${NC}"
else
    echo -e "${RED}✗ Ошибка: Команда aupdate не найдена${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║         Установка завершена!           ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""
echo -e "${GREEN}Запуск программы:${NC}"
echo -e "  ${YELLOW}sudo aupdate${NC}"
echo ""
echo -e "${GREEN}Удаление программы:${NC}"
echo -e "  ${YELLOW}sudo rm $INSTALL_PATH${NC}"
echo -e "  или используйте: ${YELLOW}sudo ./uninstall.sh${NC}"
echo ""
echo -e "${BLUE}Документация:${NC}"
echo -e "  README.md  - Полное описание"
echo -e "  USAGE.md   - Руководство по использованию"
echo ""
