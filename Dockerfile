FROM node:alpine

RUN apk add --update bash
RUN npm install -g newman-reporter-htmlextra 
RUN npm install -g newman

WORKDIR /app
COPY . /app

# 1.run script
# RUN ["chmod", "+x", "script.sh"]
# CMD ["sh", "./script.sh"]

# RUN echo "file contents" > file.txt
# ENTRYPOINT["newman","run","mycollection.json","-r","html","--reporter-html-export","test2.html","-d","data.csv"]


# 2.run newman directly
ENTRYPOINT ["newman","run","https://www.getpostman.com/collections/80a38f6a14912571f027 -r htmlextra --reporter-htmlextra-export test2.html","-d","data.csv"]


