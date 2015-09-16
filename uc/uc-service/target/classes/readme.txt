配置文件分三个环境：本地环境，现网环境和测试环境
需要针对不同的环境有不同的配置的文件有：application.properties,dubbo.properties,logback.xm
1. 本地环境对应main/resources目录下面的文件；
2. 现网环境对应main/resources/configs/prod
3. 测试环境对应main/resources/configs/dev

现网和测试换部署时，需要将对应的文件拷贝到main/resources目录下面