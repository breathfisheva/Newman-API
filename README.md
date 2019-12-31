# Newman-API

1.create “collection_dir” file
Using “;” to separate different file 
mycollection.json;data.csv
mycollection.json;data1.csv
2.create a shell file “script.sh" to read “collection_dir” file
#!/bin/sh

while IFS=';' read collectionName dataFile environmentFile; do
    echo "${collectionName}"
    echo "${dataFile}" 
    newman run ${collectionName} -r htmlextra --reporter-htmlextra-export test${collectionName}.html  -d ${dataFile}
done < collection_dir

* #!/bin/sh 需要加上这一句，不是#!/bin/bash
3.create a “Dockerfile” 
FROM node:alpine

RUN apk add --update bash
RUN npm install -g newman-reporter-html newman 

WORKDIR /app
COPY . /app

RUN ["chmod", "+x", "script.sh”] 
CMD ["sh", "./script.sh"]

* FROM node:alpine 安装精简版的node （安装node是为了后面用npm 安装 newman和 newman-reporter-html ）
* RUN apk add --update bash 因为精简版node不支持执行shell 脚本，所以安装bash
* WORKDIR /app   COPY . /app 在docker 内部新建一个文件夹app，然后把本机当前的目录拷贝到docker容器里app文件夹内
* RUN ["chmod", "+x", "script.sh”]  把script.sh变成可执行的脚本
* CMD ["sh", "./script.sh”] 执行script.sh
整个文件结构如下：


4.执行-本地
sh script.sh

5.执行-docker
cd code/postmanproject/
docker build -t lucy/newman .
docker run -a stdout lucy/newman

6.debug
docker ps -a  (获取containerID）
docker logs d92dbc5bea5c  （查看这个containerID 对应的log）

7.查看docker容器里的内容
docker run -it --entrypoint "/bin/sh" lucy/newman
