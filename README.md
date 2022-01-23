# How to ?
## Pull image docker

```
docker pull --platform=linux/amd64 kong:2.7.0-alpine
docker pull postgres:9.6 
```

## Create database (postgres)
```
docker run -d --name kong-database --network=kong-net \
-e "POSTGRES_USER=kong" -e "POSTGRES_DB=kong" -e "POSTGRES_PASSWORD=kong" \
-p 5432:5432 postgres:9.6
```

## Migration to database
```
docker run --rm --network=kong-net \
-e "KONG_DATABASE=postgres" -e "KONG_PG_HOST=kong-database" \
-e "KONG_PG_PASSWORD=kong" kong:2.7.0-alpine kong migrations bootstrap
```

## Start kong
```
docker run -d --name kong --network=kong-net \
-e "KONG_DATABASE=postgres" -e "KONG_PG_HOST=kong-database" \
-e "KONG_PG_PASSWORD=kong" -e "KONG_PROXY_ACCESS_LOG=/dev/stdout" \
-e "KONG_ADMIN_ACCESS_LOG=/dev/stdout" -e "KONG_PROXY_ERROR_LOG=/dev/stderr" \
-e "KONG_ADMIN_ERROR_LOG=/dev/stderr" -e "KONG_ADMIN_LISTEN=0.0.0.0:8001, 0.0.0.0:8444 ssl" \
-p 8000:8000 -p 8443:8443 -p 8001:8001 -p 8444:8444 kong:2.7.0-alpine
```

## Add service
```
curl -i -X POST --url http://localhost:8001/services/ --data 'name=example' --data 'url=https://ifconfig.co/'
```
The Request Body contains:
* `name`: The Service name
* `url`: The upstream url

## Add route
```
curl -i -X POST --url http://localhost:8001/services/example/routes --data 'hosts[]=example'
```

## Testing
```
curl -sL https://ifconfig.co/json # Call API without kong
curl http://localhost:8000/json --header 'Host: example' # Call API with KONG
```
