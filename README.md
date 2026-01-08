# nifi-docker

Учебный стенд для знакомства с Apache NiFi и Kafka: NiFi + NiFi Registry + Postgres + Kafka + Kafka UI.

## Быстрый старт
```sh
docker compose up -d
docker compose ps
```

Остановить:
```sh
docker compose stop
```

Удалить контейнеры и сеть:
```sh
docker compose down
```

Удалить ещё и данные Postgres (деструктивно):
```sh
docker compose down -v
```

## Адреса и доступы
- NiFi: http://localhost:18443/nifi/ (логин `admin`, пароль `Password123456`)
- NiFi docs: https://nifi.apache.org/documentation/
- Registry: http://localhost:18080/nifi-registry
- Registry docs: https://nifi.apache.org/docs/nifi-registry-docs/
- Kafka UI: http://localhost:8082/
- Kafka UI docs: https://docs.kafka-ui.provectus.io/

## Важно про адреса (внутри Docker vs с хоста)
Если ты настраиваешь подключение *в NiFi*, то `localhost` почти всегда будет неправильным (NiFi живёт в контейнере).

Используй имена сервисов из `docker-compose.yml`:
- Postgres (из NiFi): `jdbc:postgresql://postgres:5432/app`
- Kafka (из NiFi): `kafka:29092`
- Registry (из NiFi): `http://registry:18080`

А с локальной машины:
- Postgres: `jdbc:postgresql://localhost:5437/app`
- Kafka: `localhost:9092`

## PostgreSQL
JDBC драйвер лежит в `drivers/` и монтируется в контейнер NiFi как `/opt/nifi/nifi-current/drivers/`.

Параметры для DBCP в NiFi:
- Database Connection URL: `jdbc:postgresql://postgres:5432/app`
- Database Driver Class Name: `org.postgresql.Driver`
- driver location: `/opt/nifi/nifi-current/drivers/postgresql-42.7.4.jar`
- user/password: `postgres`/`postgres`

### Подключение через DBeaver (удобнее всего)
Postgres проброшен наружу на порт `5437`, поэтому из DBeaver подключайся так:
- Host: `localhost`
- Port: `5437`
- Database: `app`
- Username: `postgres`
- Password: `postgres`

Если DBeaver попросит драйвер — соглашайся скачать/установить PostgreSQL driver.

Инициализация демо-схем/таблиц:
```sh
docker compose exec -T postgres psql -U postgres -d app -f /nifi-templates/SampleKafka2Postgres.sql
```

### Через консоль (если нужно)
Просмотр данных:
```sh
docker compose exec -it postgres bash -c "export PGPASSWORD=postgres; psql -U postgres -d app"
select * from ods.samplekafka2postgres order by id desc limit 10;
```

## Kafka
- С локальной машины (например, для консольных утилит): `localhost:9092`
- Из NiFi (внутри Docker): `kafka:29092`

## Примеры flow (шаблоны)
В `nifi-templates/` лежат примеры:
- `Sample2Kafka.xml` / `Sample2Kafka.json` — публикует сообщения в Kafka topic `Sample2Kafka`
- `SampleKafka2Postgres.json` — читает из Kafka и пишет в Postgres (в `stg.samplekafka2postgres`, затем вызывает `ods.load_samplekafka2postgres()`)

Рекомендуемый минимальный сценарий:
1) Создай topic `Sample2Kafka` в Kafka UI (если он не создался автоматически).
2) Импортируй flow в NiFi (в зависимости от UI: import/upload template для `.xml` или import flow definition для `.json`).
3) Внутри flow включи Controller Services, затем стартуй процессоры.

Kafka UI уже настроен в `docker-compose.yml`:
- Cluster name: `Kafka Cluster`
- Bootstrap Servers: `kafka:29092`

## Shared folder
Каталог `shared-folder/` на хосте смонтирован в контейнер NiFi как `/opt/nifi/nifi-current/ls-target` (удобно для ListFile/GetFile).
Если после запуска контейнеров появляются проблемы с правами: `sudo chown -R $USER shared-folder`.

## Полезные команды
```sh
docker compose logs -f nifi
docker compose logs -f kafka
docker compose exec postgres bash
```

Для доступа из NiFi к сервисам на локальной машине используй `host.docker.internal` вместо `localhost`.

## Если что-то не работает
- NiFi может запускаться 1–3 минуты; смотри `docker compose logs -f nifi`.
- Если процессор в NiFi не коннектится к Kafka/Postgres, проверь, что используешь адреса “из NiFi” (см. раздел про Docker).
- Если порты заняты, поменяй проброс портов в `docker-compose.yml`.
