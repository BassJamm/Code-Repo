# Create folder for all files
New-Item "C:\SystemDiagnosticCollection" -itemType Directory
Write-host 'Folder created at C:\SystemDiagnosticCollection' #not finished yet, it'll print out only.

Write-host 'Basic AAD Info'
dsregcmd /status | select-string -Pattern 'Device Name' 
dsregcmd /status | select-string -Pattern 'AzureADJoined'
dsregcmd /status | select-string -Pattern 'DeviceId'
dsregcmd /status | select-string -Pattern 'TenantName'

write-host 'Single Sign on Info'
dsregcmd /status | select-string -Pattern 'AzureAdPrt'
dsregcmd /status | select-string -Pattern 'AzureAdPrtUpdateTime'
dsregcmd /status | select-string -Pattern 'RefreshPrtDiagnostics'

Write-host 'System Information'
systeminfo | Select-String -Pattern 'OS Name'
systeminfo | Select-String -Pattern 'OS Version'
systeminfo | Select-String -Pattern 'Original Install Date'
systeminfo | Select-String -Pattern 'System Boot Time'
systeminfo | Select-String -Pattern 'Time Zone'
systeminfo | Select-String -Pattern 'Total Physical Memory'
