# ⛏️ Установка и запуск Nockchain Miner на Ubuntu 22.04+

Этот репозиторий содержит автоматический скрипт для установки и запуска ноды `nockchain` и включения майнинга на сервере под Ubuntu без Docker.

# Установка и запуск Nockchain

Автоматизированный скрипт установки и запуска Nockchain под Ubuntu 22.04+.

## 📥 Установка (одной командой)

```bash
bash <(curl -s https://raw.githubusercontent.com/vasyagun/nockchain/main/install_nockchain.sh)
```

## 🔑 Поддерживаются два режима запуска

### ✅ Режим 1: У вас уже есть `MINING_PUBKEY`

Перед запуском экспортируйте переменную:

```bash
export MINING_PUBKEY="ВАШ_ПУБЛИЧНЫЙ_КЛЮЧ"
```

Затем запускайте установку. Скрипт сам:

* Подтянет зависимости и установит Rust;
* Клонирует и соберёт `nockchain`;
* Применит оптимизации памяти;
* Запишет ваш `MINING_PUBKEY` в `.env`;
* Запустит майнинг в `screen`.

### 🕹️ Режим 2: У вас пока нет ключа

Скрипт выполнит установку, но **не запустит майнинг**. В конце вы получите инструкции:

* Сгенерируйте ключ:

  ```bash
  nockchain-wallet keygen
  ```
* Вставьте ключ в `.env`:

  ```bash
  nano .env
  ```
* Запустите майнинг вручную:

  ```bash
  cd ~/nockchain && bash ./scripts/run_nockchain_miner.s
  ```

## 🚀 Дополнительно: Ускоренная синхронизация через чекпоинт

После первого запуска майнинга, у вас появится директория `~/.data.nockchain/checkpoints`. Скрипт предложит загрузить дамп блоков:

```bash
Желаете загрузить быстрый дамп базы блоков (y/n)?
```

При подтверждении загрузятся и распакуются свежие чекпоинты.

---

## 🧠 Примечание по памяти

В скрипте уже предусмотрена модификация исходного кода:

* `BTreeMap` → `HashMap` в `p2p_util.rs`

Это позволяет уменьшить потребление RAM и диска во время работы.

---

## 📂 Репозиторий

