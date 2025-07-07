# Three-Tier Web Application with Docker

This repository contains a **three-tier web application** built using Docker and Docker Compose. It demonstrates a modular and production-aware architecture, separating concerns into three main services:

- **Frontend (Nginx)**: Serves static content and acts as a reverse proxy.
- **Backend (e.g., PHP-FPM/WordPress)**: Handles dynamic content and application logic.
- **Database (MariaDB)**: Manages persistent data storage.

I included a sample Secrets folder. 

### Prerequisites

- Docker (≥ 20.x)
- Docker Compose (v2 recommended)
- OpenSSL (for manual certificate generation, if needed)

### Setup

1. Clone the repository:
```bash
git clone https://github.com/yourusername/three-tier-app.git
cd three-tier-app
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
