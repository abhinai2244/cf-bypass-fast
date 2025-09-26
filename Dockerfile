FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    gnupg \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 22.x
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs

# Install Google Chrome
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

# Set up Xvfb (virtual display)
RUN Xvfb :99 -screen 0 1024x768x24 > /dev/null 2>&1 &
ENV DISPLAY=:99

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install NPM dependencies
RUN npm install

# Copy application code
COPY . .

# Install PM2 globally
RUN npm install -g pm2

# Expose port 8080 (for Cloudflare solver)
EXPOSE 8080

# Start PM2 with production mode (npm start equivalent)
CMD pm2 start index.js --name "cf-bypass" --no-daemon && pm2 startup && pm2 save
