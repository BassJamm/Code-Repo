Get-ADUser -filter * -properties PasswordLastSet  | Select-Object Name, PasswordLastSet | Export-csv -Path $env:USERPROFILE\PwdLastResetTime.csv
Get-ADUser -filter * -properties PwdLastSet,PasswordLastSet  | Format-Table Name,@{Name='PwdLastSet';Expression={[DateTime]::FromFileTime($_.PwdLastSet)}},PasswordLastSet | out-file -filepath $env:USERPROFILE\PwdLastResetTimePwdLastResetTime.txt
