﻿function Load-NAVKontoTenantStartMenu
{
    param (
        [Parameter(Mandatory=$True, ValueFromPipelineByPropertyname=$true)]
        [PSObject]$Provider,
        [Parameter(Mandatory=$True, ValueFromPipelineByPropertyname=$true)]
        [PSObject]$Tenants
    )
    $menuItems = @()
    $TenantNo = 1
    foreach ($Tenant in $Tenants) {
        $menuItem = $Tenant
        $menuItem | Add-Member -MemberType NoteProperty -Name No -Value $TenantNo -Force
        $tenantConfig = Get-NAVKontoResponse -Provider $Provider -Query "get-tenant?guid=$($Tenant.guid)"
        if ($tenantConfig.Status -eq "True") {
            $menuItem = Combine-Settings $tenantConfig.Result $menuItem
        }
        $menuItems += $menuItem
        $TenantNo ++
    }    
    Return $menuItems
}

