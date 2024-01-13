if (!(Connect-MSGraph)) {
    Connect-Graph
}

$Devices = Get-IntuneManagedDevice -Filter "contains(operatingSystem,'Windows')"

Foreach ($Device in $Devices) {
    Invoke-IntuneManagedDeviceSyncDevice -managedDeviceId $Device.id
    Write-Host "Syncing device $($Device.deviceName)" -ForegroundColor Green
}