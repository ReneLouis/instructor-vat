<<<<<<< HEAD
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
=======
#Multi-Stage Build
# base image and alias it as 'build'
FROM node:17-alpine as build 
# todo
# change into a folder called /app
WORKDIR /app

# only copy package.json - this will optimise the image build time and allow for more layers to be cached
COPY package.json .

# download the project dependencies
RUN npm install

# copy everything from my react app folder to the /app folder in the container
COPY . .

# package up the react project in the /app directory
RUN npm run build

# 2nd stage of the multi-stage build
# base image is nginx:1.21.6-alpine
#  todo

# copy the built react app from the /app/build folder of the aliased image
# into the default nginx file location
# todo
FROM nginx:1.21.6-alpine
COPY --from=build /app/build /usr/share/nginx/html
# copy the required nginx configuartion file and folder
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Document that you require Port 80 to be opened on the containers that run from this image
# todo
EXPOSE 80

# Make sure nginx does not run as a background daemon otherwise the container will start and then immediately exit
CMD ["nginx", "-g", "daemon off;"]

>>>>>>> 79f36b8e41713d12bb46fe3df0715cf506115a2a
