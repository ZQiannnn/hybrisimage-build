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
> 外挂HYBRIS模式
```
docker run -v /path/to/bin:/opt/hybris/bin \
-v /path/to/config:/opt/hybris/config \
-e REGISTRY=172.17.0.1:5000 \
-e IMAGE_TAG=172.17.0.1:5000/hybris:latest \
--privileged --rm --name hybris-build  zqiannnn/hybris-build:extenal
```

> 内置HYBRIS模式（适用于持续集成）
```
docker run -v /path/to/custom:/opt/hybris/bin/custom \
-v /path/to/config:/opt/hybris/config \
-e REGISTRY=172.17.0.1:5000 \
-e IMAGE_TAG=172.17.0.1:5000/hybris:latest \
--privileged --rm --name hybris-build  zqiannnn/hybris-build:6.3
```
**Kubernetes:**
```
kubectl run -v /path/to/bin:/opt/hybris/bin \
-v /path/to/config:/opt/hybris/config \
-e REGISTRY=localhost:5000 -e USERNAME=test \
-e PASSWORD=test -e IMAGE_TAG=172.17.0.1:5000/hybris:latest  \
--rm --image=zqiannnn/hybris-build  --restart=Never hybris-build 
```
