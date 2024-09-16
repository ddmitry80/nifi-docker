# nifi-docker

Простой инстанс NiFi и NiFi Registry, для учебных целей

Обычный запуск
```sh
docker compose up
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

Строка connection: `jdbc://posgtgres:5432/app`  
user/password: `postgres`/`postgres`  

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

Для подключения к сервисам, работающим на локальной машине, вместо `localhost` использовать `host.docker.internal`


