# Use a specific Node.js version with Alpine
FROM node:25.8.1-alpine

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json first
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all project files
COPY . .

# Build the NestJS application
RUN npm run build

# Expose the port your app runs on
EXPOSE 4000

# Start the application
CMD ["node", "dist/main"]

