# Clean up files and directories excluded by .gitignore
# This script traverses the projects directory, lets you select a project, and deletes files excluded by .gitignore

$ErrorActionPreference = "Stop"

# Get the parent directory of the script (workspace root)
$workspaceRoot = Split-Path -Parent $PSScriptRoot
$projectsDir = Join-Path $workspaceRoot "projects"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Portable App Project Cleanup Tool" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if projects directory exists
if (-not (Test-Path $projectsDir)) {
    Write-Host "Error: projects directory does not exist: $projectsDir" -ForegroundColor Red
    exit 1
}

# Get all project directories
$projectDirs = Get-ChildItem -Path $projectsDir -Directory

if ($projectDirs.Count -eq 0) {
    Write-Host "No project directories found" -ForegroundColor Yellow
    exit 0
}

# Display project list for user selection
Write-Host "Found the following projects:" -ForegroundColor Green
for ($i = 0; $i -lt $projectDirs.Count; $i++) {
    Write-Host "$($i + 1). $($projectDirs[$i].Name)" -ForegroundColor White
}

Write-Host ""
Write-Host "0. Exit" -ForegroundColor Yellow
Write-Host ""

# Get user selection
$selection = Read-Host "Select project number to clean (0 to exit)"

if ($selection -eq "0") {
    Write-Host "Operation cancelled" -ForegroundColor Yellow
    exit 0
}

# Validate selection
try {
    $selectedIndex = [int]$selection - 1
    if ($selectedIndex -lt 0 -or $selectedIndex -ge $projectDirs.Count) {
        Write-Host "Invalid selection" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "Please enter a valid number" -ForegroundColor Red
    exit 1
}

$selectedProject = $projectDirs[$selectedIndex]
$projectPath = $selectedProject.FullName
$gitignoreFile = Join-Path $projectPath ".gitignore"

Write-Host ""
Write-Host "Selected project: $($selectedProject.Name)" -ForegroundColor Green
Write-Host "Project path: $projectPath" -ForegroundColor Gray
Write-Host ""

# Check if .gitignore file exists
if (-not (Test-Path $gitignoreFile)) {
    Write-Host "Warning: No .gitignore file found: $gitignoreFile" -ForegroundColor Yellow
    $continue = Read-Host "Continue with manual ignore patterns? (y/n)"
    if ($continue -ne "y" -and $continue -ne "Y") {
        exit 0
    }
    
    # Allow user to manually input ignore patterns
    Write-Host "Enter patterns to delete (one per line, empty line to finish):" -ForegroundColor Cyan
    $ignorePatterns = @()
    while ($true) {
        $pattern = Read-Host "Pattern"
        if ([string]::IsNullOrWhiteSpace($pattern)) { break }
        $ignorePatterns += $pattern.Trim()
    }
    
    if ($ignorePatterns.Count -eq 0) {
        Write-Host "No patterns entered" -ForegroundColor Yellow
        exit 0
    }
} else {
    # Read .gitignore file content
    Write-Host "Reading .gitignore file..." -ForegroundColor Cyan
    $ignorePatterns = Get-Content $gitignoreFile | 
        Where-Object { $_ -notmatch '^\s*#' -and $_ -notmatch '^\s*$' } |
        ForEach-Object { $_.Trim() }
    
    if ($ignorePatterns.Count -eq 0) {
        Write-Host "No valid ignore patterns found in .gitignore file" -ForegroundColor Yellow
        exit 0
    }
}

Write-Host ""
Write-Host "The following files and directories will be deleted:" -ForegroundColor Yellow
foreach ($pattern in $ignorePatterns) {
    Write-Host "  - $pattern" -ForegroundColor Gray
}

Write-Host ""
$confirm = Read-Host "Confirm deletion? (y/n)"
if ($confirm -ne "y" -and $confirm -ne "Y") {
    Write-Host "Operation cancelled" -ForegroundColor Yellow
    exit 0
}

Write-Host ""
Write-Host "Starting cleanup..." -ForegroundColor Cyan
Write-Host ""

$deletedCount = 0
$errorCount = 0

foreach ($pattern in $ignorePatterns) {
    # Process different ignore patterns
    $searchPattern = $pattern
    
    # Remove trailing slash (directory marker)
    if ($searchPattern.EndsWith('/')) {
        $searchPattern = $searchPattern.TrimEnd('/')
    }
    
    # Build full path
    $fullPath = Join-Path $projectPath $searchPattern
    
    try {
        if (Test-Path $fullPath) {
            $item = Get-Item $fullPath
            
            if ($item.PSIsContainer) {
                # Delete directory and its contents
                Remove-Item -Path $fullPath -Recurse -Force
                Write-Host "[Deleted] Directory: $searchPattern" -ForegroundColor Green
                $deletedCount++
            } else {
                # Delete file
                Remove-Item -Path $fullPath -Force
                Write-Host "[Deleted] File: $searchPattern" -ForegroundColor Green
                $deletedCount++
            }
        } else {
            # Try wildcard matching
            $parentPath = Split-Path $fullPath
            $leafName = Split-Path $fullPath -Leaf
            
            if (Test-Path $parentPath) {
                $matches = Get-ChildItem -Path $parentPath -Filter $leafName -Force -ErrorAction SilentlyContinue
                
                foreach ($match in $matches) {
                    Remove-Item -Path $match.FullName -Recurse -Force
                    Write-Host "[Deleted] $(if ($match.PSIsContainer) { 'Directory' } else { 'File' }): $leafName" -ForegroundColor Green
                    $deletedCount++
                }
            }
        }
    } catch {
        Write-Host "[Error] Failed to delete: $searchPattern - $($_.Exception.Message)" -ForegroundColor Red
        $errorCount++
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Cleanup Complete" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Successfully deleted: $deletedCount items" -ForegroundColor Green
if ($errorCount -gt 0) {
    Write-Host "Errors: $errorCount items" -ForegroundColor Red
}
Write-Host ""

