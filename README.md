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

### Подключение к registry
http://registry:18080

## Подключение к БД

### Драйвер postgreSQL
Расположение в контейнере: `/opt/nifi/nifi-current/drivers/postgresql-42.7.4.jar ` 

Файловая система хоста:  `/opt/nifi/nifi-current/ls-target  `

