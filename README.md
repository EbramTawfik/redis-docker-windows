# redis-docker-windows

Redis image for Windows 

## Overview

Quick implementation of redis for docker windows. For more information see this link : [redis for Windows](https://github.com/tporadowski/redis).

## How to use

### Use pre-built docker image

You can find the pre-build docker image on [Docker Hub](https://hub.docker.com/r/ebramtawfik/redis-windows-nanoserver).

Pull it :

```powershell
docker pull ebramtawfik/redis-windows-nanoserver:5.0.14.1
```

Run it like that : 

```powershell
docker run --name my-redis -p 6379:6379 -d ebramtawfik/redis-windows-nanoserver:5.0.14.1
```

Or with a password :

```powershell
docker run --name my-redis -p 6379:6379 -d ebramtawfik/redis-windows-nanoserver:5.0.14.1 --requirepass MySuperPassword
```

### Build your own

```powershell
docker build --pull --rm -f "dockerfile" -t <imagee_name>:<tag> .
```
