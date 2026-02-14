#!/bin/bash

# Проверка версии установленной программы

# Цвета
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║      Диагностика версии aupdate        ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""

INSTALL_PATH="/usr/local/bin/aupdate"

# Проверка 1: Существует ли файл
echo -e "${CYAN}Проверка 1: Существование файла${NC}"
if [ -f "$INSTALL_PATH" ]; then
    echo -e "${GREEN}✓ Файл найден: $INSTALL_PATH${NC}"
else
    echo -e "${RED}✗ Файл не найден: $INSTALL_PATH${NC}"
    echo -e "${YELLOW}Программа не установлена!${NC}"
    exit 1
fi

echo ""

# Проверка 2: Версия в установленном файле
echo -e "${CYAN}Проверка 2: Версия в установленном файле${NC}"
INSTALLED_VERSION=$(grep "^VERSION=" "$INSTALL_PATH" | head -1 | cut -d'"' -f2)
if [ -n "$INSTALLED_VERSION" ]; then
    echo -e "${CYAN}Установленная версия: ${YELLOW}$INSTALLED_VERSION${NC}"
    
    if [ "$INSTALLED_VERSION" = "2.1.0" ]; then
        echo -e "${GREEN}✓ Установлена последняя версия!${NC}"
    else
        echo -e "${RED}✗ Установлена старая версия!${NC}"
        echo -e "${YELLOW}Требуется обновление до v2.1.0${NC}"
    fi
else
    echo -e "${RED}✗ Не удалось определить версию${NC}"
fi

echo ""

# Проверка 3: Версия в локальном файле
echo -e "${CYAN}Проверка 3: Версия в локальном файле${NC}"
if [ -f "system-updater.sh" ]; then
    LOCAL_VERSION=$(grep "^VERSION=" system-updater.sh | head -1 | cut -d'"' -f2)
    echo -e "${CYAN}Локальная версия: ${YELLOW}$LOCAL_VERSION${NC}"
    
    if [ "$LOCAL_VERSION" = "2.1.0" ]; then
        echo -e "${GREEN}✓ Локальный файл актуален${NC}"
    else
        echo -e "${RED}✗ Локальный файл устарел${NC}"
    fi
else
    echo -e "${YELLOW}Локальный файл не найден (это нормально, если вы не в директории проекта)${NC}"
fi

echo ""

# Проверка 4: Наличие новых функций
echo -e "${CYAN}Проверка 4: Наличие новых функций v2.1.0${NC}"

if grep -q "setup_auto_update" "$INSTALL_PATH"; then
    echo -e "${GREEN}✓ Функция автообновления найдена${NC}"
else
    echo -e "${RED}✗ Функция автообновления НЕ найдена${NC}"
fi

if grep -q "update_application" "$INSTALL_PATH"; then
    echo -e "${GREEN}✓ Функция обновления приложения найдена${NC}"
else
    echo -e "${RED}✗ Функция обновления приложения НЕ найдена${NC}"
fi

if grep -q "0-40" "$INSTALL_PATH"; then
    echo -e "${GREEN}✓ Меню содержит 40 опций${NC}"
else
    echo -e "${RED}✗ Меню содержит старое количество опций${NC}"
fi

echo ""

# Проверка 5: Размер файла
echo -e "${CYAN}Проверка 5: Размер файла${NC}"
FILE_SIZE=$(stat -f%z "$INSTALL_PATH" 2>/dev/null || stat -c%s "$INSTALL_PATH" 2>/dev/null)
if [ -n "$FILE_SIZE" ]; then
    FILE_SIZE_KB=$((FILE_SIZE / 1024))
    echo -e "${CYAN}Размер файла: ${YELLOW}${FILE_SIZE_KB} KB${NC}"
    
    if [ $FILE_SIZE_KB -gt 25 ]; then
        echo -e "${GREEN}✓ Размер соответствует v2.1.0${NC}"
    else
        echo -e "${RED}✗ Файл слишком маленький (старая версия)${NC}"
    fi
fi

echo ""
echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║              Итоги                     ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""

if [ "$INSTALLED_VERSION" = "2.1.0" ] && grep -q "setup_auto_update" "$INSTALL_PATH"; then
    echo -e "${GREEN}✓✓✓ Все проверки пройдены!${NC}"
    echo -e "${GREEN}У вас установлена версия 2.1.0 с новыми функциями${NC}"
    echo ""
    echo -e "${CYAN}Запустите: ${YELLOW}sudo aupdate${NC}"
else
    echo -e "${RED}✗✗✗ Обнаружены проблемы!${NC}"
    echo -e "${YELLOW}Требуется обновление${NC}"
    echo ""
    echo -e "${CYAN}Выполните:${NC}"
    echo -e "  ${YELLOW}chmod +x force-update.sh${NC}"
    echo -e "  ${YELLOW}sudo ./force-update.sh${NC}"
fi

echo ""
