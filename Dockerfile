FROM node:current as build

WORKDIR /app

COPY package.json ./
COPY yarn.lock ./

RUN yarn

COPY . ./

RUN yarn build

FROM nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
