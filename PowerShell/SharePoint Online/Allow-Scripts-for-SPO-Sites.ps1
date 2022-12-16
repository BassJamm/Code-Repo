<# Install Module
# Install-Module -Name Microsoft.Online.SharePoint.PowerShell
# Connect-SPOService -Url https://ukasonline-admin.sharepoint.com/
# Set-SPOSite <SiteURL> -DenyAddAndCustomizePages

Get-Content -Path C:\Fordway\UKAS-SPO-Sites.csv
#>

$GetSPOSites = Get-SPOSite -Limit All

foreach ($site in $GetSPOSites){
    if($site.DenyAddAndCustomizePages -eq "Enabled"){
        $site.Url         
        }
}