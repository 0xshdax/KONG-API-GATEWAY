# KONG (API Gateway) with database
## Create network 
```
docker network create kong-net
```
## Create database, migration database & start kong with docker-compose
```
docker-compose up -d kong-database && sleep 3s && docker-compose up kong-migrations && docker-compose up -d kong
```
## Add service
```
curl -sL -X POST --url http://localhost:8001/services/ --data 'name=example' --data 'url=https://ifconfig.co/'
```
The Request Body contains:
* `name`: The Service name
* `url`: The upstream url

## Add route
```
curl -sL -X POST --url http://localhost:8001/services/example/routes --data 'hosts[]=example'
```

## Testing
```
curl -sL https://ifconfig.co/json # Call API without KONG (API GATEWAY)
curl -sL http://localhost:8000/json --header 'Host: example' # Call API with KONG (API GATEWAY)
```
