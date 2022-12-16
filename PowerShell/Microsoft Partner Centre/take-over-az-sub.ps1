# https://learn.microsoft.com/en-us/partner-center/reinstate-csp

# Connect to Sub.
Connect-AzAccount -TenantID "Tenant ID"
# Set the subscription context you want to add partner permissions too.
Set-AzContext -SubscriptionID "Subscription ID"
# Assign the "adminagents" group in Partner tenant to the customer subscription
# New-AzRoleAssignment -ObjectID "<Object ID of the AdminAgents group from step 7 of your actions section>" -RoleDefinitionName "Owner" -Scope "/subscriptions/<CSP subscription ID>" -ObjectType "ForeignGroup"
New-AzRoleAssignment -ObjectID "AdminAgents group in partner tenant" -RoleDefinitionName "Owner" -Scope "/subscriptions/Subscription ID" -ObjectType "ForeignGroup"