<# Script to collect machine information during troubleshooting & save these into a zip file for engineer to extract.
Information to collect:
- Ipconfig /all
- timestamp ping to internet.
- timestamp ping to gateway.
- Network adapter information.
#>

# Create folder for all files
New-Item "C:\NetworkDiagnosticCollection" -itemType Directory
Write-host 'Folder created at C:\NetworkDiagnosticCollection'

# Collect network report, grab this from the depositied location, usually here, "C:\ProgramData\Microsoft\Windows\WlanReport\"", Copy the whole folder to the C:\NetworkDiagnosticCollection folder.
netsh wlan show wlanreport
Copy-Item -Path C:\ProgramData\Microsoft\Windows\WlanReport\* -Destination C:\NetworkDiagnosticCollection

# Collect ipconfig information
ipconfig /all | Out-File -FilePath C:\NetworkDiagnosticCollection\IpAddressingInfo.txt

# Timestamped ping to internet
test-connection 8.8.8.8 -count 10 | format-table -AutoSize @{n='TimeStamp';e={Get-Date}},__SERVER, Address, ProtocolAddress, ResponseTime | Out-File -FilePath C:\NetworkDiagnosticCollection\PingtoGoogle.txt
test-connection 8.8.4.4 -count 10 | format-table -AutoSize @{n='TimeStamp';e={Get-Date}},__SERVER, Address, ProtocolAddress, ResponseTime | Out-File -FilePath C:\NetworkDiagnosticCollection\PingtoGoogle2.txt
Write-host 'Network Tests ran successfully'

$ipconfig = ipconfig | Format-List
write-output $ipconfig
$GatewayIp = Read-host -prompt "Enter Gateway IP address"

test-connection $GatewayIp -count 20 | format-table -AutoSize @{n='TimeStamp';e={Get-Date}},__SERVER, Address, ProtocolAddress, ResponseTime | Out-File -FilePath C:\NetworkDiagnosticCollection\PingtoGateway.txt

# Get Network Adapater Information
Get-NetAdapter | Format-List | Out-File -FilePath C:\NetworkDiagnosticCollection\NetworkAdapterInfo.txt
Write-Host Saved network adapter settings successufully

# Compress to a Zip and copy to the Downloads folder of logged in user.
Compress-Archive -Path C:\NetworkDiagnosticCollection C:\NetworkDiagnosticCollection\NetworkDiagnostics.zip
Write-host 'Zip file created within C:\NetworkDiagnosticCollection folder.'