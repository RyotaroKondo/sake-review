FROM node:14
WORKDIR /root/sake-review
COPY ./app/package.json /root/sake-review/
COPY ./app/yarn.lock /root/sake-review/
RUN yarn install
CMD [ "yarn", "start" ]