# hybrisimage-build
## Docker in Docker 用于制作基于 `zqiannnn/hybris-base-image`的成品镜像

### Environment
```
REGISTRY: 需要登录的Docker Registry
USERNAME: Docker Registry 用户名
PASSWORD: Docker Registry 密码
IMAGE_TAG: 需要生成的ImageTag ([REGISTRY_HOST[:REGISTRY_PORT]/]REPOSITORY[:TAG])
```

### Volume
```
/opt/hybris/config: HYBRIS CONFIG 文件夹
/opt/hybris/bin/custom: HYBRIS CUSTOM 文件夹
```

### Demo
**Docker:**
> alipine
```
docker run -v /Users/zhang/Work/WorkSpace/ln/hybris/bin/custom:/opt/hybris/bin/custom \
-v /Users/zhang/Work/WorkSpace/ln/hybris/config:/opt/hybris/config \
-v /Users/zhang/Work/Resource/Hybris/6.3:/opt/binaries \
-e REGISTRY=172.17.0.2:5000 \
-e IMAGE_TAG=172.17.0.2:5000/zqiannnn/hybris:latest \
--privileged --rm  zqiannnn/hybris-build:alpine
```

> ubuntu
```
docker run -v /path/to/custom:/opt/hybris/bin/custom \
-v /path/to/config:/opt/hybris/config \
-e REGISTRY=172.17.0.1:5000 \
-e IMAGE_TAG=172.17.0.1:5000/hybris:latest \
--privileged --rm --name hybris-build  zqiannnn/hybris-build:6.3
```
