FROM node:23 as builder

WORKDIR /app/medusa

COPY . . 

RUN rm -rf node_modules

RUN apt-get update && apt-get install -y python3 python3-pip python-is-python3

RUN yarn install --loglevel=error

RUN yarn run build


FROM node:23

# Bug https://github.com/coollabsio/coolify/issues/1930
ENV COOKIE_SECRET=$COOKIE_SECRET
ENV JWT_SECRET=$JWT_SECRET
ENV STORE_CORS=$STORE_CORS
ENV ADMIN_CORS=$ADMIN_CORS
ENV AUTH_CORS=$AUTH_CORS
ENV DISABLE_MEDUSA_ADMIN=$DISABLE_MEDUSA_ADMIN
ENV WORKER_MODE=$WORKER_MODE
ENV PORT=$PORT
ENV DATABASE_URL=$DATABASE_URL
ENV REDIS_URL=$REDIS_URL


RUN echo "${PORT}"

WORKDIR /app/medusa

RUN mkdir .medusa

# COPY package*.json .yarnrc.yml yarn.lock ./ 

# COPY medusa-config.ts .
# COPY tsconfig.json .

RUN apt-get update && apt-get install -y python3 python3-pip python-is-python3

COPY --from=builder /app/medusa/.medusa ./.medusa

WORKDIR /app/medusa/.medusa/server

RUN yarn global add @medusajs/medusa-cli@latest

RUN yarn install --production


# RUN medusa migrations run 
# COPY migrations.sh /app/medusa/.medusa/server/migrations.sh
# RUN chmod +x /app/medusa/.medusa/server/migrations.sh
# RUN /app/medusa/.medusa/server/migrations.sh

# RUN rm /app/medusa/.medusa/server/migrations.sh

RUN yarn run predeploy 

CMD ["yarn", "run", "start"]