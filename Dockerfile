FROM node:20-slim

# Install Chrome and Xvfb dependencies
RUN apt update && apt install -y \
    wget gnupg ca-certificates xvfb \
    fonts-liberation libappindicator3-1 libasound2 libatk-bridge2.0-0 \
    libatk1.0-0 libxss1 libnss3 libxcomposite1 libxdamage1 libxrandr2 libgbm1 \
    && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && apt install -y ./google-chrome-stable_current_amd64.deb \
    && rm google-chrome-stable_current_amd64.deb \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

ENV PORT=9646
EXPOSE $PORT
ENV CHROME_PATH=/usr/bin/google-chrome-stable

# Use xvfb-run to auto-manage virtual display
CMD xvfb-run -a node index.js
