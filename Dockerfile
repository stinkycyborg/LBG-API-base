# Base image
FROM node:14

# Copy contents into image
WORKDIR /app
COPY . .

# At build stage, install npm dependencies from requirements
RUN npm install

# Set environment variables
ENV PORT=4000

# Expose the correct port for documentation purposes
EXPOSE 4000

# At start up stage, create an entrypoint
ENTRYPOINT [ "npm", "start" ]

