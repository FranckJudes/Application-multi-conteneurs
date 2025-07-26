# Todo API - Multi-Container Application

A simple Todo API built with Node.js, Express, and MongoDB, containerized with Docker and Docker Compose. This project demonstrates DevOps best practices including infrastructure as code (Terraform), configuration management (Ansible), and CI/CD (GitHub Actions).

## Features

- RESTful API for managing todo items
- MongoDB database for data persistence
- Docker and Docker Compose for containerization
- Nginx reverse proxy for production
- Terraform for cloud infrastructure provisioning
- Ansible for server configuration
- GitHub Actions for CI/CD pipeline

## API Endpoints

- `GET /todos` - Get all todos
- `POST /todos` - Create a new todo
- `GET /todos/:id` - Get a single todo by id
- `PUT /todos/:id` - Update a single todo by id
- `DELETE /todos/:id` - Delete a single todo by id

## Local Development

### Prerequisites

- Docker and Docker Compose installed on your machine

### Running the Application

1. Clone this repository
2. Run the application using Docker Compose:

```bash
docker-compose up
```

The API will be available at http://localhost:3000

## Production Deployment

### Prerequisites

- GitHub account
- Docker Hub account
- DigitalOcean account (or other cloud provider)
- SSH key pair

### Setting up GitHub Secrets

Add the following secrets to your GitHub repository:

- `DOCKER_USERNAME` - Your Docker Hub username
- `DOCKER_PASSWORD` - Your Docker Hub password
- `DO_TOKEN` - Your DigitalOcean API token
- `SSH_KEY_FINGERPRINT` - The fingerprint of your SSH key in DigitalOcean
- `SSH_PRIVATE_KEY` - Your SSH private key

### Deployment Process

1. Push your code to the main branch
2. GitHub Actions will automatically:
   - Build and push the Docker image to Docker Hub
   - Provision a server using Terraform
   - Configure the server using Ansible
   - Deploy the application using Docker Compose


This project is part of [roadmap.sh](https://roadmap.sh/projects/multi-container-service) DevOps projects.