
# Lab 05 — Microsoft Graph PowerShell Identity Automation

## Overview

In this lab, I used Microsoft Graph PowerShell to automate the process of collecting employee information and security group memberships from Microsoft Entra ID.

The goal was to create a reusable PowerShell script that could generate an identity inventory report instead of manually reviewing each employee account in the Entra admin center.

## Business Scenario

Copper Creek Technologies needs to review employee accounts and security group memberships across its IT, HR, and Finance departments.

As an IAM analyst, I was tasked with creating a PowerShell script to retrieve employee information, identify security group memberships, and export the results into a CSV report for review.

## Technologies Used

- Microsoft Entra ID
- Microsoft Graph PowerShell SDK
- PowerShell 7
- Microsoft Excel

## Objectives

- Connect to Microsoft Entra ID using Microsoft Graph PowerShell.
- Retrieve employee information and department attributes.
- Identify security group memberships.
- Automate identity inventory collection using PowerShell.
- Export the collected data into a CSV report.
- Validate the results against Microsoft Entra ID.
- Analyze account status and department membership.

---

## Implementation

### Step 1 — Configure PowerShell

Installed PowerShell 7 and verified the installation.

I also installed the Microsoft Graph PowerShell modules needed for authentication, user management, and group queries.

The modules included:

- Microsoft.Graph.Authentication
- Microsoft.Graph.Users
- Microsoft.Graph.Groups

Verified the PowerShell installation using:

```powershell
$PSVersionTable.PSVersion
```

![PowerShell Version](screenshots/01-PowerShell-Version.png)

Verified the Microsoft Graph modules using:

```powershell
Get-Module Microsoft.Graph* -ListAvailable |
Select-Object Name, Version
```

![Microsoft Graph Modules](screenshots/02-Graph-Modules.png)

### Step 2 — Connect to Microsoft Entra ID

Connected to my Microsoft Entra ID tenant using Microsoft Graph PowerShell.

I used the following read-only Microsoft Graph permissions:

- User.Read.All
- Group.Read.All
- GroupMember.Read.All

```powershell
Connect-MgGraph -Scopes @(
    "User.Read.All",
    "Group.Read.All",
    "GroupMember.Read.All"
) -NoWelcome
```

Verified the connection using:

```powershell
Get-MgContext |
Select-Object Account, TenantId, Scopes
```

![Microsoft Graph Connection](screenshots/03-Graph-Connection.png)

### Step 3 — Retrieve Employee Information

Used Microsoft Graph PowerShell to retrieve employee account information from Microsoft Entra ID.

The query collected each employee's display name, user principal name, department, and account status.

```powershell
Get-MgUser -All -Property `
    "DisplayName,UserPrincipalName,Department,AccountEnabled" |
Select-Object DisplayName,UserPrincipalName,
    Department,AccountEnabled |
Format-Table -AutoSize
```

I verified that the fictional employee accounts created in my earlier lab appeared in the results.

![Employee Identity Query](screenshots/04-User-Query.png)

### Step 4 — Retrieve Security Group Memberships

Queried the security groups created in my earlier Entra ID labs.

The groups included:

- SG-IT
- SG-HR
- SG-FINANCE

Used PowerShell to retrieve the available security groups:

```powershell
Get-MgGroup -All |
Select-Object DisplayName, Id |
Format-Table -AutoSize
```

I also queried the members of the SG-IT security group.

```powershell
$group = Get-MgGroup -Filter "displayName eq 'SG-IT'"

