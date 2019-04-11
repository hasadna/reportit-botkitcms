FROM node:alpine as build

WORKDIR /botkit-cms-master/

RUN apk add --update build-base python

RUN wget https://github.com/howdyai/botkit-cms/archive/master.zip 
RUN unzip master.zip -d ..
RUN rm master.zip
RUN npm install
RUN npm run build
RUN mkdir .data
COPY .env .

FROM node:alpine

WORKDIR /botkit-cms-master/

COPY --from=build /botkit-cms-master /botkit-cms-master

EXPOSE 3000
CMD ["npm", "start"]
