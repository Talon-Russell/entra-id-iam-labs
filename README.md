
# Microsoft Entra ID IAM Labs

This repository contains my hands-on Microsoft Entra ID labs.

I'm using these projects to build my skills in Identity and Access Management (IAM), cloud security, and identity administration.

Each lab includes documentation, configurations, screenshots, and lessons learned.

## Completed Labs

### Lab 01 - User & Group Management

Created 10 fictional employee accounts using CSV bulk provisioning, configured security groups, and implemented dynamic group membership based on department attributes.

[View Lab 01 - User & Group Management](https://github.com/Talon-Russell/entra-id-iam-labs/blob/main/01-User-and-Group-Management/README.md)

### Lab 02 - External Identity Management

Configured Microsoft Entra B2B collaboration settings, invited an external contractor, and implemented guest access restrictions.

Created a dedicated security group for external contractors, verified guest invitation acceptance, and reviewed sign-in logs to confirm successful authentication.

[View Lab 02 - External Identity Management](https://github.com/Talon-Russell/entra-id-iam-labs/blob/main/02-External-Identity-Management/README.md)

### Lab 03 - Role-Based Access Control (RBAC)

Configured the Password Administrator role to delegate helpdesk responsibilities without granting Global Administrator privileges.

Tested password-reset permissions, verified restricted administrative access, removed the assigned role, and reviewed audit logs to validate administrative activity.

[View Lab 03 - Role-Based Access Control](https://github.com/Talon-Russell/entra-id-iam-labs/blob/main/Lab-03-RBAC/README.md)

### Lab 04 - Conditional Access & MFA

Created a Microsoft Entra Conditional Access policy requiring multifactor authentication for a selected test user while excluding an administrator account.

Configured the MFA grant control and used Report-only mode to evaluate the policy without enforcing additional authentication requirements.

[View Lab 04 - Conditional Access & MFA](https://github.com/Talon-Russell/entra-id-iam-labs/blob/main/Lab-04-Conditional-Access-MFA/README.md)

### Lab 05 - Microsoft Graph PowerShell Identity Automation

Developed a PowerShell script using Microsoft Graph to automate identity inventory reporting in Microsoft Entra ID.

Retrieved employee account information and security group memberships for 10 fictional employees across IT, HR, and Finance. Exported the results into a CSV report, validated group memberships against Entra ID, and used PowerShell to analyze department membership and account status.

[View Lab 05 - Microsoft Graph PowerShell Identity Automation](https://github.com/Talon-Russell/entra-id-iam-labs/blob/main/05-Identity-Automation/README.md)

## Technologies

- Microsoft Entra ID
- Microsoft Entra Admin Center
- Identity and Access Management (IAM)
- Role-Based Access Control (RBAC)
- Microsoft Entra Conditional Access
- Multifactor Authentication (MFA)
- Microsoft Entra B2B Collaboration
- External Identities
- Security Groups
- Dynamic Membership Rules
- CSV Bulk Provisioning
- Microsoft Entra Audit Logs
- Microsoft Entra Sign-in Logs
- PowerShell 7
- Microsoft Graph PowerShell SDK
- Identity Inventory Automation
- CSV Reporting
