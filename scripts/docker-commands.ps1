# Debug information
Write-Host "Loading docker commands script..."
Write-Host "Script location: $PSScriptRoot"

# Get the project root directory (three levels up from this script)
$projectRoot = Split-Path -Parent (Split-Path -Parent (Split-Path -Parent $PSScriptRoot))
Write-Host "Project root: $projectRoot"

# Default values
$devEnvFile = Join-Path $projectRoot "untitled2\docker-front\config\.env.dev"
$devComposeFile = Join-Path $projectRoot "untitled2\docker-front\development\docker-compose.dev.yml"
$prodEnvFile = Join-Path $projectRoot "adhan-front\docker\config\.env.prod"
$prodComposeFile = Join-Path $projectRoot "adhan-front\docker\production\docker-compose.yml"

# Development commands
function Start-Dev {
    docker-compose -f $devComposeFile --env-file $devEnvFile up --build
}

function Stop-Dev {
    docker-compose -f $devComposeFile --env-file $devEnvFile down
}

function Start-Dev-Detached {
    docker-compose -f $devComposeFile --env-file $devEnvFile up --build -d
}

function View-Dev-Logs {
    docker-compose -f $devComposeFile --env-file $devEnvFile logs -f
}

# Production commands
function Start-Prod {
    docker-compose -f $prodComposeFile --env-file $prodEnvFile up --build -d
}

function Stop-Prod {
    docker-compose -f $prodComposeFile --env-file $prodEnvFile down
}

function View-Prod-Logs {
    docker-compose -f $prodComposeFile --env-file $prodEnvFile logs -f
}

# Clean up commands
function Remove-AllContainers {
    docker rm -f $(docker ps -aq)
}

function Remove-AllImages {
    docker rmi -f $(docker images -aq)
}

# C# specific commands
function Restore-Dependencies {
    docker-compose -f $devComposeFile --env-file $devEnvFile run --rm api dotnet restore
}

function Build-Solution {
    docker-compose -f $devComposeFile --env-file $devEnvFile run --rm api dotnet build
}

function Run-Tests {
    docker-compose -f $devComposeFile --env-file $devEnvFile run --rm api dotnet test
}

# Export functions to the current scope
Set-Alias -Name docker-dev-up -Value Start-Dev -Scope Global
Set-Alias -Name docker-dev-down -Value Stop-Dev -Scope Global
Set-Alias -Name docker-dev-upd -Value Start-Dev-Detached -Scope Global
Set-Alias -Name docker-dev-logs -Value View-Dev-Logs -Scope Global
Set-Alias -Name docker-prod-up -Value Start-Prod -Scope Global
Set-Alias -Name docker-prod-down -Value Stop-Prod -Scope Global
Set-Alias -Name docker-prod-logs -Value View-Prod-Logs -Scope Global
Set-Alias -Name docker-clean-containers -Value Remove-AllContainers -Scope Global
Set-Alias -Name docker-clean-images -Value Remove-AllImages -Scope Global
Set-Alias -Name docker-restore -Value Restore-Dependencies -Scope Global
Set-Alias -Name docker-build -Value Build-Solution -Scope Global
Set-Alias -Name docker-test -Value Run-Tests -Scope Global

Write-Host "Docker commands loaded successfully!"
Write-Host "Available commands: docker-dev-up, docker-dev-down, docker-dev-upd, docker-dev-logs, docker-prod-up, docker-prod-down, docker-prod-logs"
