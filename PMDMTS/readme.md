# Common Issues
---
## Table of Contents
- [Debugging](#debugging)
  - [Trace issues in OutSystems](#trace-issues-in-outsystems)
- [Granting Access](#granting-access)
  - [LDAP](#ldap)
  - [Module Access](#module-access)
- [Unit Acceptance](#unit-acceptance)
  - [Unit not appearing for unit acceptance](#unit-not-appearing-for-unit-acceptance)
  - [Incomplete unit checklist](#incomplete-unit-checklist)
  - [Update COA date](#update-coa-date)
  - [Buyer details are out of date](#buyer-details-are-out-of-date)
- [PMD Accepted Units](#pmd-accepted-units)
  - [For Regular MoveIn](#for-regular-movein)
    - [Unit not appearing for Regular MoveIn](#unit-not-appearing-for-regular-movein)
  - [For Early MoveIn](#for-early-movein)
    - [Unit is expected to qualify for Early MoveIn](#unit-is-expected-to-qualify-for-early-movein)
  - [NQ-For Early MoveIn](#nq-for-early-movein)
    - [Cannot return the unit to Qualified for Turnover](#cannot-return-the-unit-to-qualified-for-turnover)

---

# Debugging
## Trace issues in OutSystems
Use this procedure to investigate new issues or review a module's conditions.
1. Download OutSystems to your local machine.
2. Install OutSystems.
3. Ask Sir Emil for a copy of the `.OML` file.

### Example of tracing in OutSystems
![Outsystem Trace Video](./assets/Trace_Outsystem.mp4)

* Find the module you want to trace in OutSystems. The menu item names match the filenames.


# Granting access

## LDAP

Go to the LDAP website and click **Add New Role**. Search for the user, select the system, and set the role to _User_. Ask the user to log out and log back in.

## Module Access

Follow these steps to grant a user access to a module.

1. Find the employee's ID in `[HRISV2].[Employee].[GeneralInfo]`

- `SELECT [ID] FROM [HRISV2].[Employee].[GeneralInfo] where [SURNAME] = 'Dela Cruz'`

2. Copy the ID.
3. Review and run the following script.

```
INSERT INTO [PMDMTS].[Setup_User_Management] ([USER_ID], [MENU_SUB_ITEM_ID], [IS_APPROVER_1], [IS_APPROVER_2], [IS_ACTIVE])
SELECT
  <PUT THE COPIED EMPLOYEE'S ID>
, [MENU_SUB_ITEM_ID]
, [IS_APPROVER_1]
, [IS_APPROVER_2]
, [IS_ACTIVE]
FROM [PMDMTS].[Setup_User_Management]
WHERE [USER_ID] = 13951 -- COMMON USER TO COPY MODULE SETUP FOR THE REQUESTOR
```

4. Ask the user to log out and log back in.

---

# Unit Acceptance

## Unit not appearing for unit acceptance

#### Use this procedure to display a specific unit for acceptance after checking the following criteria.

Verify that the unit meets the acceptance criteria.

1. Verify that the unit is above 95% completion for PA/JV acceptance.

- Check the status in `[NOAH DATAWHSE].[NOAH].[E0201_CONSTRUCTION_STATUS_REPORT]`

2. Check whether the unit has already been accepted.

- A unit can be accepted only once.

Once the unit meets all the criteria,
find the following lines in the stored procedure `[PMDMTS].[NSP_UNITS_FOR_ACCEPTANCE]`.
![unit-acceptance-script](./assets/unit-acceptance-script.png)

```
WHERE	(csr.[SYSTEM] = ''' + @SYSTEM + ''' )
AND ui.pct >= ''' + @PERCENTAGE + '''
' + @QUERY_2 + '
```

Temporarily comment out those lines. Copy the script below and

specify the units you want to include.

```
WHERE csr.[UnitCode] IN (''<Can be multiple units insertion>'')
```

Run the stored procedure with `EXEC [PMDMTS].[NSP_UNITS_FOR_ACCEPTANCE]`

After running the procedure, check the PMDMTS Unit Acceptance module
to confirm that the unit appears in the list.

#### Restore the original script

## Incomplete unit checklist

Follow these steps if an incomplete checklist prevents unit acceptance.

1. Look up the unit and copy its ID.
   `SELECT [ID] FROM [PMDMTS].[Unit_List] WHERE PHASE = '' AND [BLOCK] = '' AND [LOT] = ''`
2. Query the checklist table.

```
SELECT * FROM [PMDMTS].[CheckListForm] WHERE ID = <ID>
```

3. If the query returns fewer than 78 rows, the checklist is incomplete.
4. Delete the existing checklist with `DELETE [PMDMTS].[CheckListForm] WHERE ID = <ID>`
5. Select the unit again in the PMDMTS Unit Acceptance module and wait for the checklist to load.
6. Ask the user to select every checklist item and save.

## Update COA date

The COA date is the date the unit was accepted. Users may request a correction.

- Find the unit and set `[ACCEPTED_DATE]` to the date the user requested.

```
UPDATE [PMDMTS].[Unit_List]
  SET
    [ACCEPTED_DATE] = <DATE requested by the user>
WHERE ID = <ID>
```

## Buyer details are out of date
If the buyer's name is incorrect or the previous buyer's name still appears, the unit may need to be synced.
* To sync the unit manually, follow the [Unit not appearing for unit acceptance](#unit-not-appearing-for-unit-acceptance) procedure.

---

# PMD Accepted Units

## For Regular MoveIn

### Unit not appearing for Regular MoveIn

Users may request that units appear for Regular MoveIn.

#### Verify that the unit has been accepted and is still unoccupied

To check whether the unit qualifies for Regular MoveIn, run the following query.


```
SELECT      [IS_QUALIFIED], /*value must be 1*/
           [IS_EARLY_MOVEIN], /* value must be 0*/
           [IS_DONE_UNIT_INSPECTION],/*value must be 0*/
           *
FROM       PMDMTS.Unit_List
WHERE      ID = <ID>
```

If the values fail to meet the Regular MoveIn criteria, run the following update.

```
UPDATE [PMDMTS].[Unit_List]
SET
	IS_QUALIFIED = 1,
	IS_EARLY_MOVEIN = 0,
	IS_DONE_UNIT_INSPECTION = 0
WHERE ID = <ID>
```

Ask the user to confirm that the unit now appears for Regular MoveIn.

## For Early MoveIn

### Unit is expected to qualify for Early MoveIn

#### Always ask the user to file a ticket

To verify that the unit is ready for Early MoveIn,
check that each status column matching `[IS_XXXXXXXXXX]` is set to 1.

```
SELECT
	ID
,	UNIT_CODE
,	BLOCK
,	LOT
,	IS_QUALIFIED
,	IS_UNITS_ACCEPTED
,	IS_EARLY_MOVEIN
,	IS_PERCENTAGE_COMPLETION
,	[IS_DOCUMENT_STATUS]
,	[MODEL]
,	[CurrentStatus]
FROM [PMDMTS].[Unit_List]
where [ID] = <ENTER UNIT ID> AND UNIT_STATUS = 'Approved'
```

If all status values are 1, the unit is ready for Early MoveIn.

##### Run this script manually to update the status of the unit for Early MoveIn
```
BEGIN  TRANSACTION 
DECLARE
				@ID								            INT = <INPUT UNIT LIST ID>,
				@Recuser						          VARCHAR(80) = '999999',
				@IS_QUALIFIED				          BIT = 0,
				@IS_UNITS_ACCEPTED				BIT = 0,
				@IS_EARLY_MOVEIN				BIT = 0,
				@CTS_STATUS						VARCHAR(80) = '',
				@IS_PERCENTAGE_COMPLETION		BIT = 0,
				@IS_CLEARED						BIT = 0,
				@IS_COLLECTION_STATUS_QUALIFIED	BIT = 0,
				@IS_DOCUMENT_STATUS				BIT = 0,
				@UNITCODE						VARCHAR(80) = '',
			    @MODEL                          VARCHAR(50) = ''

			 SELECT
				 @IS_QUALIFIED							= ISNULL([IS_QUALIFIED],0)
				,@IS_UNITS_ACCEPTED						= ISNULL([IS_UNITS_ACCEPTED],0)
				,@IS_EARLY_MOVEIN						= ISNULL([IS_EARLY_MOVEIN],0)
				,@CTS_STATUS							= ISNULL([UNIT_STATUS],'')
				,@IS_PERCENTAGE_COMPLETION				= ISNULL([IS_PERCENTAGE_COMPLETION],0)
				,@IS_CLEARED							= ISNULL([IS_CLEARED],0)
				,@IS_COLLECTION_STATUS_QUALIFIED		= ISNULL([IS_COLLECTION_STATUS_QUALIFIED],0)
				,@IS_DOCUMENT_STATUS					= ISNULL([IS_DOCUMENT_STATUS],0)
				,@UNITCODE                              = [UNIT_CODE]
				,@MODEL                                 = [MODEL]
			FROM [PMDMTS].[Unit_List]
			WHERE ID = @ID

IF
(
	@IS_QUALIFIED						                        = 1	AND
	@IS_UNITS_ACCEPTED					                        = 1 AND
	@IS_EARLY_MOVEIN					                        = 1 AND
	IIF(@MODEL='Lot only',1,@IS_PERCENTAGE_COMPLETION)			= 1 AND
	@IS_CLEARED							                        = 1	AND
	--@IS_COLLECTION_STATUS_QUALIFIED     = 1	AND
	@IS_DOCUMENT_STATUS                                         = 1 AND
	1=1
)
BEGIN
print 'attempting to insert movein'
	PRINT 'Q-For Early MoveIn'
	UPDATE [PMDMTS].[Unit_List] SET
			[IS_QUALIFIED] = 1
		, [IS_UNITS_ACCEPTED] = 1
		, [CurrentStatus] = [PMDMTS].[FN_Get_Unit_Current_status](@ID)
		, [IS_MOVE_IN] = 0
		, [IS_PROCESSED_TO_NOAH] = 0
		, [IS_PROCESSED_TO_PMD] = 0
		, [IS_DONE_UNIT_INSPECTION] = 0
		, [ACCEPTED_BY] = @Recuser
	WHERE ID =   @ID


	IF NOT EXISTS (
		SELECT * FROM (SELECT ROW_NUMBER() OVER(order by CREATED_DATE DESC)[RN],* FROM [PMDMTS].[MoveIn] WHERE [UNIT_LIST_ID]=@ID  AND [UNIT_CODE]=@UNITCODE ) X WHERE RN= 1 AND [MOVE_IN_STATUS]='For notification'
	)
	BEGIN
		INSERT INTO [PMDMTS].[MoveIn]
		([UNIT_LIST_ID],[MOVE_IN_STATUS],[CREATED_DATE],[CREATED_BY],[IS_MOVE_IN],[MOVE_IN_DATE],[UNIT_CODE])
		VALUES
		(@ID,'For notification',GETDATE(),@Recuser,1,getdate(),@UNITCODE)
	END
END
ROLLBACK TRANSACTION
```
Commit the transaction once you have verified the result.

## NQ-For Early MoveIn
### Cannot return the unit to Qualified for Turnover
Users may be unable to requalify a unit for Early MoveIn or Regular MoveIn in PMDMTS.
#### Request the user to file a ticket for this kind of request.

Update the status of the affected unit. Follow the [Unit is expected to qualify for Early MoveIn](#unit-is-expected-to-qualify-for-early-movein) procedure to requalify the unit.
