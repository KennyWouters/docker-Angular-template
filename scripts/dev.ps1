[CmdletBinding()]
param(
    [switch]$Down,
    [switch]$Rebuild,
    [switch]$Logs
)

# Get the script's directory and project root
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Split-Path -Parent (Split-Path -Parent $scriptDir)

# Default values
$envFile = Join-Path $projectRoot "docker\config\.env.dev"
$composeFile = Join-Path $projectRoot "docker\development\docker-compose.dev.yml"
$command = "up"
$buildFlag = "--build"

# Set command based on parameters
if ($Down) {
    $command = "down"
    $buildFlag = ""
}
elseif ($Rebuild) {
    $command = "up"
    $buildFlag = "--build --force-recreate"
}
elseif ($Logs) {
    $command = "logs"
    $buildFlag = "-f"
}

# Run docker compose with the specified environment file
docker compose --env-file $envFile -f $composeFile $command $buildFlag 