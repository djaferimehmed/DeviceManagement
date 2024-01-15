###### Installing the Powershell SDK Module
# More info here https://www.powershellgallery.com/packages/Microsoft.Graph.Intune

# Install the module
Install-Module -Name Microsoft.Graph.Intune -Force
Install-Module -Name Microsoft.Graph.DeviceManagement -Force

# Update the module
Update-Module -Name Microsoft.Graph.Intune -Force

# check if module is installed
Import-Module -Name Microsoft.Graph.Intune
Get-Module -Name Microsoft.Graph.Intune -ListAvailable

Import-Module -Name Microsoft.Graph.DeviceManagement
Get-Module -Name Microsoft.Graph.DeviceManagement -ListAvailable

# See all Cmdlets available in the SDK
Get-command -Module Microsoft.Graph.Intune | Get-MSGraphAllPages
Get-Command -Module Microsoft.Graph.DeviceManagement | Get-MSGraphAllPages | Out-File -FilePath ./Files/MDCmdlets.txt

# Count of all cmdlets
$Cmdlets = Get-command -Module Microsoft.Graph.Intune
$Cmdlets.count

# Connecting to Graph
Connect-MSGraph


# Get all managed devices in the tenant
$managedDevices = Get-IntuneManagedDevice | Get-MSGraphAllPages

$filteredDevices = Get-IntuneManagedDevice | Get-MSGraphAllPages | Where-Object { $_.DeviceName -like "*DG-SM*" } | Select-Object DeviceName, managedDeviceOwnerType, userPrincipalName | ConvertTo-Json 
$filteredDevices

Get-IntuneManagedDevice | Get-MSGraphAllPages | Where-Object { $_.DeviceName -like '*DG-CH-PCD*' -and $_.managedDeviceOwnerType -eq 'personal' } | Select-Object DeviceName, managedDeviceId, managedDeviceOwnerType, userPrincipalName | ConvertTo-Json

$changeDevice = Get-IntuneManagedDevice | Get-MSGraphAllPages | Where-Object { $_.DeviceName -like '*DG-CH-PCD*' -and $_.managedDeviceOwnerType -eq 'personal' } 
Write-Host $changeDevice.userDisplayName
Connect-MSGraph
Update-MgDeviceManagementManagedDevice -ManagedDeviceId $changeDevice.id -ManagedDeviceOwnerType  "corporate"
