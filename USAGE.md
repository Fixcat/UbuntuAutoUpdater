# Руководство по использованию

## Установка

```bash
# Клонируйте репозиторий
git clone https://github.com/Fixcat/UbuntuAutoUpdater.git
cd UbuntuAutoUpdater

# Установите в систему
chmod +x install.sh
sudo ./install.sh
```

## Запуск

После установки запускайте программу командой:

```bash
sudo aupdate
```

## Основные команды

### 1. Сканирование системы

```bash
sudo aupdate
# Выберите: 1
```

Программа проверит наличие доступных обновлений и покажет список.

### 2. Обновление всех компонентов

```bash
sudo aupdate
# Выберите: 2
# Подтвердите: y
```

Обновит все пакеты в системе.

### 3. Обновление конкретного пакета

```bash
sudo aupdate
# Выберите: 3
# Введите имя пакета: nginx
```

Обновит только указанный пакет.

### 4. Выход

```bash
# В меню выберите: 4
```

## Удаление

Для удаления программы из системы:

```bash
cd UbuntuAutoUpdater
chmod +x uninstall.sh
sudo ./uninstall.sh
```

Или вручную:

```bash
sudo rm /usr/local/bin/aupdate
```

## Примеры использования

### Быстрая проверка обновлений

```bash
sudo aupdate
# Нажмите 1, Enter, просмотрите список, Enter, 4 для выхода
```

### Полное обновление системы

```bash
sudo aupdate
# Нажмите 2, y для подтверждения, дождитесь завершения
```

### Обновление веб-сервера

```bash
sudo aupdate
# Нажмите 3, введите "nginx", дождитесь завершения
```

## Требования

- Ubuntu / Ubuntu Server
- Права root (sudo)
- apt package manager

## Устранение проблем

### Команда не найдена

Если после установки команда `aupdate` не работает:

```bash
# Проверьте установку
ls -la /usr/local/bin/aupdate

# Переустановите
cd UbuntuAutoUpdater
sudo ./install.sh
```

### Ошибка прав доступа

Всегда используйте `sudo`:

```bash
sudo aupdate
```

### Ошибка apt-get

Убедитесь, что вы используете Ubuntu или Debian-based систему.
