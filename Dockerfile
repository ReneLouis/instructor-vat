# Stage 1: build npm app, alias it as build
FROM node:17-alpine as build

WORKDIR /app

COPY package.json .
RUN npm install

COPY . .
RUN npm run build

# Stage 2: Copy the built react app from the /app/build folder of the aliases image
# into the default nginx file location 

FROM nginx:1.21.6-alpine
COPY --from=build /app/build /usr/share/nginx/html

# Copy yhe required nginx configuration file and folder:
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

# CMD ["nginx", "-g", "daemon off;" ]
ENTRYPOINT ["nginx", "-g", "daemon off;" ]