[https://github.com/vasyagun/nockchain](https://github.com/vasyagun/nockchain)

---

## 📞 Обратная связь

По вопросам запуска или ошибок — создайте Issue или напишите автору в Telegram: [@vasyagun](https://t.me/vasyagun)


# Вот так выглядит синхорн блоков перед майнингом:
```bash
# ./scripts/run_nockchain_miner.sh

    _   _            _        _           _
   | \ | | ___   ___| | _____| |__   __ _(_)_ __
   |  \| |/ _ \ / __| |/ / __| '_ \ / _` | | '_ \
   | |\  | (_) | (__|   < (__| | | | (_| | | | | |
   |_| \_|\___/ \___|_|\_\___|_| |_|\__,_|_|_| |_|

Nockchain Version Info:
Build label: unknown
Build host: unknown
Build user: unknown
Build timestamp: unknown
Build date: unknown
� driver 'bitcoin_watcher' initialized
I (10:15:18) libp2p_swarm: local_peer_id=12D3KooWHqiV8AUX84eqaztFMXV6gteC6pXqyWjU1jWVfoVabcdf
I (10:15:18) driver_init: driver 'libp2p' initialized
I (10:15:18) nc: Failed to bootstrap: No known peers.
I (10:15:19) heaviest block unchanged, do not generate new candidate block
I (10:15:19) driver_init: driver 'mining' initialized
I (10:15:19) driver_init: all drivers initialized, born poke sent
I (10:15:49) nc: SEvent: friendship ended with 12D3KooWSKfMviVam4PEpqeFDV1zQhwTRRhXUo41Gi2MJbfUgrCD via: Dialer { address: /ip4/216.82.192.27/udp/3127/quic-v1/p2p/12D3KooWSKfMviVam4PEpqeFDV1zQhwTRRhXUo41Gi2MJbfUgrCD, role_override: Dialer, port_use: Reuse }. cause: Some(KeepAliveTimeout)
I (10:15:50) nc: SEvent: friendship ended with 12D3KooWLVZEFz9qzY3GmEZgZkfRtZ7yx4ZdPGhtqeAn2CvPuQkD via: Dialer { address: /ip4/216.82.192.27/udp/3335/quic-v1/p2p/12D3KooWLVZEFz9qzY3GmEZgZkfRtZ7yx4ZdPGhtqeAn2CvPuQkD, role_override: Dialer, port_use: Reuse }. cause: Some(KeepAliveTimeout)
I (10:16:47) nc: SEvent: friendship ended with 12D3KooWSKfMviVam4PEpqeFDV1zQhwTRRhXUo41Gi2MJbfUgrCD via: Dialer { address: /ip4/216.82.192.27/udp/3127/quic-v1/p2p/12D3KooWSKfMviVam4PEpqeFDV1zQhwTRRhXUo41Gi2MJbfUgrCD, role_override: Dialer, port_use: Reuse }. cause: Some(KeepAliveTimeout)
I (10:16:47) nc: SEvent: friendship ended with 12D3KooWLVZEFz9qzY3GmEZgZkfRtZ7yx4ZdPGhtqeAn2CvPuQkD via: Dialer { address: /ip4/216.82.192.27/udp/3335/quic-v1/p2p/12D3KooWLVZEFz9qzY3GmEZgZkfRtZ7yx4ZdPGhtqeAn2CvPuQkD, role_override: Dialer, port_use: Reuse }. cause: Some(KeepAliveTimeout)
I (10:17:15) nc: SEvent: friendship ended with 12D3KooWKqnhn7HnfP5EtyBZWFGEDw62Sg1wycrFcpYCQonYZ8KD via: Dialer { address: /dnsaddr/nockchain-backbone.zorp.io, role_override: Dialer, port_use: Reuse }. cause: Some(KeepAliveTimeout)
I (10:17:33) block 5yW4h3UTATY8zYH8wqkgU4XJu9njUU7dKUbjkNwjzAaHBD2NdMQm34c added to validated blocks at 37
I (10:17:33) 5yW4h3UTATY8zYH8wqkgU4XJu9njUU7dKUbjkNwjzAaHBD2NdMQm34c is new heaviest block
I (10:17:33) dumbnet: new heaviest block!
I (10:17:33) generating new candidate block with parent: 5yW4h3UTATY8zYH8wqkgU4XJu9njUU7dKUbjkNwjzAaHBD2NdMQm34c
I (10:17:33) [%mining-on 18.423.616.470.032.832.226 6.250.162.932.000.668.855 7.829.058.353.181.047.420 2.812.511.886.082.814.085 4.178.600.370.152.639.741]
I (10:17:33) [no] kernel::form: No existing state found - initializing fresh state
I (10:17:33) candidate block timestamp updated: 0x8000000d36d4f03d
I (10:17:35) [%build-hash 0v1.lgic1]
```



### Как сгенерить кошелек 

# В папке проекта nockchain, после компиляции
```bash
nockchain-wallet keygen
```
Далее приложение выведет тебе все твои данные типо:
```bash
Keygen

New Public Key

"3c9qSJyairLs3AsvHLPENuie....................Up64rx5GN7CgUb7WAxWtkNfmVDHzBBBf7QoebYnr"



New Private Key

"AUjxx1ZL.................iN2HqJc5g"



Chain Code

"69kRtCD.................JByMa6"



Seed Phrase

'cattle dirt crucial mystery ............... taste tip case wall leader also sheriff'
```
# Backup Keys
```bash
nockchain-wallet export-keys
```

```bash
nockchain-wallet import-keys --input keys.export
```


### Проверить баланс
```bash
nockchain-wallet --nockchain-socket .socket/nockchain_npc.sock list-notes
```
Вывод будет что то вроде:
```bash
- name: [first='xxxxx' last='xxxxx']
- assets: 2.576.980.378
- source: [p=[BLAH] is-coinbase=%.y]
```


# Ошибки и их решение

1) Если при запуске майнинга видим ошибку:
```
I (12:17:17) libp2p_swarm: local_peer_id=12D3KooWQ4xDnDHzBLb7oAvNwinuaCw1SaGyp8pEhiBrWYVVRcyG
Error: Os { code: 98, kind: AddrInUse, message: "Address already in use" }
```

Значит нужно ввести команду:
```bash
rm -rf .socket
```

2) Если при запуске майнига пошел синхрон, но вылезает ошибка в логе:
```
Could not load mining kernel: OneshotChannelError(RecvError(()))
2025-05-29T06:04:55.399174Z  WARN nockchain::mining: Error during mining attempt: JoinError::Panic(Id(922), "Could not load mining kernel: OneshotChannelError(RecvError(()))", ...
```

Значит нужно остановить процесс и ввести команду:
```bash
sudo sysctl vm.overcommit_memory=1
