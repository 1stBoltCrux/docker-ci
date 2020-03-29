FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .

#volume system removed as it's not relavent in prod

RUN npm run build

# new FROM statement terminates previous block

FROM nginx as run
EXPOSE 80
# /app/build <----- all the stuff
# look back at builder phase, grab build folder, place
# files in directory within nginx (reference dockerhub nginx docs)
COPY --from=builder /app/build /usr/share/nginx/html


