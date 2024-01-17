# todoapp
Ethereum based solidity todoapp


Containerization:
To containerize your application, you can use Docker. Create a Dockerfile in the root directory of your project:

Dockerfile
Copy code
# Dockerfile
WORKDIR /todoapp

COPY package*.json ./

RUN npm install

COPY . .

CMD ["npm", "start"]
Instructions to Launch and Test:
Install Docker: https://docs.docker.com/get-docker/

Build the Docker image:

bash
Copy code
docker build -t your-image-name .
Run the Docker container:

bash
Copy code
docker run -p 3000:3000 your-image-name
Access the app in your browser at http://localhost:3000.
