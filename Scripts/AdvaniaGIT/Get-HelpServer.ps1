﻿function Get-HelpServer
{
    param (
        [Parameter(Mandatory=$True, ValueFromPipelineByPropertyname=$true)]
        [String]$MainVersion,
        [Parameter(Mandatory=$False, ValueFromPipelineByPropertyname=$true)]
        [String]$SettingsFilePath = "Data\NAVVersions.Json"
    )
                
    $navVersions = Get-Content -Path (Join-Path (Split-Path -Parent (Split-Path -Parent $PSScriptRoot)) $SettingsFilePath) | Out-String | ConvertFrom-Json
    $helpServer = ($navVersions.Releases | Where-Object -Property mainVersion -EQ $MainVersion).helpServer
    
    Return $helpServer
}
