# Base image with Node.js and Chrome dependencies
FROM node:20-slim

# Install Chrome and Xvfb
RUN apt update && apt install -y \
    wget gnupg ca-certificates xvfb \
    fonts-liberation libappindicator3-1 libasound2 libatk-bridge2.0-0 \
    libatk1.0-0 libxss1 libnss3 libxcomposite1 libxdamage1 libxrandr2 libgbm1 \
    && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && apt install -y ./google-chrome-stable_current_amd64.deb \
    && rm google-chrome-stable_current_amd64.deb

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the app
COPY . .

# Expose port (adjust if needed)
EXPOSE 3000

# Start Xvfb and run the app
CMD Xvfb :99 -screen 0 1024x768x24 & \
    export DISPLAY=:99 && \
    npm start
