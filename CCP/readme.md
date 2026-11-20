# Common Issues
## Table of Contents
- [Supplier cant find the tag billing](#supplier-cant-find-the-tag-billing)
- [Contractor cant save the progress billing](#contractor-cant-save-the-progress-billing)
- [Document for review not found](#document-for-review-not-found)
---

## Supplier cant find the tag billing
1. If the Contractor can't find the tag billing from **Billgress HouseAccomplishment**.
* Request the contractor to Click add new Billing + button.

## Contractor cant save the progress billing
If contractor encounter this kind of issue. 
![ContractorFailedToSave](./assets/ContractFailedToSave.png)
* if the user not using Google Chrome. Kindly request them to use Chrome for saving.

## Document for review not found.
After the contractor uploads the document. PIC checks it but unable to see it.
Check in this table `SELECT * FROM [COST_CONSTRUCTION].[CCM].[Contractor_Billing] WHERE [PURCHS_NO] LIKE '%1386%'`
* The Current Mock Status must be _Uploaded for PO_.
#### Request a copy of the PO DOCUMENT in a pdf format.
* Go to data dump and upload the PO document

Then check if it will apear at Document For Review Module.
