[CmdletBinding()]
param(
    [switch]$Down,
    [switch]$Rebuild,
    [switch]$Logs,
    [switch]$Pull
)

# Get the script's directory and project root
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Split-Path -Parent (Split-Path -Parent $scriptDir)

# Default values
$envFile = Join-Path $projectRoot "docker\config\.env.production"
$composeFile = Join-Path $projectRoot "docker\production\docker-compose.yml"
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
elseif ($Pull) {
    $command = "pull"
    $buildFlag = ""
}

# Run docker compose with the specified environment file
docker compose --env-file $envFile -f $composeFile $command $buildFlag 