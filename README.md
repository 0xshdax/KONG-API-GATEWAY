# KONG (API Gateway) with database
## Port listing
```yaml
version: '3.9'
services:
  kong-database:
    image: postgres:9.6
    container_name: kong-database
    [...]
  ports:
      - '5432:5432' ## You can change port, for example 1111:5432
  [...]
  kong:
    platform: linux/amd64
    [...]
  ports:
      - '8000:8000' ## You can change port, for example 80:8000
      - '8443:8443' ## You can change port, for example 433:8433
      - '8001:8001' ## Delete after setting
      - '8444:8444' ## Delete after setting
```
## Installation 
```
0xshdax@github:~$ chmod +x create.sh
0xshdax@github:~$ ./create.sh
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
