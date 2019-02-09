$targetBinary = "choco"

if ((Get-Command $targetBinary -ErrorAction Continue)  -eq $null)
{
    Write-Host "$targetBinary not found, installing now .."
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
} else {
    Write-Host "$targetBinary found"
}

if ((Get-Command "git" -ErrorAction Continue)  -eq $null)
{
    Write-Host "git not found, installing now .."
    choco install git -y;
}
