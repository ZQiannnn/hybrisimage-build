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
