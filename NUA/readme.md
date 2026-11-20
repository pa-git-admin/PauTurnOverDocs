
# Table of Contents
- [For Status NA in NUA](#for-status-na-in-nua)
- [Updating the approver](#updating-the-approver)

## For Status NA in NUA
Identify which system shows NA from the Users account
then Look server asscociated to the server and look into this table `[FPTI].[User]`
search for the name of the user. 
If not found.

 * Review script `[SPDITS016].PA_NOAH_ACCESSCREATION.[NOAH].[NSP_ACCOUNT_CREATION_COMMIT]`
defined the details of the user according to the SP parameters.

 ## Updating the approver
 Scenario if the approver is on leave or absent & urgent.
 update the approver of the requestor.

 ```
 SELECT		*
 FROM		[dbo].[CompanyUserItemRequestHdr]
 WHERE		requested_by = 'P12042'
			AND approver2_by = 'P11310'

RETURN

/*
UPDATE		[dbo].[CompanyUserItemRequestHdr]
SET			approver2_by = 'P11310' --NEW APPROVER
WHERE		requested_by = 'P12042'
			AND approver2_by = 'P11310'
*/
 ```
