# .build/init.ps1
[CmdletBinding()]
param (
    # Use the -Force switch to overwrite existing files in the project root.
    [Switch]$Force
)

# Get the directory of the script itself (e.g., '.build/')
$ScriptDir = $PSScriptRoot
# Get the root directory of the repository (which is one level up)
$RepoRoot = Resolve-Path (Join-Path -Path $ScriptDir -ChildPath "..")

Write-Host "Initializing build system in '$RepoRoot'..." -ForegroundColor Cyan

# --- Define Source and Destination Paths ---
$SourceTaskfile = Join-Path -Path $ScriptDir -ChildPath "templates/Taskfile.yml.template"
$SourceEnvExample = Join-Path -Path $ScriptDir -ChildPath "templates/.env.example"

$DestTaskfile = Join-Path -Path $RepoRoot -ChildPath "Taskfile.yml"
$DestEnvExample = Join-Path -Path $RepoRoot -ChildPath ".env.example"

# --- Function to safely copy a file ---
function Copy-TemplateFile {
    param(
        [string]$SourcePath,
        [string]$DestinationPath,
        [bool]$ShouldForce
    )
    $FileName = Split-Path -Path $DestinationPath -Leaf
    if ((Test-Path $DestinationPath) -and -not $ShouldForce) {
        Write-Host "File '$FileName' already exists in the project root. Use -Force to overwrite." -ForegroundColor Yellow
    }
    else {
        Write-Host "Creating root '$FileName'..." -ForegroundColor Green
        Copy-Item -Path $SourcePath -Destination $DestinationPath -Force
    }
}

# --- Execute the copy operations ---
Copy-TemplateFile -SourcePath $SourceTaskfile -DestinationPath $DestTaskfile -ShouldForce $Force
Copy-TemplateFile -SourcePath $SourceEnvExample -DestinationPath $DestEnvExample -ShouldForce $Force


# --- Provide next steps ---
Write-Host "`n✅ Initialization complete." -ForegroundColor White
Write-Host "   Next steps:"
Write-Host "   1. Copy '.env.example' to '.env'"
Write-Host "   2. Customize the '.env' file for your project"
Write-Host "   3. Run 'task --list' to see available commands"