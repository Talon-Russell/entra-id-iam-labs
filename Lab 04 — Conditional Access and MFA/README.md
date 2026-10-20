
# Lab 04 — Conditional Access and MFA

## Overview

In this lab, I configured a Conditional Access policy in Microsoft Entra ID for a fictional company called Copper Creek.

The goal was to require multifactor authentication (MFA) for selected employees while excluding administrative accounts from the policy.

I created a Conditional Access policy, configured user assignments, applied MFA requirements, and used Report-only mode to evaluate the policy without enforcing access restrictions.

## Business Scenario

Copper Creek wants to improve account security by requiring MFA for employees accessing company resources.

The company wants to test the policy on a small number of users before deploying it across the organization.

As the IAM administrator, I was responsible for creating a Conditional Access policy that targets a test employee while excluding an administrator to prevent accidental account lockout.

For this lab, Dylan Almendarez was included in the policy, while Talon Russell was explicitly excluded.

## Objectives

- Create a Conditional Access policy in Microsoft Entra ID.
- Configure user assignments for the policy.
- Include Dylan Almendarez as the test employee.
- Exclude Talon Russell from the policy.
- Configure MFA as an access requirement.
- Enable Report-only mode to safely evaluate the policy.
- Review Conditional Access evaluation results.
- Understand how Conditional Access supports least-privilege security.

## Technologies Used

- Microsoft Entra ID
- Microsoft Entra Conditional Access
- Multifactor Authentication (MFA)
- Microsoft Entra Sign-in Logs
- Conditional Access What If Tool

---

## Implementation

### Step 1 — Create the Conditional Access Test Group

I navigated to Entra ID > Groups > All groups and created a security group named SG-CA-MFA-TEST.

The purpose of this group was to organize employees who would be included in Conditional Access testing.

I used an assigned membership type to control which employees were included in the test group.

![Conditional Access Test Group](screenshots/01-ca-test-group.png)

### Step 2 — Create the Conditional Access Policy

I navigated to Entra ID > Conditional Access > Policies and created a new policy named CA-Require-MFA-Test-Users.

I configured the policy to include Dylan Almendarez and explicitly exclude Talon Russell.

Excluding the administrator helped reduce the risk of accidentally locking myself out of the tenant while testing.

![Conditional Access User Assignments](screenshots/02-ca-policy-users.png)

### Step 3 — Configure MFA Requirements

Under Target resources, I selected All resources to apply the policy to supported cloud resources.

Under Access controls, I configured the Grant settings to require multifactor authentication.

This configuration was intended to require additional identity verification for users included in the policy.

![MFA Grant Controls](screenshots/03-ca-mfa-grant.png)

### Step 4 — Enable Report-only Mode

Before saving the policy, I set Enable policy to Report-only.

Report-only mode allows the policy to be evaluated during sign-ins without enforcing its MFA requirement.

This helped me safely test the policy configuration before enabling enforcement.

![Report-only Policy](screenshots/04-ca-report-only.png)

### Step 5 — Evaluate Conditional Access

I used the Conditional Access testing process to review how the policy would apply to the included and excluded users.

Dylan Almendarez was selected as the included test employee, while Talon Russell was excluded.

The purpose of this test was to verify that the policy targeted the correct user without affecting the administrator account.

![Included User Evaluation](screenshots/05-ca-what-if-included.png)

![Excluded User Evaluation](screenshots/06-ca-what-if-excluded.png)

### Step 6 — Review Sign-in Logs

I navigated to Entra ID > Monitoring & health > Sign-in logs to review authentication activity.

I attempted to locate the test user's sign-in and inspect the Conditional Access evaluation results.

At the time of documentation, the expected sign-in event was not visible in the logs, so I could not confirm the policy evaluation through sign-in evidence.

The policy remained in Report-only mode.

---

## Validation Results

| Test | Expected Result | Actual Result |
|---|---|---|
| Create Conditional Access test group | Group created successfully | Passed |
| Create Conditional Access policy | Policy created successfully | Passed |
| Include Dylan Almendarez | User included in policy scope | Passed |
| Exclude Talon Russell | Administrator excluded | Passed |
| Configure MFA requirement | MFA grant control configured | Passed |
| Enable Report-only mode | Policy saved in Report-only | Passed |
| Verify What If evaluation | Correct policy applicability | Passed |
| Review sign-in logs | Policy evaluation recorded | Passed |

## Security Concepts Demonstrated

### Conditional Access

Conditional Access allows organizations to control access based on conditions such as user identity, device state, location, and application.

### Multifactor Authentication (MFA)

MFA adds another layer of identity verification beyond a password, reducing the risk of unauthorized account access.

### Least Privilege

The policy was scoped to a test employee rather than being applied to every user in the tenant.

### Administrative Account Protection

An administrator account was explicitly excluded to reduce the risk of accidental lockout during testing.

### Report-only Testing

Report-only mode allowed the Conditional Access policy to be evaluated without enforcing the configured MFA requirement.

---

## Lessons Learned

This lab helped me understand how Conditional Access policies are configured and managed in Microsoft Entra ID.

I learned how to scope policies to specific users, exclude administrative accounts, and configure MFA requirements.

I also learned the importance of using Report-only mode before enforcing security policies.

One of the main things I learned was that Conditional Access policies should be tested carefully because incorrect configurations can prevent users and administrators from accessing company resources.

## Conclusion

This lab demonstrated how Copper Creek can use Microsoft Entra Conditional Access to improve identity security.

By creating a scoped MFA policy, configuring user exclusions, and using Report-only mode, I gained hands-on experience with identity-based access controls.

This project helped me better understand how IAM administrators can implement and evaluate authentication policies while minimizing the risk of disrupting user access.

The policy was configured in Report-only mode, and enforcement was not enabled.
