---
name: docker-deploy
description: Docker containerization and deployment guide covering Dockerfile best practices, multi-stage builds, Docker Compose for local development, and production deployment patterns. Use when containerizing applications or setting up deployment pipelines.
---

# Docker Deployment Guide

This skill provides best practices for containerizing and deploying applications with Docker.

## When to Use This Skill

Use this skill when the user:

- Needs to write a Dockerfile for their application
- Wants to optimize Docker image size
- Is setting up Docker Compose for local development
- Needs to implement multi-stage builds
- Asks about container orchestration basics
- Wants to debug container issues

## Dockerfile Best Practices

### Multi-Stage Build (Node.js Example)

```dockerfile
# Stage 1: Build
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force
COPY . .
RUN npm run build

# Stage 2: Production
FROM node:20-alpine AS runner
WORKDIR /app
RUN addgroup --system app && adduser --system --ingroup app app
COPY --from=builder --chown=app:app /app/dist ./dist
COPY --from=builder --chown=app:app /app/node_modules ./node_modules
COPY --from=builder --chown=app:app /app/package.json ./
USER app
EXPOSE 3000
CMD ["node", "dist/index.js"]
```

### Key Principles

1. **Use specific base image tags** - Avoid `latest`, pin to specific versions
2. **Leverage layer caching** - Copy `package.json` before source code
3. **Run as non-root** - Create a dedicated user
4. **Use `.dockerignore`** - Exclude unnecessary files
5. **Minimize layers** - Combine related RUN commands

### .dockerignore Example

```
node_modules
.git
.env
*.md
tests/
coverage/
.github/
```

## Docker Compose for Development

```yaml
version: '3.8'

services:
  app:
    build:
      context: .
      dockerfile: Dockerfile.dev
    ports:
      - '3000:3000'
    volumes:
      - .:/app
      - /app/node_modules
    environment:
      - NODE_ENV=development
      - DATABASE_URL=postgres://user:pass@db:5432/mydb
    depends_on:
      db:
        condition: service_healthy

  db:
    image: postgres:16-alpine
    ports:
      - '5432:5432'
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: pass
      POSTGRES_DB: mydb
    volumes:
      - pgdata:/var/lib/postgresql/data
    healthcheck:
      test: ['CMD-SHELL', 'pg_isready -U user']
      interval: 5s
      timeout: 5s
      retries: 5

  redis:
    image: redis:7-alpine
    ports:
      - '6379:6379'

volumes:
  pgdata:
```

## Image Optimization

| Technique              | Impact   |
| ---------------------- | -------- |
| Multi-stage builds     | High     |
| Alpine base images     | High     |
| .dockerignore          | Medium   |
| Layer caching          | Medium   |
| Combine RUN commands   | Low      |
| Remove build deps      | Medium   |

## Common Debugging Commands

```bash
# View running containers
docker ps

# View container logs
docker logs -f <container-id>

# Execute command in running container
docker exec -it <container-id> /bin/sh

# Inspect image layers and size
docker history <image-name>

# Check container resource usage
docker stats

# Clean up unused resources
docker system prune -a
```

## Health Checks

```dockerfile
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:3000/health || exit 1
```
