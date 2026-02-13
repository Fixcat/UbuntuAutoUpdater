#!/bin/bash

# Скрипт для быстрой загрузки на GitHub

echo "🚀 Загрузка Ubuntu System Updater v2.0 на GitHub"
echo ""

# Инициализация Git
echo "📦 Инициализация Git..."
git init

# Добавление файлов
echo "📝 Добавление файлов..."
git add .

# Создание коммита
echo "💾 Создание коммита..."
git commit -m "Release v2.0.0: Added 70+ new features

- Added 36 interactive menu options
- Package management (install, remove, reinstall, search)
- System maintenance (autoremove, fix dependencies, remove old kernels)
- Monitoring and statistics
- Backup and restore functionality
- Advanced package management (hold/unhold, dependencies)
- Automatic logging of all operations
- Repository management
- Security updates
- Update script for easy upgrades
- And much more!"

# Подключение репозитория
echo "🔗 Подключение к GitHub..."
git remote add origin https://github.com/Fixcat/UbuntuAutoUpdater.git 2>/dev/null || git remote set-url origin https://github.com/Fixcat/UbuntuAutoUpdater.git

# Переименование ветки
echo "🌿 Переименование ветки..."
git branch -M main

# Загрузка
echo "⬆️ Загрузка на GitHub..."
git push -u origin main --force

echo ""
echo "✅ Готово! Проект загружен на GitHub"
echo "🌐 https://github.com/Fixcat/UbuntuAutoUpdater"
echo ""
