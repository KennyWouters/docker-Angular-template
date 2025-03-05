# Docker Setup

This directory contains all Docker-related configurations for the Adhan Front application. The structure is organized to separate development and production environments, along with their respective configurations and scripts.

## Directory Structure

```
docker/
├── config/              # Environment variables and configurations
│   ├── .env.dev        # Development environment variables
│   └── .env.production # Production environment variables
│
├── development/        # Development environment setup
│   ├── Dockerfile.dev  # Development Dockerfile
│   └── docker-compose.dev.yml # Development compose file
│
├── production/         # Production environment setup
│   ├── Dockerfile     # Production Dockerfile
│   ├── docker-compose.yml # Production compose file
│   └── nginx.conf     # Nginx configuration for production
│
└── scripts/           # PowerShell scripts for Docker operations
    ├── dev.ps1        # Development environment management
    ├── prod.ps1       # Production environment management
    └── docker-commands.ps1 # Shared Docker commands and aliases
```

## Quick Start

### Development Environment

```powershell
# Start development environment
.\docker\scripts\dev.ps1

# Or use the alias after sourcing docker-commands.ps1
. .\docker\scripts\docker-commands.ps1
docker-dev-up
```

### Production Environment

```powershell
# Start production environment
.\docker\scripts\prod.ps1

# Or use the alias after sourcing docker-commands.ps1
. .\docker\scripts\docker-commands.ps1
docker-prod-up
```

## Available Commands

After sourcing `docker-commands.ps1`, the following commands become available:

### Development Commands
- `docker-dev-up`: Start development environment
- `docker-dev-down`: Stop development environment
- `docker-dev-upd`: Start development environment in detached mode
- `docker-dev-logs`: View development logs

### Production Commands
- `docker-prod-up`: Start production environment
- `docker-prod-down`: Stop production environment
- `docker-prod-logs`: View production logs

### Utility Commands
- `docker-clean-containers`: Remove all containers
- `docker-clean-images`: Remove all images

## Environment Variables

### Development (.env.dev)
- `NODE_ENV`: Set to "development"
- `DEV_PORT`: Development server port (default: 3000)
- `DEV_HOST`: Development host (default: 0.0.0.0)
- `DEV_POLL`: Development polling interval (default: 2000)

### Production (.env.production)
- `NODE_ENV`: Set to "production"
- `PROD_PORT`: Production server port (default: 80)

## Development Features

- Hot-reloading enabled
- Source code mounted as volume
- Node modules cached in Docker volume
- Git integration for branch management
- Development-specific optimizations

## Production Features

- Multi-stage build process
- Nginx as reverse proxy
- Optimized for performance
- Minimal image size
- Security best practices

## Customization

### Development
Edit `docker/development/docker-compose.dev.yml` to modify:
- Port mappings
- Volume mounts
- Environment variables
- Development-specific settings

### Production
Edit `docker/production/docker-compose.yml` to modify:
- Port mappings
- SSL configuration
- Nginx settings
- Production-specific optimizations

## Troubleshooting

1. **Package.json not found**
   - Ensure you're running commands from the project root
   - Check if the build context is correct in docker-compose files

2. **Port conflicts**
   - Modify the port mappings in docker-compose files
   - Check for running containers using the same ports

3. **Volume mount issues**
   - Verify paths in docker-compose files
   - Ensure proper permissions on mounted directories

## Contributing

When adding new features or making changes:
1. Update relevant docker-compose files
2. Document changes in this README
3. Update environment variable files if needed
4. Test in both development and production environments

## Notes

- Development environment uses Alpine-based Node.js image
- Production environment uses multi-stage build for optimization
- Scripts are designed for PowerShell on Windows
- Environment variables can be overridden via command line or .env files 