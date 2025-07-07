# Three-Tier Web Application with Docker

This repository contains a **three-tier web application** built using Docker and Docker Compose. You should be able to run a very basic Wordpress website on your own system after building and running the Docker containers in this repository.

The project demonstrates a modular and production-aware architecture, using three main separate services:

- **Frontend (Nginx)**: Serves static content and acts as a reverse proxy.
- **Backend (PHP-FPM/WordPress)**: Handles dynamic content and application logic.
- **Database (MariaDB)**: Manages persistent data storage.

I included a sample Secrets folder in order to make test runs possible.

### Prerequisites

- Docker (≥ 20.x)
- Docker Compose (v2 recommended)
- OpenSSL (for manual certificate generation, if needed)

### Setup

1. Clone the repository:
```bash
git clone https://github.com/lotte-detaeye/inception.git
cd inception
```

2. Create your .env file based on the sample:

```bash
cp .env.example .env
```

3. Build and run the containers:

```bash
docker-compose up --build
```

4. Access your application:

In your browser: https://localhost
