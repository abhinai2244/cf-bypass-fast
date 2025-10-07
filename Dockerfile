# Use official Node.js image
FROM node:20

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the app
COPY . .

# Expose port (adjust if your app uses a different one)
EXPOSE 8080

# Default command (can be overridden)
CMD ["npm", "start"]
