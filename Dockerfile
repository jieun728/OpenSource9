# Step 1: Use official Node.js image from Docker Hub
FROM node:14

# Step 2: Set the working directory inside the container
WORKDIR /usr/src/app

# Step 3: Copy package.json and package-lock.json
COPY package*.json ./

# Step 4: Install project dependencies
RUN npm install
RUN npm install shelljs

# Step 5: Copy all project files into the container
COPY . .

# Step 6: Expose the port that your app runs on (assuming it's running on port 8080)
EXPOSE 8080

# Step 7: Define the command to run your application
CMD ["npm", "start"]
