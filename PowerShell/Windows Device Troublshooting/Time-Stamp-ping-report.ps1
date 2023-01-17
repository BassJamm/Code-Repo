<# Collect pings to various locations
Confirm the destionations for the pings and substitute them into the lines of code below.
Make sure to select both IP addresses and FQDNs for example, 8.8.8.8 is the Google public DNS IP, an FQDN would be a domain name or server name, wwww.google.com or FOR-AZ-DC01.
#>


<# Not completely finished this script, may require some logic checks before useing. #>

# Leave the two below, it's the ping to google DNS via IP and domain name, which will test internet connectivity and DNS resolution.
Start-Job -ScriptBlock { test-connection 8.8.8.8 -count 10 | format-table -AutoSize @{n='TimeStamp';e={Get-Date}},__SERVER, Address, ProtocolAddress, ResponseTime | Out-File -FilePath $env:USERPROFILE\Downloads\Time_Stamp_Ping_Google_DNS_IP.txt}
Start-Job -ScriptBlock { test-connection wwww.bbc.co.uk -count 10 | format-table -AutoSize @{n='TimeStamp';e={Get-Date}},__SERVER, Address, ProtocolAddress, ResponseTime | Out-File -FilePath $env:USERPROFILE\Downloads\Time_Stamp_Ping_Google_Domain_Name.txt}

Get-Job
Write-Host "Wait a couple of minutes for these to complete, you should see the files in the downloads folder of the logged in user."
Start-Sleep -Seconds 30

# Copy this line as required and make sure to update the sections where there are <CAPS>, delete the <> symbols too from the command.
Start-Job -ScriptBlock { test-connection "DESTINATION LOCATION" -count "ENTER HOW MANY TIMES YOU WANT THIS TO REPEAT" | format-table -AutoSize @{n='TimeStamp';e={Get-Date}},__SERVER, Address, ProtocolAddress, ResponseTime | Out-File -FilePath $env:USERPROFILE\Downloads\Time_Stamp_Ping_<CHANGE ME TO SOMETHING MORE USEFUL>.txt}