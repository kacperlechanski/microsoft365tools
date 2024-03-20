function SetPowerShell {
    Write-Host "Settings up trusted repository and execution policy.." -ForegroundColor Yellow
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
    Set-ExecutionPolicy -ExecutionPolicy Bypass -Force CurrentUser
}
function CheckModules {
    try {
        $moduleName = "MSOnline"
        Write-Host "Checking required modules... Please wait.." -ForegroundColor Yellow
        Get-InstalledModule -Name $moduleName -ErrorAction Stop
        Write-Host "Module " $moduleName " is installed. Please wait for the update.." -ForegroundColor Yellow
        Update-Module -Name $moduleName
    }
    catch {
        Write-Warning -message "Module $moduleName isn't installed."
        do {
            $confirm = Read-Host "Do you want to install " $moduleName "? Yes/No"
            switch ($confirm) {
                'Yes'{
                    Write-Host "Installing "$moduleName" module. Please wait.." -ForegroundColor Yellow
                    Install-Module -Name $moduleName
                    break
                }
                'No'{
                    Write-Host "Module "$moduleName" is required for next operations. Script is exit" -ForegroundColor Red
                    Start-Sleep -Seconds 5
                    break
                }
                Default {
                    Write-Host "This option is unavailable. Try again." -ForegroundColor Yellow
                    return
                }
            }
        }until($confirm -ne "Yes")
    }
}

SetPowerShell
CheckModules