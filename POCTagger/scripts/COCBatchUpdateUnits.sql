-- SQL Server 2012
-- Run this script and subsequent queries in the same connection.
DECLARE @SYSTEM VARCHAR(80) = <INPUT SYSTEM>
DECLARE @PhaseCode VARCHAR(80) = <INPUT PHASE CODE>

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

/*Ask for Gemini or ChatGTP to extract the Excel file to SQL script*/
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
    ('IDSJDM', '022', '0021', 'YAMA', 'END', CONVERT(date, '20260521', 112), CONVERT(date, '20260605', 112)),
    ('IDSJDM', '022', '0028', 'YAMA', 'INNER', CONVERT(date, '20260319', 112), CONVERT(date, '20260331', 112)),
    ('IDSJDM', '022', '0038', 'YAMA', 'INNER', CONVERT(date, '20260827', 112), CONVERT(date, '20261013', 112)),
    ('IDSJDM', '022', '0039', 'YAMA', 'INNER', CONVERT(date, '20260611', 112), CONVERT(date, '20260619', 112)),
    ('IDSJDM', '022', '0040', 'YAMA', 'INNER', CONVERT(date, '20260827', 112), CONVERT(date, '20261013', 112)),
    ('IDSJDM', '022', '0041', 'YAMA', 'INNER', CONVERT(date, '20260811', 112), CONVERT(date, '20260619', 112)),
    ('IDSJDM', '022', '0043', 'YAMA', 'INNER', CONVERT(date, '20260611', 112), CONVERT(date, '20260619', 112)),
    ('IDSJDM', '014', '0007', 'SORA', 'IRREGULAR', CONVERT(date, '20260706', 112), CONVERT(date, '20260902', 112)),
    ('IDSJDM', '015', '0004', 'SORA', 'REGULAR', CONVERT(date, '20260903', 112), CONVERT(date, '20261021', 112)),
    ('IDSJDM', '015', '0006', 'SORA', 'REGULAR', CONVERT(date, '20260903', 112), CONVERT(date, '20261021', 112)),
    ('IDSJDM', '015', '0008', 'SORA', 'REGULAR', CONVERT(date, '20261028', 112), CONVERT(date, '20261026', 112)),
    ('IDSJDM', '015', '0010', 'SORA', 'REGULAR', CONVERT(date, '20261016', 112), CONVERT(date, '20261026', 112)),
    ('IDSJDM', '015', '0018', 'SORA', 'REGULAR', CONVERT(date, '20261014', 112), CONVERT(date, '20260605', 112)),
    ('IDSJDM', '018', '0002', 'YAMA', 'END', CONVERT(date, '20261016', 112), CONVERT(date, '20261029', 112)),
    ('IDSJDM', '018', '0004', 'YAMA', 'INNER', CONVERT(date, '20261030', 112), CONVERT(date, '20261029', 112)),
    ('IDSJDM', '018', '0006', 'YAMA', 'INNER', CONVERT(date, '20261030', 112), CONVERT(date, '20261029', 112)),
    ('IDSJDM', '018', '0008', 'YAMA', 'INNER', CONVERT(date, '20261030', 112), CONVERT(date, '20261029', 112)),
    ('IDSJDM', '018', '0010', 'YAMA', 'INNER', CONVERT(date, '20261016', 112), CONVERT(date, '20261029', 112)),
    ('IDSJDM', '018', '0012', 'YAMA', 'END', CONVERT(date, '20261030', 112), CONVERT(date, '20261029', 112)),
    ('IDSJDM', '019', '0001', 'YAMA', 'END', CONVERT(date, '20261017', 112), CONVERT(date, '20261014', 112)),
    ('IDSJDM', '019', '0002', 'YAMA', 'END', CONVERT(date, '20260806', 112), CONVERT(date, '20260923', 112)),
    ('IDSJDM', '019', '0003', 'YAMA', 'INNER', CONVERT(date, '20260917', 112), CONVERT(date, '20261014', 112)),
    ('IDSJDM', '019', '0004', 'YAMA', 'INNER', CONVERT(date, '20260806', 112), CONVERT(date, '20260923', 112)),
    ('IDSJDM', '019', '0005', 'YAMA', 'INNER', CONVERT(date, '20260917', 112), CONVERT(date, '20261014', 112)),
    ('IDSJDM', '019', '0006', 'YAMA', 'INNER', CONVERT(date, '20260806', 112), CONVERT(date, '20260923', 112)),
    ('IDSJDM', '019', '0007', 'YAMA', 'INNER', CONVERT(date, '20260806', 112), CONVERT(date, '20260923', 112)),
    ('IDSJDM', '019', '0008', 'YAMA', 'INNER', CONVERT(date, '20260806', 112), CONVERT(date, '20260923', 112)),
    ('IDSJDM', '019', '0009', 'YAMA', 'INNER', CONVERT(date, '20260917', 112), CONVERT(date, '20261014', 112)),
    ('IDSJDM', '019', '0013', 'YAMA', 'END', CONVERT(date, '20261030', 112), CONVERT(date, '20261029', 112)),
    ('IDSJDM', '019', '0014', 'YAMA', 'END', CONVERT(date, '20261030', 112), CONVERT(date, '20261029', 112)),
    ('IDSJDM', '019', '0015', 'YAMA', 'INNER', CONVERT(date, '20261030', 112), CONVERT(date, '20261029', 112)),
    ('IDSJDM', '019', '0016', 'YAMA', 'INNER', CONVERT(date, '20261030', 112), CONVERT(date, '20261029', 112)),
    ('IDSJDM', '019', '0017', 'YAMA', 'INNER', CONVERT(date, '20261030', 112), CONVERT(date, '20261029', 112)),
    ('IDSJDM', '019', '0018', 'YAMA', 'INNER', CONVERT(date, '20261030', 112), CONVERT(date, '20261029', 112)),
    ('IDSJDM', '019', '0019', 'YAMA', 'END', CONVERT(date, '20261030', 112), CONVERT(date, '20261029', 112)),
    ('IDSJDM', '019', '0020', 'YAMA', 'END', CONVERT(date, '20261030', 112), CONVERT(date, '20261029', 112)),
    ('IDSJDM', '020', '0002', 'YAMA', 'END', CONVERT(date, '20260528', 112), CONVERT(date, '20260605', 112)),
    ('IDSJDM', '020', '0014', 'YAMA', 'END', CONVERT(date, '20260626', 112), CONVERT(date, '20260625', 112)),
    ('IDSJDM', '020', '0016', 'YAMA', 'INNER', CONVERT(date, '20260626', 112), CONVERT(date, '20260625', 112)),
    ('IDSJDM', '020', '0018', 'YAMA', 'INNER', CONVERT(date, '20260619', 112), CONVERT(date, '20260625', 112)),
    ('IDSJDM', '020', '0020', 'YAMA', 'INNER', CONVERT(date, '20260626', 112), CONVERT(date, '20260625', 112)),
    ('IDSJDM', '020', '0022', 'YAMA', 'INNER', CONVERT(date, '20260611', 112), CONVERT(date, '20260625', 112)),
    ('IDSJDM', '020', '0024', 'YAMA', 'END', CONVERT(date, '20260620', 112), CONVERT(date, '20260625', 112)),
    ('IDSJDM', '020', '0025', 'YAMA', 'END', CONVERT(date, '20260218', 112), CONVERT(date, '20260219', 112)),
    ('IDSJDM', '020', '0027', 'YAMA', 'INNER', CONVERT(date, '20260218', 112), CONVERT(date, '20260219', 112)),
    ('IDSJDM', '020', '0029', 'YAMA', 'INNER', CONVERT(date, '20260218', 112), CONVERT(date, '20260219', 112)),
    ('IDSJDM', '020', '0031', 'YAMA', 'END', CONVERT(date, '20260218', 112), CONVERT(date, '20260219', 112)),
    ('IDSJDM', '020', '0032', 'YAMA', 'INNER', CONVERT(date, '20260613', 112), CONVERT(date, '20260702', 112));


