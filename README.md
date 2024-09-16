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

Запуск для учебных целей
```sh
docker run --name postgres_app -p 5432:5432 -e POSTGRESS_USER=postgres -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=app -d postgres:16.4
```
Строка connection: `jdbc://host.docker.internal:5432/app`  

## Другое

Файловая система хоста (каталог `shared-folder`) подключена к `/opt/nifi/nifi-current/ls-target`  

Для подключения к сервисам, работающим на локальной машине, вместо `localhost` использовать `host.docker.internal`


