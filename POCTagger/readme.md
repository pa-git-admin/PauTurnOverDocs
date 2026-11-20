
## Table of Contents
- [POC Tagger App](poc-tagger-app)
  - [Unit not appearing in the list](#unit-not-appearing-in-the-list)
  - [0 poc unit not appearing for tagging](0-poc-unit-not-appearing-for-tagging)
  - [Stuck in currently synching](#stuck-in-currently-synching)
  - [COC Batch Update](#coc-batch-update)
  
---

# POC Tagger App
Database location: `[POCTAGGER]`

## Unit not appearing in the list
If a unit does not appear in the POC Tagger selection list, check whether it exists in `[dbo].[UNIT_FOR_APPROVAL]`.
* If the unit exists, check whether its POC has reached 100% in `<SERVER_NAME>.<DATABASE_NAME>.[RE].[POCENTLIN]`.
* If the POC is below 100%, delete the unit from `[dbo].[UNIT_FOR_APPROVAL]`.

## 0 poc unit not appearing for tagging
Unit not appearing check the table `[POC].[Units_For_Tagging]` 
 * if not. Run this script to load all activities associated to the unit.
```
/*Sample only*/
exec  [SPDITS031-A].[NOAH_PAHANKYU02].[RE].[nsp_POCENT_ACTLOAD] 
@UnitCode='DASMAH-012-017-002-001-0016'
,@HouseType='001'
,@LotType='008'
,@POCweighted='LM'
,@QueryType=0
```

* if not. The unit doesn't have a BOM setup yet
* if BOM showing. check if the unit has already CoTime 


## Stuck in currently synching
if the Unit is stuck to currently synching. Delete it
```
SELECT * FROM [dbo].[CONSTRUCTION_STATUS_FOR_NOAH_SYNCH]
WHERE [UnitCode] LIKE '%SJRF-2%'
AND [BLOCK] = '002' AND [LOT] = '0037' // sample only

RETURN
BEGIN TRANSACTION
DELETE [dbo].[CONSTRUCTION_STATUS_FOR_NOAH_SYNCH]
WHERE [UnitCode] LIKE '%SJRF-2%'
AND [BLOCK] = '002' AND [LOT] = '0037'
ROLLBACK TRANSACTION
```

## COC Batch Update

To update the COC dates for multiple units, give the requester the [COC update template](./assets/COCBatchUpdateTemplate.xlsx) and ask them to fill it out.

Ask ChatGPT to transcribe the Excel file and create a SQL script that loads the data into a temporary table.

```
IF OBJECT_ID('tempdb..#TMP_JV_PROJECT_MONITORING') IS NOT NULL
    DROP TABLE #TMP_JV_PROJECT_MONITORING;

CREATE TABLE #TMP_JV_PROJECT_MONITORING (
    [Project]        VARCHAR(20) NOT NULL,
    [Block]          VARCHAR(4)  NOT NULL,
    [Lot]            VARCHAR(4)  NOT NULL,
    [Model]          VARCHAR(20) NOT NULL,
    [LotType]        VARCHAR(20) NOT NULL,
    [CODDateForCore] DATE        NULL,
    [ActualCOCDate]  DATE        NULL,
	[SYSTEM] VARCHAR(120)	NULL,
	[UnitCode] VARCHAR(120)		NULL,
	[LOG_DATE] DATETIME NULL,
	[POC_APPLOG_ID] INT NULL
);

/* Ask Gemini or ChatGPT to convert the Excel data into a SQL script. */
INSERT INTO #TMP_JV_PROJECT_MONITORING (
    [Project], [Block], [Lot], [Model], [LotType],
    [CODDateForCore], [ActualCOCDate]
)
VALUES
    ('IDSJDM', '019', '0007', 'YAMA', 'INNER', CONVERT(date, '20260917', 112), CONVERT(date, '20261014', 112)),
    ('IDSJDM', '022', '0012', 'YAMA', 'END', CONVERT(date, '20260521', 112), CONVERT(date, '20260611', 112)),
    ('IDSJDM', '022', '0013', 'YAMA', 'INNER', CONVERT(date, '20260415', 112), CONVERT(date, '20260416', 112)),
    ('IDSJDM', '022', '0017', 'YAMA', 'INNER', CONVERT(date, '20260415', 112), CONVERT(date, '20260416', 112)),
    ('IDSJDM', '022', '0018', 'YAMA', 'END', CONVERT(date, '20260521', 112), CONVERT(date, '20260611', 112)),
    AND SO ON................

```

Review this script to update the units listed in the Excel file.
* [COC Batch Update Script](./scripts/COCBatchUpdateUnits.sql)
```
-- Run this script and subsequent queries in the same connection.
DECLARE @SYSTEM VARCHAR(80) = 'NOAH_PAHANKYU05'
DECLARE @PhaseCode VARCHAR(80) = '01SJDM'
```
