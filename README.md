
### Assignment Description: 

You are working for a fictitious company called "XYZ Corp." This company has implemented an Accounts and Contacts management system for their customers. These Accounts and contacts are coming from Oracle ERP via integration in Salesforce Production. The company wants to keep their Accounts and Contacts neat and clean in Salesforce especially emails addresses. The company wants to implement following changes:   

**Solutions are bulleted.**

- If accounts and contacts are coming from Integration and if emails contain ‘. invalid’ at end of email address, then system should remove ‘.invalid‘ from Account and Contact emails and store in salesforce.  
	- Removing the '.invalid' from the Integration contact emails is handled with the flow `Contact - Remove invalid postfix from email`.  
- If Accounts and Contacts are created from Salesforce UI, then the system should not allow them to enter email address with ‘. invalid’ post fix.  
	- To keep data clean this should be enforced for all users, the validation rule `Do_not_allow_invalid_email_postfix` will prevent all users except System Administrators from entering an email with the '.invalid' postfix.
	- Additionally, if desired the `Contact - Remove invalid postfix from email` flow could be changed to automatically remove '.invalid' from emails entered through the UI
- Mask all the account and contact emails postfix with ‘. invalid’ post sandbox refresh. 
	- The Apex class 'SandboxRefreshAddInvalidEmail' should be added to the Sandbox Template to add '.invalid' to all Contact Emails in the sandbox.
- Please make Email field required on Contacts for internal sales reps. 
	- To keep data clean this should be enforced for all users, the validation rule `Require_Email_for_UI_users` will prevent all users except System Administrators from entering or updating a Contact without an email.
	- Additionally, the email field should be set to required on all page layouts and lightning pages. 
		- In this org the following layouts were updated:
		- Contact (Marketing) Layout
		- Contact (Sales) Layout
		- Contact (Support) Layout
		- Contact Layout
- If email address is blank for existing contacts, populate email fields with contact owner’s email address. This should be a one-time task performed on all the contacts. 
	- The flow `Update empty contact email to contact owner email` is a scheduled flow to run once to update all Contacts with an empty email to the Contact Owner's email. 

### Design

As discussed in the interview, the design philosophy should be declarative first, then apex when necessary. Additionally, Accounts do not have Email addresses, those are on the contact records associated with the Account. All updates will be on Contact records. 


#### Flows
- `Contact - Remove invalid postfix from email` 
	- Record Triggered flow, before save.
	- Checks if the email contains '.invalid' and if the user has the profile 'Salesforce API Only System Integrations'
	- If the entry conditions are met, .invalid is removed from the Email address of the contact. 
- `Update empty contact email to contact owner email`
	- Scheduled Flow, new version must be created to set a future scheduled date.
	- Checks if the Contact email is blank, if blank it updates it to the Contact Owner's email. 

#### Apex
- `AddInvalidToContactEmail` 
	- Gets all contacts that have an email and the email does not already contain '.invalid'
	- Adds '.invalid' to all the emails.
- `SandboxRefreshAddInvalidEmail` 
	- Calls the `AddInvalidToContactEmail` class to update emails, this class is added to the Sandbox Template during refresh. 
#### Custom Settings
- there is a Custom Setting `Sandbox__c` that is used in sandboxes to disable validation rules. This Custom Setting record is created when the `SandboxRefreshAddInvalidEmail` class is executed.

#### Validation Rules
- `Do_not_allow_invalid_email_postfix`
	- Does not allow the '.invalid' postfix to be entered by any user except System Administrators.
- `Require_Email_for_UI_users` 
	- Requires all users except System Administrator and Salesforce API Only System Integrations to enter an Email for a contact. 


### Installation URL
https://login.salesforce.com/packaging/installPackage.apexp?p0=04tHs000000cyG0

#### Post Install Actions
- Add SandboxRefreshAddInvalidEmail to the sandbox template. 
- Update the Email field on all Contacts page layouts to be required. 
