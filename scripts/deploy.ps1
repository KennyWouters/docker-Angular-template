# Debug information
Write-Host "Starting deployment script..."
Write-Host "Script location: $PSScriptRoot"

# Get the project root directory (one level up from this script)
$projectRoot = Split-Path -Parent $PSScriptRoot
Write-Host "Project root: $projectRoot"

# Default values
$prodEnvFile = Join-Path $projectRoot "config\.env.prod"
$prodComposeFile = Join-Path $projectRoot "production\docker-compose.yml"

# Function to deploy the application
function Deploy-Production {
    Write-Host "Deploying to production..."
    
    # Stop existing containers
    Write-Host "Stopping existing containers..."
    docker-compose -f $prodComposeFile --env-file $prodEnvFile down
    
    # Pull latest changes
    Write-Host "Pulling latest changes..."
    git pull origin production
    
    # Build and start containers
    Write-Host "Building and starting containers..."
    docker-compose -f $prodComposeFile --env-file $prodEnvFile up -d --build
    
    Write-Host "Deployment completed!"
}

# Export function to the current scope
Set-Alias -Name deploy-prod -Value Deploy-Production -Scope Global

Write-Host "Deployment commands loaded successfully!"
Write-Host "Available commands: deploy-prod" 