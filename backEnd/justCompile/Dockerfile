# Use an official Node.js runtime as a parent image
FROM node:20.14.0

# Install g++ and other necessary tools
RUN apt-get update && \
    apt-get install -y g++ && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -ms /bin/bash compileruser

# Set the working directory
WORKDIR /usr/src/app

# Copy the package.json file and install dependencies
COPY --chown=compileruser:compileruser api/package*.json ./
RUN npm install
RUN npm install express-rate-limit

# Copy the rest of the application code
COPY --chown=compileruser:compileruser api/ .

# Change to non-root user
USER compileruser

# Expose port 6969 for the web server
EXPOSE 6969

# Command to run the Node.js script
CMD ["node", "index.js"]
