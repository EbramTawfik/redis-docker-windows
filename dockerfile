FROM mcr.microsoft.com/powershell:nanoserver-ltsc2022

LABEL author="Ebram Tawfik"
LABEL maintainer="ebram.tawfik.dev@gmail.com"

USER ContainerAdministrator
SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Env var redis
RUN $newPath = ('c:\redis;{0}' -f $env:PATH); 	Write-Host ('Updating PATH: {0}' -f $newPath); 	setx /M PATH $newPath;

# Download redisw
ARG REDIS_VERSION=5.0.14.1
ADD https://github.com/tporadowski/redis/releases/download/v${REDIS_VERSION}/Redis-x64-${REDIS_VERSION}.zip redis.zip

# Install redis
RUN Expand-Archive .\redis.zip -DestinationPath c:\redis;
RUN Write-Host 'Verifying install ("redis-server --version") ...';
RUN redis-server --version;

# Clean files
RUN Write-Host 'Removing ...';
RUN Remove-Item .\redis.zip -Force;

# Configuration
RUN (Get-Content c:\redis\redis.windows.conf) 	-Replace '^(bind)\s+.*$', '$1 0.0.0.0' 	-Replace '^(protected-mode)\s+.*$', '$1 no' 	| Set-Content C:\Redis\redis.docker.conf;

# Volumes
VOLUME "c:\data"
WORKDIR "c:\data"

# Ports
EXPOSE 6379/tcp

ENTRYPOINT [ "redis-server.exe" ]
CMD ["c:\\redis\\redis.docker.conf"]
