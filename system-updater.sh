#!/bin/bash

# Ubuntu System Updater
# Интерактивное приложение для управления обновлениями системы

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Проверка прав root
check_root() {
    if [ "$EUID" -ne 0 ]; then
        echo -e "${RED}Ошибка: Этот скрипт требует права root${NC}"
        echo "Запустите: sudo $0"
        exit 1
    fi
}

# Сканирование системы и поиск обновлений
scan_updates() {
    echo -e "${BLUE}=== Сканирование системы ===${NC}"
    echo -e "${YELLOW}Обновление списка пакетов...${NC}"
    
    apt-get update > /dev/null 2>&1
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ Список пакетов обновлен${NC}"
    else
        echo -e "${RED}✗ Ошибка при обновлении списка пакетов${NC}"
        return 1
    fi
    
    echo ""
    echo -e "${YELLOW}Поиск доступных обновлений...${NC}"
    
    # Получаем список обновлений
    UPDATES=$(apt list --upgradable 2>/dev/null | grep -v "Listing")
    UPDATE_COUNT=$(echo "$UPDATES" | grep -c "upgradable")
    
    if [ "$UPDATE_COUNT" -eq 0 ]; then
        echo -e "${GREEN}✓ Система полностью обновлена${NC}"
        return 2
    fi
    
    echo -e "${GREEN}Найдено обновлений: $UPDATE_COUNT${NC}"
    echo ""
    
    return 0
}

# Показать список доступных обновлений
show_updates() {
    echo -e "${BLUE}=== Список доступных обновлений ===${NC}"
    echo ""
    
    apt list --upgradable 2>/dev/null | grep "upgradable" | while read -r line; do
        PACKAGE=$(echo "$line" | cut -d'/' -f1)
        VERSION=$(echo "$line" | grep -oP '\d+[^\s]+' | head -1)
        echo -e "${YELLOW}•${NC} $PACKAGE ${GREEN}→${NC} $VERSION"
    done
    
    echo ""
}

# Обновить все пакеты
update_all() {
    echo -e "${BLUE}=== Обновление всех компонентов ===${NC}"
    echo ""
    
    read -p "Вы уверены? (y/n): " confirm
    
    if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
        echo -e "${YELLOW}Обновление отменено${NC}"
        return
    fi
    
    echo -e "${YELLOW}Начинаем обновление...${NC}"
    apt-get upgrade -y
    
    if [ $? -eq 0 ]; then
        echo ""
        echo -e "${GREEN}✓ Все компоненты успешно обновлены${NC}"
    else
        echo -e "${RED}✗ Произошла ошибка при обновлении${NC}"
    fi
}

# Обновить конкретный пакет
update_specific() {
    echo -e "${BLUE}=== Обновление конкретного компонента ===${NC}"
    echo ""
    
    read -p "Введите имя пакета: " package_name
    
    if [ -z "$package_name" ]; then
        echo -e "${RED}Имя пакета не может быть пустым${NC}"
        return
    fi
    
    # Проверяем, доступно ли обновление для этого пакета
    if apt list --upgradable 2>/dev/null | grep -q "^$package_name/"; then
        echo -e "${YELLOW}Обновление пакета: $package_name${NC}"
        apt-get install --only-upgrade "$package_name" -y
        
        if [ $? -eq 0 ]; then
            echo ""
            echo -e "${GREEN}✓ Пакет $package_name успешно обновлен${NC}"
        else
            echo -e "${RED}✗ Ошибка при обновлении пакета${NC}"
        fi
    else
        echo -e "${YELLOW}Обновление для пакета $package_name не найдено${NC}"
    fi
}

# Главное меню
show_menu() {
    echo ""
    echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║   Менеджер обновлений системы Ubuntu   ║${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
    echo ""
    echo "1) Сканировать систему и показать обновления"
    echo "2) Обновить все компоненты"
    echo "3) Обновить конкретный компонент"
    echo "4) Выход"
    echo ""
}

# Основной цикл программы
main() {
    check_root
    
    while true; do
        show_menu
        read -p "Выберите действие (1-4): " choice
        
        case $choice in
            1)
                scan_updates
                result=$?
                if [ $result -eq 0 ]; then
                    show_updates
                fi
                read -p "Нажмите Enter для продолжения..."
                ;;
            2)
                scan_updates
                result=$?
                if [ $result -eq 0 ]; then
                    update_all
                elif [ $result -eq 2 ]; then
                    echo -e "${GREEN}Обновления не требуются${NC}"
                fi
                read -p "Нажмите Enter для продолжения..."
                ;;
            3)
                scan_updates
                result=$?
                if [ $result -eq 0 ]; then
                    show_updates
                    update_specific
                elif [ $result -eq 2 ]; then
                    echo -e "${GREEN}Обновления не требуются${NC}"
                fi
                read -p "Нажмите Enter для продолжения..."
                ;;
            4)
                echo -e "${GREEN}Выход из программы${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}Неверный выбор. Попробуйте снова.${NC}"
                sleep 2
                ;;
        esac
        
        clear
    done
}

# Запуск программы
clear
main
