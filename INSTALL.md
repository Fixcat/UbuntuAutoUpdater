# Руководство по установке

## Системные требования

- Ubuntu 16.04 или новее / Ubuntu Server
- Права root (sudo)
- Bash 4.0+
- apt package manager

## Способ 1: Клонирование репозитория

```bash
# Установите git (если не установлен)
sudo apt-get install git

# Клонируйте репозиторий
git clone https://github.com/ваш-username/ubuntu-system-updater.git

# Перейдите в директорию
cd ubuntu-system-updater

# Сделайте скрипт исполняемым
chmod +x system-updater.sh

# Запустите
sudo ./system-updater.sh
```

## Способ 2: Прямая загрузка

```bash
# Скачайте скрипт
wget https://raw.githubusercontent.com/ваш-username/ubuntu-system-updater/main/system-updater.sh

# Сделайте исполняемым
chmod +x system-updater.sh

# Запустите
sudo ./system-updater.sh
```

## Способ 3: Установка в систему

Для глобального доступа к команде:

```bash
# Скачайте и установите
sudo wget -O /usr/local/bin/system-updater https://raw.githubusercontent.com/ваш-username/ubuntu-system-updater/main/system-updater.sh

# Сделайте исполняемым
sudo chmod +x /usr/local/bin/system-updater

# Теперь можно запускать из любой директории
sudo system-updater
```

## Проверка установки

После установки проверьте работу:

```bash
sudo ./system-updater.sh
```

Вы должны увидеть главное меню программы.

## Удаление

### Если установлено локально:
```bash
rm -rf ubuntu-system-updater
```

### Если установлено глобально:
```bash
sudo rm /usr/local/bin/system-updater
```

## Устранение проблем

### Ошибка: "Permission denied"
```bash
chmod +x system-updater.sh
```

### Ошибка: "command not found: apt-get"
Убедитесь, что вы используете Ubuntu или Debian-based дистрибутив.

### Ошибка: "This script requires root"
Запустите с sudo:
```bash
sudo ./system-updater.sh
```
