#!/bin/bash

# Скрипт обновления Ubuntu System Updater

# Цвета
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Обновление Ubuntu System Updater      ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""

# Проверка прав root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}✗ Ошибка: Требуются права root${NC}"
    echo "Запустите: sudo ./update.sh"
    exit 1
fi

# Путь установки
INSTALL_PATH="/usr/local/bin/aupdate"

# Проверка существования старой версии
if [ -f "$INSTALL_PATH" ]; then
    echo -e "${YELLOW}Найдена установленная версия${NC}"
    echo -e "${YELLOW}Удаление старой версии...${NC}"
    rm "$INSTALL_PATH"
    echo -e "${GREEN}✓ Старая версия удалена${NC}"
    echo ""
else
    echo -e "${YELLOW}Старая версия не найдена${NC}"
    echo ""
fi

# Проверка существования нового файла
if [ ! -f "system-updater.sh" ]; then
    echo -e "${RED}✗ Ошибка: Файл system-updater.sh не найден${NC}"
    echo "Убедитесь, что вы находитесь в директории проекта"
    exit 1
fi

# Установка новой версии
echo -e "${YELLOW}📦 Установка новой версии...${NC}"
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
    echo -e "${GREEN}✓ Новая версия успешно установлена!${NC}"
else
    echo -e "${RED}✗ Ошибка: Команда aupdate не найдена${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║      Обновление завершено! v2.0.0      ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""
echo -e "${GREEN}Запустите программу:${NC}"
echo -e "  ${YELLOW}sudo aupdate${NC}"
echo ""
echo -e "${CYAN}Новые возможности:${NC}"
echo -e "  • 70+ новых функций"
echo -e "  • 36 интерактивных опций"
echo -e "  • Управление пакетами"
echo -e "  • Резервное копирование"
echo -e "  • Автоматическое логирование"
echo -e "  • И многое другое!"
echo ""
