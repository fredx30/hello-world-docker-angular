FROM node:lts-gallium AS builder
COPY ./ /root/
WORKDIR /root/
RUN npm install
RUN npm run build --omit=dev

FROM nginx:latest
WORKDIR /usr/share/nginx/html/
COPY ./nginx-config/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /root/dist/hello-world-docker-angular/ /usr/share/nginx/html/
EXPOSE 80
