FROM node:16-alpine as builder

WORKDIR '/app'

COPY package.json .

#RUN instructions needed because we are on windows
RUN mkdir -p /app/node_modules && chown -R node:node /app/node_modules
RUN mkdir -p /app/node_modules/.cache && chmod -R 777 /app/node_modules/.cache

RUN npm install

COPY . .

RUN npm run build


FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html