Check-GitNotUnattached
Check-NAVServiceRunning -SetupParameters $SetupParameters -BranchSettings $BranchSettings 
Load-ModelTools -SetupParameters $SetupParameters
$ExportPath = Get-NAVExportPath -Repository $SetupParameters.ObjectsPath -WorkFolder (Join-Path $SetupParameters.WorkFolder 'Objects') -StoreAllObjects $SetupParameters.storeAllObjects

Write-Host -Object ''
New-Item -Type directory -Path $ExportPath -Force -ErrorAction SilentlyContinue | Out-Null
Write-Host -Object "Deleting TXT files from Objects folder..."
Remove-Item -Path (Join-Path $ExportPath "*.*") -Force 

Update-NAVTxtFromApplication -SetupParameters $SetupParameters -BranchSettings $BranchSettings -ObjectsPath $ExportPath
if ($SetupParameters.objectProperties -eq "false") {
    Write-Host "Clearing object properties..."
    Set-NAVApplicationObjectProperty -TargetPath $ExportPath -VersionListProperty '' -DateTimeProperty '' -ModifiedProperty No
}
Split-Solution -SetupParameters $SetupParameters -ObjectsFilePath $ExportPath
UnLoad-ModelTools