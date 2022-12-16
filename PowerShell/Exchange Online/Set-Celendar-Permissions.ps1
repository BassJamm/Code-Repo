# Manually connect to Exchange Online.
Connect-ExchangeOnline

# Get all User Mailboxes.
$userObject = Get-Mailbox -RecipientTypeDetails UserMailbox | select UserPrincipalName

# Single mailbox command.
# Set-MailboxFolderPermission -Identity firstname.Lastname@fordway.com:\Calendar -User Default -AccessRights LimitedDetails

# Loop through each user and set calendar permissions of the default user.
foreach($user in $userObject){
    $calendar = $user.UserPrincipalName+":\Calendar"
    Set-MailboxFolderPermission -Identity $calendar -User Default -AccessRights LimitedDetails
}
