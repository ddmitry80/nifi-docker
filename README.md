# nifi-docker

Учебная система, включающая в себя NiFi, NiFi Registry, Postgres, Kafka, Kafka UI

Обычный запуск
```sh
docker compose up
```

Остановить
```sh
docker compose stop
```

## NiFi
docs: https://nifi.apache.org/documentation/  
url: http://localhost:18443/nifi/  

## Registry
docs: https://nifi.apache.org/docs/nifi-registry-docs/  
url: http://localhost:18080/nifi-registry  

Подключение к registry: http://registry:18080

## Подключение к БД

### PostgreSQL
Расположение драйвера в контейнере: `/opt/nifi/nifi-current/drivers/postgresql-42.7.4.jar ` 

- Строка connection: `jdbc:postgresql://posgtgres:5432/app`  
- Database Driver Class Name: `org.postgresql.Driver`  
- user/password: `postgres`/`postgres`  

Для заливки дампа
```sh
docker compose exec -it postgres su postgres
psql -d app < /nifi-templates/SampleKafka2Postgres.sql
```

Просмотр таблицы
```sh
docker compose exec -it postgres bash -c "export PGPASSWORD=postgres; psql -U postgres -d app"
select * from samplekafka2postgres order by id desc limit 10;
```

Для доступа снаружи используется порт 5437 или jdbc:postgresql://localhost:5437/app

## Kafka
Доступна для учебных задач на порту 9092, имя хоста `kafka`  

## Kafka-UI
doc: 
- https://docs.kafka-ui.provectus.io/
- https://habr.com/ru/articles/753398/  

ui: http://localhost:8082/   
При настройке указать:
- Cluster name: `Kafka Cluster` или любое другое
- Bootstrap Servers: `PLAINTEXT://kafka` port `29092`



## Другое

Файловая система хоста (каталог `shared-folder`) подключена к `/opt/nifi/nifi-current/ls-target`  

Для подключения из NiFi к сервисам, работающим на локальной машине, вместо `localhost` использовать `host.docker.internal`


