FROM node:18-slim

WORKDIR /app

COPY . .

RUN npm install

EXPOSE 8080

# Default to production mode
CMD ["npm", "start"]

# For development mode, override with: docker run -e NODE_ENV=development ...
CMD ["npm", "run", "dev"]

#ABHI
