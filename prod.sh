#!/bin/bash
docker compose -f production/docker-compose.yml --env-file config/.env.production up -d 