Get-MgGroupMemberAsUser -GroupId $group.Id -All |
Select-Object DisplayName, Id
```

![Security Group Membership](screenshots/05-Group-Membership.png)

### Step 5 — Create the Identity Automation Script

Created a PowerShell script named `Get-IdentityInventory.ps1` to automate identity inventory reporting.

The script performs the following tasks:

1. Checks the Microsoft Graph connection.
2. Locates the selected security groups.
3. Retrieves direct user memberships from each group.
4. Collects employee identity attributes.
5. Creates an inventory containing account and group information.
6. Exports the results into a CSV report.

The script collects:

- Display name
- User principal name
- Department
- Account enabled status
- Security group
- Report date

The script uses read-only Microsoft Graph commands and does not modify employee accounts or group memberships.

**PowerShell Script:**

[View Get-IdentityInventory.ps1](Get-IdentityInventory.ps1)

### Step 6 — Execute the Automation Script

Executed the PowerShell script to automatically collect employee information and security group memberships.

```powershell
.\Get-IdentityInventory.ps1
```

The script successfully queried all three security groups and generated an identity inventory containing 10 membership records.

The report was saved as `IdentityInventory.csv` in the reports folder.

![PowerShell Script Execution](screenshots/06-Script-Execution.png)

### Step 7 — Review the CSV Report

Opened the generated CSV report in Microsoft Excel to review the collected employee information.

The report contained six columns:

- DisplayName
- UserPrincipalName
- Department
- AccountEnabled
- SecurityGroup
- ReportDate

The report contained 10 fictional employee accounts across the IT, HR, and Finance departments.

![CSV Identity Inventory Report](screenshots/07-CSV-Inventory.png)

### Step 8 — Validate Security Group Memberships

Validated the accuracy of the generated report by comparing the CSV results against Microsoft Entra ID.

Navigated to:

**Microsoft Entra admin center > Entra ID > Groups > All groups > SG-IT > Members**

The SG-IT security group contained three employees, matching the three membership records in the exported CSV report.

This helped confirm that the PowerShell script accurately retrieved the security group membership information.

![Security Group Membership Validation](screenshots/08-Membership-Validation.png)

### Step 9 — Analyze the Identity Inventory

Used PowerShell to analyze the generated CSV report.

**Count employees by department:**

```powershell
Import-Csv ".\reports\IdentityInventory.csv" |
Group-Object Department |
Select-Object Name, Count
```

The results showed:

| Department | Employees |
|---|---|
| IT | 3 |
| HR | 4 |
| Finance | 3 |
| **Total** | **10** |

**Check for disabled accounts:**

```powershell
Import-Csv ".\reports\IdentityInventory.csv" |
Where-Object { $_.AccountEnabled -eq "False" }
```

The query returned no results because all 10 employee accounts in the report were enabled.

**Count unique employee accounts:**

```powershell
$users = Import-Csv ".\reports\IdentityInventory.csv"

($users | Select-Object -Unique UserPrincipalName).Count
```

The command confirmed that the report contained 10 unique employee accounts.

![PowerShell Report Analysis](screenshots/09-Report-Analysis.png)

---

## Results

Successfully created and executed a PowerShell script to automate identity inventory reporting in Microsoft Entra ID.

The script retrieved employee information and direct security group memberships across three departments.

**Final Results:**

- 10 unique employee accounts identified.
- 3 security groups queried.
- 3 IT employees.
- 4 HR employees.
- 3 Finance employees.
- 0 disabled accounts identified in the report.
- CSV report successfully generated.
- SG-IT membership validated against Microsoft Entra ID.

## Lessons Learned

This lab helped me understand how Microsoft Graph PowerShell can be used to automate identity administration and reporting tasks.

I learned how to connect to Microsoft Entra ID, retrieve employee information, query security group memberships, and generate CSV reports using PowerShell.

I also gained experience validating automated results and using PowerShell to analyze account status and department memberships.

This showed me how automation can reduce manual work when performing IAM inventory and access auditing tasks.

## Security Considerations

The PowerShell script uses read-only Microsoft Graph permissions and does not modify or delete user accounts or security groups.

All testing was performed using fictional employee accounts in a personal Microsoft Entra ID lab environment.

The script only inventories direct membership in the three selected security groups and does not represent a full tenant-wide access review.

## Future Improvements

Some improvements I could make to this project include:

- Identifying disabled accounts that still belong to security groups.
- Detecting mismatches between employee departments and security group assignments.
- Automatically generating inventory reports on a schedule.
- Adding error logging and exception handling.
- Expanding the script to review privileged role assignments.
