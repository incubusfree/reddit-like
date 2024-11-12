# Step 1: Build the application
# Use a Node.js image for the build stage
FROM node:18 AS build

# Set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json files
COPY ./package*.json /app/

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Step 2: Serve the application
# Use a lightweight web server like Nginx for the production stage
FROM nginx:alpine

# Copy the build output to Nginx's static HTML folder
COPY --from=build /app/build /usr/share/nginx/html

# Expose the port Nginx will use
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
