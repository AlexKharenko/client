# этап сборки (build stage)
FROM node:14.15-alpine as build-stage
WORKDIR /
COPY client/package.json ./
COPY client/package-lock.json ./
RUN npm install
COPY client/. ./
RUN npm run build

# этап production (production-stage)
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]