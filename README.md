# Thingsly Docker Quick Deploy

🐳 Thingsly docker quick deploy.

## Prerequisites

- Docker
- Docker Compose
- Git

## Quick Start

1. Clone the repository:

   ```bash
    git clone https://github.com/Thingsly/docker.git
    cd docker
    ```

2. Run the following command to start the Thingsly:

   ```bash
   # To run in the foreground, use:
   docker-compose -f docker-compose.yml up

    # To run in detached mode, use:
   docker-compose -f docker-compose.yml up -d
   ```

3. Access the Thingsly at `http://localhost:8080`.
4. The default username and password for tenant are `demo-tenant@thingsly.vn` and `123456`. The default username and password for admin are `demo-super@thingsly.vn` and `123456`.
5. To stop Thingsly, run:

   ```bash
   docker-compose -f docker-compose.yml down
   ```

6. To view logs, run:

   ```bash
   docker logs -f containerID
   ```
