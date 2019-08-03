function Add-VagrantBox($filename, $debug) {
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
    
    $mySplit = $filename -split "_"
    $p0 = $mySplit[0] -replace '\\' -replace '\.'
    $p1 = $mySplit[1]
    $p2 = $mySplit[2]
    $p3 = $mySplit[3]
    $p4 = $mySplit[4]
    $p5 = $mySplit[5] 
    $p6 = $mySplit[6] -replace '\.box'
    
    $vagrantBoxName = "$p0/$p2" # e.g. generic/alpine37
    $vagrantBoxNameWordedSlash = "$p0-VAGRANTSLASH-$p2" # e.g. generic-VAGRANTSLASH-alpine37
    $vagrantBoxVersion = $p4 # e.g 1.9.16
    $vagrantBoxProvider = $p6 # e.g. hyperv, virtualbox etc
    $vagrantHomeDir = $env:VAGRANT_HOME  # e.g. E:\Vagrant\vagrant.d
    
    if($debug -eq $true) {
        Write-Host "p0 :" $p0
        Write-Host "p1 :" $p1 
        Write-Host "p2 :" $p2 
        Write-Host "p3 :" $p3
        Write-Host "p4 :" $p4
        Write-Host "p5 :" $p5    
        Write-Host "p6 :" $p6     
        Write-Host "vagrantBoxName : " $vagrantBoxName
        Write-Host "vagrantBoxVersion : " $vagrantBoxVersion
        Write-Host "vagrantBoxProvider : " $vagrantBoxProvider
        Write-Host "vagrantHomeDir : " $vagrantHomeDir
        Write-Host "vagrantBoxNameWordedSlash :" $vagrantBoxNameWordedSlash 
    }
    
    # Add vagrant box
    vagrant box add $vagrantBoxName $filename
    
    # Rename vagrant box version from 0 to proper version
    $vagrantHomeTargetBoxDir = "$vagrantHomeDir\boxes\$vagrantBoxNameWordedSlash"; # e.g. E:\Vagrant\vagrant.d\boxes\generic-VAGRANTSLASH-alpine37
    Move-Item $vagrantHomeTargetBoxDir\0 $vagrantHomeTargetBoxDir\$vagrantBoxVersion
    Write-Host "Renamed $vagrantHomeTargetBoxDir\0 to $vagrantHomeTargetBoxDir\$vagrantBoxVersion" -ForegroundColor Green
}

