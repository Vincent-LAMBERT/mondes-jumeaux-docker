FROM node:14

WORKDIR /website
COPY package.json .
RUN npm install
COPY . .
CMD npm start
