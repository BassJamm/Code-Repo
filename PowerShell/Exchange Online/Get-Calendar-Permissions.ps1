# Manually connect to Exchange Online.
Connect-ExchangeOnline

# Get all User Mailboxes.
$userObject = Get-Mailbox -RecipientTypeDetails UserMailbox | select UserPrincipalName

# Single mailbox command.
# Get-MailboxFolderPermission -Identity Ryan.Wilson@traderemedies.gov.uk:\Calendar -User Default | ft

# Loop through each user and get calendar permissions of the default user.
foreach($user in $userObject){
    $calendar = $user.UserPrincipalName+":\Calendar"
    Get-MailboxFolderPermission -Identity $calendar | Export-csv -Append $env:USERPROFILE\Downloads\calendar-perms.csv
}