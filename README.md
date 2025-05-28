# ⛏️ Установка и запуск Nockchain Miner на Ubuntu 22.04+

Этот репозиторий содержит автоматический скрипт для установки и запуска ноды `nockchain` и включения майнинга на сервере под Ubuntu без Docker.

---

## 🚀 Быстрый старт

```bash
# Клонируем репозиторий
curl -sL https://raw.githubusercontent.com/vasyagun/nockchain/main/bootstrap_nockchain.sh | bash
```
```bash
# Перейти в папку проекта:
cd /root/nockchain
```
```bash
# Создать .env файл с ключом для майнинга:
nano .env
```
```bash
# Вставь туда/редактируй:
RUST_LOG=info,nockchain=info,nockchain_libp2p_io=info,libp2p=info,libp2p_quic=info
MINIMAL_LOG_FORMAT=true
MINING_PUBKEY= СЮДА ПИШИ СВОЙ КОШЕЛЬ
```
```bash
# Сделать скрипт запуска исполняемым:
chmod +x scripts/run_nockchain_miner.sh
```
```bash
# Запустить майнинг:
./scripts/run_nockchain_miner.sh
```

```bash
# Вот так выглядит синхорн блоков перед майнингом:
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
