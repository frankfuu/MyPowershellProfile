param(
    [string]$filename,
    [bool]$debug,
    [bool]$dryRun
)

function Add-VagrantBox($filename, $debug, $dryRun) {
    ## Usage .\addvbox.ps1 -debug $true -filename .\generic_boxes_alpine37_versions_1.9.18_providers_hyperv.box

    if([string]::IsNullOrWhiteSpace($env:VAGRANT_HOME))
    {
        Write-Host "VAGRANT_HOME variable not set. Please set and retry" -ForegroundColor Red
        exit 1;
    }
    if([string]::IsNullOrWhiteSpace($filename)) {
        Write-Host "variable filename is required." -ForegroundColor Red
        exit 1;
    }


    $arr = $filename -split "versions"
    
    $partA = $arr[0].split("_",[System.StringSplitOptions]::RemoveEmptyEntries)
    $partB = $arr[1].split("_",[System.StringSplitOptions]::RemoveEmptyEntries)

    $partA_0 = $partA[0] -replace '\\' -replace '\.'
    $partA_1 = $partA[1]

    $start = 2
    $stop = $partA.Length    
    $partA_rest = $partA[$start..$stop]
    $partA_rest_joined = $partA_rest -join '_'

    $partB_0 = $partB[0]
    $partB_1 = $partB[1]
    $partB_2 = $partB[2] -replace '\.box'    

    
    $vagrantBoxName = "$partA_0/$partA_rest_joined" # e.g. generic/alpine37
    $vagrantBoxNameWordedSlash = "$partA_0-VAGRANTSLASH-$partA_rest_joined" # e.g. generic-VAGRANTSLASH-alpine37
    $vagrantBoxVersion = $partB_0 # e.g 1.9.16
    $vagrantBoxProvider = $partB_2 # e.g. hyperv, virtualbox etc
    $vagrantHomeDir = $env:VAGRANT_HOME  # e.g. E:\Vagrant\vagrant.d
    
    if($debug -eq $true) {       
        Write-Host "vagrantBoxName : " $vagrantBoxName
        Write-Host "vagrantBoxVersion : " $vagrantBoxVersion
        Write-Host "vagrantBoxProvider : " $vagrantBoxProvider
        Write-Host "vagrantHomeDir : " $vagrantHomeDir
        Write-Host "vagrantBoxNameWordedSlash :" $vagrantBoxNameWordedSlash 
    }

    if(-Not($dryRun -eq $true) ) {
        # Add vagrant box
        vagrant box add $vagrantBoxName $filename
            
        # Rename vagrant box version from 0 to proper version
        $vagrantHomeTargetBoxDir = "$vagrantHomeDir\boxes\$vagrantBoxNameWordedSlash"; # e.g. E:\Vagrant\vagrant.d\boxes\generic-VAGRANTSLASH-alpine37
        Move-Item $vagrantHomeTargetBoxDir\0 $vagrantHomeTargetBoxDir\$vagrantBoxVersion
        Write-Host "Renamed $vagrantHomeTargetBoxDir\0 to $vagrantHomeTargetBoxDir\$vagrantBoxVersion" -ForegroundColor Green
    }
}

# Add-VagrantBox -filename $filename -dryRun $dryRun -debug $debug

function Set-HypervStatus($enable) {
    if($enable -eq $true) {
        Write-Host "Enabling Hyper-V"
        dism.exe /Online /Enable-Feature:Microsoft-Hyper-V
    }
    elseif ($enable -eq $false) {
        Write-Host "Disabling Hyper-V"
        dism.exe /Online /Disable-Feature:Microsoft-Hyper-V
    }
    else {
        Write-Host "Please set variable enable to true or false"
        dism.exe /Online /Disable-Feature:Microsoft-Hyper-V
    }
}