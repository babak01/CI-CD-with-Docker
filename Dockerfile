# Use a specific version of Node.js for better stability
FROM node:17

# Because in Travis we don't have this directory'
RUN mkdir /usr/src/app 
# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the package.json and package-lock.json first (if available)
COPY package*.json ./

# Install project dependencies (including devDependencies)
RUN npm install --retry 5 --verbose --timeout=60000

# Install global dependencies like nodemon
RUN npm install -g nodemon

# Copy the rest of the application source code
COPY . .

# Expose the port the app will run on
EXPOSE 4000

# Start the application using nodemon and babel-node
CMD ["npm", "start"]
