#!/bin/bash

set -e

# Цветной вывод
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Проверка переменной окружения
if [ -z "$MINING_PUBKEY" ]; then
    echo -e "${GREEN}[INFO]${NC} Переменная MINING_PUBKEY не найдена. Скрипт выполнит установку без запуска майнинга."
    SKIP_MINING=true
else
    echo -e "${GREEN}[INFO]${NC} MINING_PUBKEY найден: $MINING_PUBKEY"
    SKIP_MINING=false
fi

# 1. Установка системных зависимостей
sudo apt update
sudo apt install -y git curl nano screen build-essential clang llvm-dev libclang-dev pkg-config libssl-dev python3-pip unzip

# 2. Установка Rust и hoonc
curl https://sh.rustup.rs -sSf | sh -s -- -y
source "$HOME/.cargo/env"
rustup component add clippy rustfmt

# 3. Клонирование репозитория
cd ~
git clone https://github.com/zorp-corp/nockchain.git || true
cd nockchain

# 4. Установка hoonc и подготовка окружения
cp .env_example .env || true
make install-hoonc
export PATH="$HOME/.cargo/bin:$PATH"

# 5. Быстрый патч
git fetch origin pull/7/head:fast-sync-mpeval
git checkout fast-sync-mpeval

# 5.1. Оптимизация потребления памяти
sed -i 's/BTreeMap/HashMap/g' crates/nockchain-libp2p-io/src/p2p_util.rs
sed -i 's/{BTreeMap, BTreeSet}/{HashMap, BTreeSet}/' crates/nockchain-libp2p-io/src/p2p_util.rs
sed -i 's/use std::collections::BTreeMap;/use std::collections::HashMap;/' crates/nockchain-libp2p-io/src/p2p_util.rs

# 6. Сборка
make build

# 7. Установка ноды и кошелька
make install-nockchain-wallet
make install-nockchain
export PATH="$HOME/.cargo/bin:$PATH"

# 8. Работа с ключом
if [ "$SKIP_MINING" = false ]; then
    sed -i "s|^MINING_PUBKEY=.*$|MINING_PUBKEY=$MINING_PUBKEY|" .env || echo "MINING_PUBKEY=$MINING_PUBKEY" >> .env
else
    echo -e "${GREEN}[INFO]${NC} Вы можете сгенерировать ключ командой: nockchain-wallet keygen"
    echo -e "${GREEN}[INFO]${NC} Затем добавьте его в .env и запустите майнинг вручную."
fi

# 9. Параметры ядра для Hive
sudo sysctl -w vm.overcommit_memory=1

# 10. Запуск майнинга в screen (если есть ключ)
if [ "$SKIP_MINING" = false ]; then
    screen -dmS nock_miner bash -c "cd ~/nockchain && bash ./scripts/run_nockchain_miner.s"
    echo -e "${GREEN}[DONE]${NC} Майнинг запущен в screen-сессии nock_miner"
else
    echo -e "${RED}[SKIP]${NC} Майнинг не запущен, так как не найден MINING_PUBKEY"
fi

# Инструкция на финал
if [ "$SKIP_MINING" = true ]; then
    echo -e "\n${GREEN}[NEXT]${NC} После генерации ключа и добавления в .env запустите майнинг:"
    echo "cd ~/nockchain && bash ./scripts/run_nockchain_miner.s"
fi

########################################
# Скрипт для загрузки дампа блоков
########################################

read -p $'\n\033[1;33mЖелаете загрузить быстрый дамп базы блоков (y/n)? \033[0m' choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
    cd ~/nockchain
    pip3 install --no-cache-dir gdown
    gdown --id 1bQGa3qSXN2mGHOXcIti0A94dSEEV4D0L -O checkpoints.zip

    if [ ! -d .data.nockchain/checkpoints ]; then
        echo -e "${RED}[ERROR]${NC} Папка .data.nockchain/checkpoints не найдена. Убедитесь, что скрипт майнинга был запущен хотя бы один раз."
        exit 1
    fi

    unzip -j checkpoints.zip '*/checkpoints/*.chkjam' \
          -d .data.nockchain/checkpoints
    echo -e "${GREEN}[DONE]${NC} Чекпоинты успешно обновлены."
else
    echo -e "${GREEN}[SKIP]${NC} Пропущена загрузка чекпоинтов."
fi
