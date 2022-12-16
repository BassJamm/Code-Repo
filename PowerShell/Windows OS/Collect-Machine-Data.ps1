<# Script to collect machine information during troubleshooting & save these into a zip file for engineer to extract.
Information to collect:
- Machine information.
- Machine IP addressing information.
- Recent event Logs (2 Hours)
- Azure AD Join Status
- Printer Info
- Group Policy result
#>

# Create folder for all files
New-Item "C:\SystemDiagnosticCollection" -itemType Directory
Write-host 'Folder created at C:\Systcls
emDiagnosticCollection'

# Collect System information
systeminfo | Out-File -FilePath C:\SystemDiagnosticCollection\SystemInfo.txt
Write-host 'System Info Collected'

# Collect IP address information and connectivity tests
ipconfig /all | Out-File -FilePath C:\SystemDiagnosticCollection\IpAddressingInfo.txt
Write-host 'ipconfig ran successfully'

# Test Connection to Google
Test-NetConnection www.google.com -InformationLevel "Detailed" | Out-File -FilePath C:\SystemDiagnosticCollection\pingtoGoogle-FQDN.txt
# Time Stamped Ping test
test-connection 8.8.8.8 -count 10 | format-table -AutoSize @{n='TimeStamp';e={Get-Date}},__SERVER, Address, ProtocolAddress, ResponseTime | Out-File -FilePath C:\SystemDiagnosticCollection\PingtoGoogle-IP.txt
Write-host 'Network Tests ran successfully'

# Collect event log information

# Collect System Logs
Get-Eventlog -LogName System -EntryType Error,Warning -After (Get-Date).AddHours(-2) | Export-csv c:\SystemDiagnosticCollection\System_Logs.csv -notype
# Collect Application Logs
Get-Eventlog -LogName Application -EntryType Error,Warning -After (Get-Date).AddHours(-2) | Export-csv c:\SystemDiagnosticCollection\Application_Logs.csv -notype
Write-host 'Successfully gathered Event Logs'

# Collect Azure AD Joined Status information
dsregcmd /status | Out-File -FilePath C:\SystemDiagnosticCollection\Hybrid-Joined-status.txt
Write-host 'Successfully checked for Hybrid-Joined status'

# Collect printer information
Get-printer | Out-File -FilePath C:\SystemDiagnosticCollection\Printer-Info.txt
Write-host 'Gathered Printer info'

# Get Verbose GP Result
gpresult /v | Out-file -FilePath C:\SystemDiagnosticCollection\GpResult.txt
Write-host 'Gathered GPO status'

# Compress to a Zip and copy to the Downloads folder of logged in user.
Compress-Archive -Path C:\SystemDiagnosticCollection C:\SystemDiagnosticCollectio\SystemDiagnostics.zip
Write-host 'Zip file created within C:\SystemDiagnosticCollection folder.'