#!/usr/bin/env bash
# bootstrap_nockchain.sh ─ «one-shot» развёртка Nockchain-майнера
# Tested: Ubuntu 22.04/24.04 x86_64
set -euo pipefail
IFS=$'\n\t'

## ───────────────────────────── Настройки ───────────────────────────── ##
GIT_REPO="https://github.com/zorp-corp/nockchain.git"
INSTALL_DIR="$HOME/nockchain"                 # куда клонировать
PUBKEY="3c9qSJyairLs3AsvHLPENuieog4tAYk3KEmDuCQYN3qExtxg7yKPyb2qGCnemiRpj8G2dqmeRqmVvwiRLN8r53LJb4VKUp64rx5GN7CgUb7WAxWtkNfmVDHzBBBf7QoebYnr"
RUST_PROFILE="minimal"                        # rustup profile

## ───────────────────────── 1. Системные пакеты ─────────────────────── ##
echo "==> Installing Ubuntu build dependencies…"
sudo apt-get update -qq
sudo apt-get install -y --no-install-recommends \
  build-essential clang llvm-dev libclang-dev pkg-config git curl ca-certificates

## ──────────────────────── 2. Rust toolchain (rustup) ──────────────────##
if ! command -v rustup >/dev/null 2>&1; then
  echo "==> Installing Rust toolchain ($RUST_PROFILE)…"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
    | sh -s -- -y --profile "$RUST_PROFILE"
fi
source "$HOME/.cargo/env"

## ─────────────────────────── 3. Clone repo ─────────────────────────── ##
echo "==> Cloning nockchain to $INSTALL_DIR"
rm -rf "$INSTALL_DIR"
git clone --depth 1 "$GIT_REPO" "$INSTALL_DIR"
cd "$INSTALL_DIR"

## ───────────────────── 4. .env с вашим pubkey ──────────────────────── ##
echo "==> Creating .env with your MINING_PUBKEY"
cp .env_example .env
sed -i "s/^MINING_PUBKEY=.*/MINING_PUBKEY=$PUBKEY/" .env

## ─────────────────────────── 5. Build ─────────────────────────────── ##
echo "==> Building nockchain in release mode… (может занять 5-15 мин)"
cargo build --release

## ─────────────────────── 6. Первая инициализация ───────────────────── ##
echo "==> Launching miner for the first time…"
scripts/run_nockchain_miner.sh

echo -e "\n✅  Всё готово! Узел запущен; логи идут в консоль."
echo "   Чтобы остановить: Ctrl-C. Чтобы запустить снова:"
echo "   cd \"$INSTALL_DIR\" && scripts/run_nockchain_miner.sh"
