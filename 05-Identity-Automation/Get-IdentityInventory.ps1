
# Get-IdentityInventory.ps1
# Lab 05 - Microsoft Graph PowerShell Identity Automation
# Purpose: Export a read-only inventory of lab group members.

$ErrorActionPreference = "Stop"

# Step 1 - Make sure we are connected to Microsoft Graph.

$context = Get-MgContext

if (-not $context) {
    throw "Not connected to Microsoft Graph. Run Connect-MgGraph first."
}

# Step 2 - Define the output directory.

$reportDirectory = Join-Path $PSScriptRoot "reports"

New-Item -ItemType Directory `
    -Path $reportDirectory -Force | Out-Null

# Step 3 - Define the lab security groups.
# Replace these names with your actual group names.

$groupNames = @(
    "SG-IT",
    "SG-HR",
    "SG-FINANCE"
)

# Step 4 - Create a collection for the results.

$inventory = @()

# Step 5 - Loop through each security group.

foreach ($groupName in $groupNames) {

    Write-Host "Checking group: $groupName"

    # Find the group by its display name.
    $safeName = $groupName.Replace("'", "''")

    $groups = @(
        Get-MgGroup -Filter "displayName eq '$safeName'" -All
    )

    if ($groups.Count -ne 1) {
        Write-Warning "Expected one group named $groupName; found $($groups.Count). Skipping."
        continue
    }

    $group = $groups[0]

    # Retrieve direct user members of the group.

    $members = @(
        Get-MgGroupMemberAsUser -GroupId $group.Id -All
    )

    foreach ($member in $members) {

        # Retrieve the employee's identity properties.

        $user = Get-MgUser -UserId $member.Id `
            -Property @(
                "DisplayName",
                "UserPrincipalName",
                "Department",
                "AccountEnabled"
            )

        # Build one report entry.

        $inventory += [PSCustomObject]@{
            DisplayName       = $user.DisplayName
            UserPrincipalName = $user.UserPrincipalName
            Department        = $user.Department
            AccountEnabled    = $user.AccountEnabled
            SecurityGroup     = $group.DisplayName
            ReportDate        = Get-Date -Format "yyyy-MM-dd"
        }
    }
}

# Step 6 - Export the report.

if ($inventory.Count -gt 0) {

    $reportPath = Join-Path `
        $reportDirectory "IdentityInventory.csv"

    $inventory |
        Sort-Object SecurityGroup, DisplayName |
        Export-Csv -Path $reportPath `
            -NoTypeInformation -Encoding utf8

    Write-Host ""
    Write-Host "Inventory completed successfully."
    Write-Host "Report saved to: $reportPath"
    Write-Host "Total membership records: $($inventory.Count)"

} else {

    Write-Warning "No membership records found. No CSV was generated."

}
