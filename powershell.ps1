# git-pull-on-startup.ps1

# Navigate to the Git repository directory
$repoPath = "C:\Users\Malefic\AppData\Roaming\espanso"
Set-Location $repoPath

# Perform Git pull
try {
    $output = & git pull 2>&1
    Write-Output "Git pull successful."
    Write-Output $output
} catch {
    Write-Error "Git pull failed: $_"
}

# Log the result
$logFile = "$env:TEMP\git-pull-log.txt"
Get-Date | Out-File -FilePath $logFile -Append
if ($LASTEXITCODE -eq 0) {
    "Git pull completed successfully." | Out-File -FilePath $logFile -Append
} else {
    "Git pull failed with error code $LASTEXITCODE" | Out-File -FilePath $logFile -Append
}