BEGIN /*ALTER TABLE*/
	UPDATE #TMP_JV_PROJECT_MONITORING
		SET
			[SYSTEM] = @SYSTEM
		,	[Project] = @PhaseCode
END

BEGIN /*APPLY UNIT CODE*/
	UPDATE a
		SET
			[UnitCode] = x.[Code]
	FROM #TMP_JV_PROJECT_MONITORING a
 	OUTER APPLY (
					SELECT TOP 1
						[Code]
					FROM  [NOAH DATAWHSE].[dbo].[UnitInventory]
					WHERE 1=1
					AND   [Status]     IN (3,4)
					AND   [SYSTEM]		= a.[SYSTEM]
					AND   [PhaseCode]	= a.[Project]
					AND	  [BlockCode]	= a.[Block]
					AND	  [ItemNo]		= a.[Lot]
					AND	  [ModeDesc]	= a.[Model]
					AND	  [LotTypeDesc] = a.[LotType]
					ORDER BY [DATEUPDATETIME] DESC
				) x
END

BEGIN /*GET THE IDS FOR UPDATING OF COC*/
	;WITH POCLogs AS (
		SELECT
			x.[RN]
		,	x.[ID]
		,	x.[LOG_TYPE]
		,	x.[LOG_DATE]
		,	sub.[ActualCOCDate]
		,	x.[UNIT_CODE] POC_UnitCode
		,	sub.[UnitCode]
		FROM (
			SELECT
				ROW_NUMBER() OVER(PARTITION BY xX.[Unit_Code], xX.[SYSTEM], xX.[LOG_TYPE] ORDER BY xX.[LOG_DATE] DESC) RN
			,	xX.*
			FROM (
					SELECT
						[ID]
					,	[LOG_TYPE]
					,	[LOG_DATE]
					,	[LOG_DATA]
					,	[LOG_USER]
					,RTRIM
					(
						Globals.Text.FN_Extract_Text
						(
							LOG_DATA,
							'UnitCode:',
							'HouseType:',
							1
						)
					)	UNIT_CODE
					,RTRIM
					(
						Globals.Text.FN_Extract_Text
						(
							LOG_DATA,
							'System:',
							'UnitCode:',
							1
						)
					)	SYSTEM
					from  [dbo].[APPLICATION_LOGS]
					WHERE [LOG_TYPE] = 'POC Tagger Approval'
				 ) xX
		) x
		JOIN #TMP_JV_PROJECT_MONITORING sub
		ON x.[UNIT_CODE] = sub.[UnitCode]
		AND x.[SYSTEM] = sub.[SYSTEM]
		WHERE x.RN = 1
	)


	UPDATE main
		SET
			main.[LOG_DATE] = copy.[LOG_DATE]
		,	main.[POC_APPLOG_ID] = copy.[ID]
	FROM #TMP_JV_PROJECT_MONITORING main
	JOIN POCLogs copy
	ON main.[UnitCode] = copy.[POC_UNITCode]

END

BEGIN TRANSACTION
	UPDATE main
		SET main.[LOG_DATE] = CONVERT(
		DATETIME2(7),
		CONVERT(CHAR(10), sub.[ActualCOCDate], 23) + 'T'
			+ CONVERT(VARCHAR(16), CAST(main.[LOG_DATE] AS TIME(7))),
		126
	)
	FROM [dbo].[APPLICATION_LOGS] main
	JOIN #TMP_JV_PROJECT_MONITORING sub
	ON main.[ID] = sub.[POC_APPLOG_ID]

	SELECT
		main.*
	,	sub.[UnitCode]
	,	sub.[ActualCOCDate]
	,	sub.[LOG_DATE]
	FROM [dbo].[APPLICATION_LOGS] main
	JOIN #TMP_JV_PROJECT_MONITORING sub
	ON main.[ID] = sub.[POC_APPLOG_ID]

ROLLBACK TRANSACTION
