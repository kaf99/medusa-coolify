# FROM node:23

# WORKDIR /app/medusa

# COPY . .

# RUN apt-get update && apt-get install -y python3 python3-pip python-is-python3

# RUN yarn install

# RUN yarn global add @medusajs/medusa-cli@latest

# # RUN yarn install --loglevel=error

# RUN yarn run build

# RUN medusa migrations run

# CMD ["yarn", "run", "dev"]


FROM node:23 as builder

WORKDIR /app/medusa

COPY . . 

RUN rm -rf node_modules

RUN apt-get update && apt-get install -y python3 python3-pip python-is-python3

RUN yarn install --loglevel=error

RUN yarn run build


FROM node:23

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


RUN medusa migrations run



CMD ["yarn", "run", "start"]