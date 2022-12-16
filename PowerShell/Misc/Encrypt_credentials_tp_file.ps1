<# Set and encrypt credentials to file using default method #>

$credential = Get-Credential
$credential.Password | ConvertFrom-SecureString | Set-Content "C:\temp\Reporting\encrypted_password_for_reporting.txt"

<# Decrypting it and using it in a script#>

# Get the credential
$emailusername = "email.address@domain.com"
$encrypted = Get-Content "C:\temp\encrypted_password_for_reporting.txt" | ConvertTo-SecureString
$credential = New-Object System.Management.Automation.PsCredential($emailusername, $encrypted)
