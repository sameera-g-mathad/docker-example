FROM node:16-alpine as builder

WORKDIR /example_app

COPY ./package.json .

RUN npm install

COPY ./ ./

# You dont add cmd here because you need to run another image
RUN npm run build 

FROM nginx

# This means in production, the vms need to expose this port
# which is exposed by elastic beanstalk.
EXPOSE 80

COPY --from=builder /example_app/build  /usr/share/nginx/html

