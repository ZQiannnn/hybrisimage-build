# hybrisimage-build
## Docker in Docker 用于制作基于 `stefanlehmann/hybris-base-image`的成品镜像

### Environment
```
REGISTRY: 用于推送成品镜像的docker registry
USERNAME: Docker Registry 用户名
PASSWORD: Docker Registry 密码
IMAGE_TAG: 需要生成的ImageTag
```

### Volume
```
/opt/hybris/config: HYBRIS CONFIG 文件夹
/opt/hybris/bin/custom: HYBRIS CUSTOM 文件夹
```

### Demo
```
Docker:
docker run -v /path/to/custom:/opt/hybris/bin/custom \
-v /path/to/config:/opt/hybris/config \
-e REGISTRY=localhost:5000 -e USERNAME=test \
-e PASSWORD=test -e IMAGE_TAG=hybris:latest \
--rm --name hybris-build  zqiannnn/hybris-build 
Kubernetes:
kubectl run -v /path/to/custom:/opt/hybris/bin/custom \
-v /path/to/config:/opt/hybris/config \
-e REGISTRY=localhost:5000 -e USERNAME=test \
-e PASSWORD=test -e IMAGE_TAG=hybris:latest  \
--rm --image=zqiannnn/hybris-build  --restart=Never hybris-build 
```
