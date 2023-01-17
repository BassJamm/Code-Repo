<#
Collect basic information useful in troubleshooting of a Windows device.
#>

# Create folder for all files
New-Item "C:\SystemDiagnosticCollection" -itemType Directory
Write-host 'Folder created at C:\SystemDiagnosticCollection' #not finished yet, it'll print out only.

Write-host 'Basic AAD Info'
dsregcmd /status | select-string -Pattern 'Device Name'  | Out-File -FilePath C:\SystemDiagnosticCollection\Basic-AAD-Info.txt
dsregcmd /status | select-string -Pattern 'AzureADJoined' | Out-File -Append -FilePath C:\SystemDiagnosticCollection\Basic-AAD-Info.txt
dsregcmd /status | select-string -Pattern 'DeviceId' | Out-File -Append -FilePath C:\SystemDiagnosticCollection\Basic-AAD-Info.txt
dsregcmd /status | select-string -Pattern 'TenantName' | Out-File -Append -FilePath C:\SystemDiagnosticCollection\Basic-AAD-Info.txt

write-host 'Single Sign on Info'
dsregcmd /status | select-string -Pattern 'AzureAdPrt' | Out-File -FilePath C:\SystemDiagnosticCollection\Single-Sign-on-Info.txt
dsregcmd /status | select-string -Pattern 'AzureAdPrtUpdateTime' | Out-File -Append -FilePath C:\SystemDiagnosticCollection\Single-Sign-on-Info.txt
dsregcmd /status | select-string -Pattern 'RefreshPrtDiagnostics' | Out-File -Append -FilePath C:\SystemDiagnosticCollection\Single-Sign-on-Info.txt

Write-host 'System Information'
systeminfo | Select-String -Pattern 'OS Name' | Out-File -FilePath C:\SystemDiagnosticCollection\System-Information.txt
systeminfo | Select-String -Pattern 'OS Version' | Out-File -Append -FilePath C:\SystemDiagnosticCollection\System-Information.txt
systeminfo | Select-String -Pattern 'Original Install Date' | Out-File -Append -FilePath C:\SystemDiagnosticCollection\System-Information.txt
systeminfo | Select-String -Pattern 'System Boot Time' | Out-File -Append -FilePath C:\SystemDiagnosticCollection\System-Information.txt
systeminfo | Select-String -Pattern 'Time Zone' | Out-File -Append -FilePath C:\SystemDiagnosticCollection\System-Information.txt
systeminfo | Select-String -Pattern 'Total Physical Memory' | Out-File -Append -FilePath C:\SystemDiagnosticCollection\System-Information.txt