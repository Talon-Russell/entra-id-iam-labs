\# Lab 05 — Microsoft Graph PowerShell Identity Automation



\## Overview



In this lab, I used Microsoft Graph PowerShell to automate the process of collecting user information and security group memberships from Microsoft Entra ID.



The goal was to create a reusable PowerShell script that could generate an identity inventory report without having to manually review each user in the Entra admin center.



\## Business Scenario



Copper Creek Technologies needs to review employee accounts and security group memberships across its IT, HR, and Finance departments.



As an IAM analyst, I was tasked with creating a PowerShell script to collect employee information and export it into a CSV report for review.



\## Technologies Used



\- Microsoft Entra ID

\- Microsoft Graph PowerShell SDK

\- PowerShell 7

\- Microsoft Excel



\## Implementation



1\. Installed PowerShell 7 and the required Microsoft Graph PowerShell modules.

2\. Connected to Microsoft Entra ID using read-only Microsoft Graph permissions.

3\. Queried employee accounts to retrieve usernames, departments, and account status.

4\. Retrieved security group memberships for the IT, HR, and Finance departments.

5\. Created a PowerShell script to automate the identity inventory process.

6\. Exported the collected information into a CSV report.

7\. Compared the report against Microsoft Entra ID to verify group membership accuracy.

8\. Used PowerShell to analyze department membership counts, account status, and unique employee accounts.



\## Results



The PowerShell script successfully generated an identity inventory report containing 10 employee accounts across three security groups.



| Department | Employees |

|---|---|

| IT | 3 |

| HR | 4 |

| Finance | 3 |

| \*\*Total\*\* | \*\*10\*\* |



All 10 employee accounts were enabled, and no disabled accounts were identified in the report.



\## Validation



I verified that the script successfully retrieved employee information and security group memberships from Microsoft Entra ID.



I compared the members of the SG-IT security group against the exported CSV report to confirm that the information was accurate.



I also used PowerShell to verify the number of employees in each department, identify disabled accounts, and count unique employee accounts.



\## PowerShell Script



\[View Get-IdentityInventory.ps1](Get-IdentityInventory.ps1)



The script uses Microsoft Graph PowerShell to retrieve employee information and security group memberships and export the results into a CSV report.



\## Screenshots



\### Microsoft Graph Connection



!\[Graph Connection](screenshots/03-Graph-Connection.png)



\### Employee Identity Query



!\[User Query](screenshots/04-User-Query.png)



\### PowerShell Script Execution



!\[Script Execution](screenshots/06-Script-Execution.png)



\### CSV Identity Inventory Report



!\[CSV Inventory](screenshots/07-CSV-Inventory.png)



\### Group Membership Validation



!\[Membership Validation](screenshots/08-Membership-Validation.png)



\### PowerShell Report Analysis



!\[Report Analysis](screenshots/09-Report-Analysis.png)



\## Lessons Learned



This lab helped me understand how Microsoft Graph PowerShell can be used to automate identity administration and reporting tasks.



I learned how to connect to Microsoft Entra ID, retrieve employee information, query security group memberships, and generate CSV reports using PowerShell.



I also gained experience validating automated reports and using PowerShell to review account status and department memberships.



\## Security Considerations



The script uses read-only Microsoft Graph permissions and does not modify any user accounts or security groups.



All testing was performed using fictional employee accounts in a personal Microsoft Entra ID lab environment.

