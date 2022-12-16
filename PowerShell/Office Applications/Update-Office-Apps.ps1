<# Locate the office click to run installer

Default location: cd C:\Program Files\Common Files\Microsoft Shared\ClickToRun

#>

cd "C:\Program Files\Common Files\Microsoft Shared\ClickToRun"

<# different channel options

Current - Latest version.
Deferred - Semi-Annual.

#>
OfficeC2RClient.exe /changesetting Channel=Current
OfficeC2RClient.exe /update user