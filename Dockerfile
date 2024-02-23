# Use the official Node.js image as base
FROM node:18 as builder

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the Angular app files
COPY . .

# Build the app
RUN npm run build 

# Use Nginx as a lightweight web server
FROM nginx:alpine

# Copy the built app from the builder stage to the Nginx public directory
COPY --from=builder /app/dist/angular-app/ /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]
