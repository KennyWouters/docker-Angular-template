#!/bin/bash
docker compose -f development/docker-compose.dev.yml --env-file config/.env.dev up 