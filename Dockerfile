FROM node:14-alpine3.13 as build

ARG BUILD_ID=0
ARG CLIENT_ID=x
ARG INDEX_TIER
ARG CONFIG_TIER
ARG FEATURE_NAME

COPY Test1/test/. /tmp/app
COPY yarn.lock /tmp/app

COPY Test1/test/index.${INDEX_TIER}.html /tmp/app/public/index.html

RUN sed -i "s/{{stack_id}}/$BUILD_ID/g" /tmp/app/public/ping.html


# ---------------------------------------------------------------------- demo ---

FROM nginx:alpine

COPY --from=build /tmp/app/default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /tmp/app/dist /var/www
