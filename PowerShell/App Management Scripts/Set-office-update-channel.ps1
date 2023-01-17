<# 
Locate the office click to run installer, default location: cd C:\Program Files\Common Files\Microsoft Shared\ClickToRun
#>

cd "C:\Program Files\Common Files\Microsoft Shared\ClickToRun"

<# 
Different channel options
Current - Latest version.
Deferred - Semi-Annual.
#>

OfficeC2RClient.exe /changesetting Channel=Current
OfficeC2RClient.exe /update user