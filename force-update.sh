#!/bin/bash

# Принудительное обновление до v2.1.0

# Цвета
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Принудительное обновление до v2.1.0   ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""

# Проверка прав root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}✗ Ошибка: Требуются права root${NC}"
    echo "Запустите: sudo ./force-update.sh"
    exit 1
fi

# Путь установки
INSTALL_PATH="/usr/local/bin/aupdate"

echo -e "${YELLOW}Шаг 1: Удаление старой версии...${NC}"
if [ -f "$INSTALL_PATH" ]; then
    rm -f "$INSTALL_PATH"
    echo -e "${GREEN}✓ Старая версия удалена${NC}"
else
    echo -e "${YELLOW}Старая версия не найдена${NC}"
fi

echo ""
echo -e "${YELLOW}Шаг 2: Проверка нового файла...${NC}"
if [ ! -f "system-updater.sh" ]; then
    echo -e "${RED}✗ Ошибка: Файл system-updater.sh не найден${NC}"
    echo "Убедитесь, что вы находитесь в директории проекта"
    exit 1
fi

# Проверка версии в файле
VERSION_IN_FILE=$(grep "^VERSION=" system-updater.sh | head -1 | cut -d'"' -f2)
echo -e "${CYAN}Версия в файле: $VERSION_IN_FILE${NC}"

if [ "$VERSION_IN_FILE" != "2.1.0" ]; then
    echo -e "${RED}✗ Ошибка: Файл не содержит версию 2.1.0${NC}"
    echo -e "${YELLOW}Возможно, файл не был обновлен${NC}"
    exit 1
fi

echo ""
echo -e "${YELLOW}Шаг 3: Установка новой версии...${NC}"
cp system-updater.sh "$INSTALL_PATH"

if [ $? -ne 0 ]; then
    echo -e "${RED}✗ Ошибка при копировании${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Файл скопирован${NC}"

echo ""
echo -e "${YELLOW}Шаг 4: Установка прав...${NC}"
chmod +x "$INSTALL_PATH"

if [ $? -ne 0 ]; then
    echo -e "${RED}✗ Ошибка при установке прав${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Права установлены${NC}"

echo ""
echo -e "${YELLOW}Шаг 5: Проверка установки...${NC}"

# Проверка версии установленного файла
INSTALLED_VERSION=$(grep "^VERSION=" "$INSTALL_PATH" | head -1 | cut -d'"' -f2)
echo -e "${CYAN}Установленная версия: $INSTALLED_VERSION${NC}"

if [ "$INSTALLED_VERSION" = "2.1.0" ]; then
    echo -e "${GREEN}✓ Версия 2.1.0 успешно установлена!${NC}"
else
    echo -e "${RED}✗ Ошибка: Установлена неправильная версия${NC}"
    exit 1
fi

# Проверка наличия новых функций
if grep -q "setup_auto_update" "$INSTALL_PATH"; then
    echo -e "${GREEN}✓ Новые функции найдены${NC}"
else
    echo -e "${RED}✗ Новые функции не найдены${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║    Обновление успешно завершено!       ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""
echo -e "${GREEN}Запустите программу:${NC}"
echo -e "  ${YELLOW}sudo aupdate${NC}"
echo ""
echo -e "${CYAN}Новые функции v2.1.0:${NC}"
echo -e "  ${GREEN}37)${NC} Настроить автообновление"
echo -e "  ${GREEN}38)${NC} Отключить автообновление"
echo -e "  ${GREEN}39)${NC} Статус автообновления"
echo -e "  ${GREEN}40)${NC} Обновить приложение"
echo ""
echo -e "${YELLOW}Проверьте меню - должно быть 40 опций!${NC}"
echo ""
