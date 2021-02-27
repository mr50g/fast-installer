# powershell.exe -ExecutionPolicy Bypass -File opera_gx.ps1

param(
    [array]$applicationsToInstall
)

class InstallersData
{
    [String] $filename
    $json

    InstallersData ([String] $filename) 
    {
        $this.filename = $filename
    }

    [void] loadFileToVariable() 
    {
        $this.json = Get-Content $this.filename | ConvertFrom-JSON 
    }

    [String] getDownloadUrl($application) 
    {
        return $this.json.installers.$application."download-url"
    }

    [String] getInstallerFilename($application) 
    {
        return $this.json.installers.$application."installer-filename"
    }

    [String] getInstallerArguments($application) 
    {
        return $this.json.installers.$application."installer-arguments"
    }
}

class InstallerData
{
    [String] $downloadUrl
    [String] $installerFilename
    [String] $installerArguments

    [void] collectInstallerData($application, [InstallersData] $installersData)
    {
        $this.downloadUrl = $installersData.getDownloadUrl($application)
        $this.installerFilename = $installersData.getInstallerFilename($application)
        $this.installerArguments = $installersData.getInstallerArguments($application)
    }

    [String] getDownloadUrl() 
    {
        return $this.downloadUrl
    }

    [String] getInstallerFilename() 
    {
        return $this.installerFilename
    }

    [String] getInstallerArguments() 
    {
        return $this.installerArguments
    }
}

function downloadFile($downloadUrl, $installerFilename) {
    $ProgressPreference = "SilentlyContinue"
    Invoke-WebRequest $downloadUrl -OutFile $installerFilename
}

function executeInstaller($installerFilename, $installerArguments) {
    Start-Process -FilePath .\$installerFilename -ArgumentList $installerArguments -Wait -PassThru
}



Write-Host "Fast installer" -BackgroundColor White -ForegroundColor DarkBlue
$installersData = New-Object InstallersData -ArgumentList ".\installers_data.json"
$installersData.loadFileToVariable()

ForEach ($application in $applicationsToInstall)
{
    $installerData = New-Object InstallerData
    $installerData.collectInstallerData($application, $installersData)
    
    Write-Host "Download $application"
    downloadFile $installerData.getDownloadUrl() $installerData.getInstallerFilename()

    Write-Host "Install $application"
    $process = executeInstaller $installerData.getInstallerFilename() $installerData.getInstallerArguments()
    Write-Host "End install $application with status code " -NoNewLine
    Write-Host $process.ExitCode
}

Write-Host "End fast installer"
