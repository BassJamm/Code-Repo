<# Requires the ImportExcel module to be installed.#>


$repository = Get-VBORepository -Name "" # Store Repository name.
$reportPath = "$env:USERPROFILE\Report Name - $((Get-Date).ToString('yyyy-MM-dd'))\Backup-Report.xlsx" # Creates the report file and sets the file\location into variable.


$mailboxData = Get-VBOEntityData -Repository $repository -Type Mailbox | Select-Object Email, IsArchive, BackedUpTime | sort-object Email # User mailbox backup status.
$oneDriveData = Get-VBOEntityData -Repository $repository -Type OneDrive | Select-Object DisplayName, Url, BackedUpTime | sort-object Title # OneDrive backup status.
$spoData = Get-VBOEntityData -Repository $repository -Type Site | Where-Object {$_.Url -notlike "*personal*"} |Select-Object DisplayName, Url, BackedUpTime | sort-object Title  # SPO site backup status.


$dateRange = (get-date).AddDays(-7).Date # Set the date range to collect backup jobs from.
$backupJobReport = Get-VBOJobSession -JobType Backup | Where-Object {$_.JobName -like "enter filter" -and $_.EndTime -gt $dateRange} | Select-Object JobName, Status, EndTime # Get last 30 days of the backup job sessions.

$mailboxData | Export-Excel -WorkSheetName "MailboxData" -Path "$reportPath"
$oneDriveData | Export-Excel -WorkSheetName "OneDriveData" -Path "$reportPath"
$spoData | Export-Excel -WorkSheetName "SharePointSiteData" -Path "$reportPath"
$backupJobReport | Export-Excel -WorkSheetName "BackupJobData" -Path "$reportPath"

# Get the credential
$emailusername = "email.address@domain.com" # Set the username for the account.
$encrypted = Get-Content "$env:USERPROFILE\encrypted_password_for_reporting.txt" | ConvertTo-SecureString # Decrypt the password file using the logged in account.
$credential = New-Object System.Management.Automation.PsCredential($emailusername, $encrypted) # Creates new PS objects to store the above in.

## Define the Send-MailMessage parameters
$mailParams = @{
    SmtpServer                 = 'smtp.office365.com'
    Port                       = '587' # or '25' if not using TLS
    UseSSL                     = $true ## or not if using non-TLS
    Credential                 = $credential
    From                       = 'email.address@domain.com'
    To                         = 'email.address@domain.com'# , 'recipient@NotYourDomain.com'
    Subject                    = "SMTP Client Submission - $(Get-Date -Format g)"
    Body                       = 'This is a test email using SMTP Client Submission'
    Attachment                 =  $reportPath
    DeliveryNotificationOption = 'OnFailure', 'OnSuccess'
}

## Send the message
Send-MailMessage @mailParams