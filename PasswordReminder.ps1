function SetPowerShell {
    Write-Host "Settings up trusted repository and execution policy.." -ForegroundColor Yellow
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
    Set-ExecutionPolicy -ExecutionPolicy Bypass -Force CurrentUser
}
function CheckModules {
    try {
        $moduleName = "MSOssnline"
        Write-Host "Checking required modules... Please wait.." -ForegroundColor Yellow
        Start-Sleep -Seconds 3
        Get-InstalledModule -Name $moduleName -ErrorAction Stop
        Write-Host "Module " $moduleName " is installed. Please wait for the module update.." -ForegroundColor Yellow
        Update-Module -Name $moduleName
    }
    catch {
        Write-Output "Module $moduleName is not installed. Wait for the install.."
        Install-Module -Name $moduleName
    }
}

SetPowerShell
CheckModules