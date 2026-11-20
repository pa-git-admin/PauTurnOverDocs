/*
=======================================================
* JV Accounts
* Must send to all Updated accounts both Equity (All scheme) and In-house Financed/Balance Portion who will have an upcoming due date.
* Kindly exclude those Cancelled, Taken-out, Full Equity, Fullypaid, Hankyu 1 accounts, and Pastdue accounts.
* Sending must be done 2 weeks before the due date
* Add another column where the notice is
* 2 weeks before due date
* 1 - 60 Days past due
* 60 - 119 Days Past due
* 120 Days greater past due
* Include downpayment type and balance for reminder
=======================================================
*/

TRUNCATE TABLE CNC.[ReminderDueAccounts]


DECLARE @CURRENT_DATE DATE = GETDATE()

-- ========================================================================
-- SYNCH ECAST BUYERS INFORMATION LIST SKIP EXECUTING WHEN ITS ALREADY RUN
-- ========================================================================
IF NOT EXISTS (SELECT 1 FROM ECast.SynchDate_BuyerInformation WHERE CAST(RUN_DATE AS DATE) = CAST(@CURRENT_DATE AS DATE))
BEGIN
	INSERT INTO ECast.SynchDate_BuyerInformation ([SP])
	VALUES
		('[DataSource].[NSP_Jobs_Buyers_Information]')

	PRINT 'RUNNING ECAST INFORMATION SYNCHING'
	EXEC [DataSource].[NSP_Jobs_Buyers_Information]
END

IF OBJECT_ID ('tempdb..#TMP_Accounts') IS NOT NULL
DROP TABLE #TMP_Accounts

-- ==================================================
-- ACCOUNTS
-- ==================================================
SELECT
			[SYSTEM]
		,	[CUSTOMER_CODE]
		,	[ACCOUNT_NO]
		,	[CIN]
		,	[BUYERS_NAME]
		,	[BUYERS_STATUS]
		,	[PAYMENT_SOURCE]
		,	[UNIT_CODE]
		,	[PHASE]
		,	[BLOCK]
		,	[LOT]
		,	[MODEL]
		,	[RESERVATION_DATE]
		,	[COLLECTION_STATUS]
		,	[CTSCRN_NO]
		,	[HLDRES_NO]
INTO		#TMP_Accounts
FROM		[DataSource].[Buyers_Information]
WHERE		1 = 1
AND			[BUYERS_STATUS]	NOT IN ('Cancelled')
--AND			[SYSTEM] NOT IN ('NOAH_PAAPDC', 'NOAH_PAAPVI', 'NOAH_PAMRBI', 'NOAH_PHVECTORONE', 'NOAH_PHVECTORONE_HEIGHTS')
AND			[IS_TAKEN_OUT] = 0
AND			[IS_FULLY_PAID] = 0
AND			([ACCOUNT_NO] <> '' AND [ACCOUNT_NO] IS NOT NULL)
AND			([CIN] IS NOT NULL AND [CIN] <> '')
--AND			[COLLECTION_STATUS] = 'UPDATED'
ORDER BY	[RESERVATION_DATE] DESC

BEGIN /*ALTER TMP TABLE*/
	CREATE NONCLUSTERED INDEX
		IX_TMP_ACCOUNTS
	ON
		#TMP_Accounts ([SYSTEM], [CUSTOMER_CODE], [ACCOUNT_NO], [CIN], [BUYERS_NAME])

	ALTER TABLE
		#TMP_Accounts
	ADD
		[COMPANY_GROUP] VARCHAR(80) NULL
	,	[PERIOD] INT NULL
	,	[TermSubType] VARCHAR(80) NULL
	,	[Baseline] DATE NULL
	,	[AMOUNT] NUMERIC(18,2) NULL
	,	[DaysBeforeDue] INT NULL
	,	[NOTICE] VARCHAR(80) NULL
	,	[SORT] INT NULL
	,	[ACCOUNT_STAGE_CODE] VARCHAR(10) NULL
	,	[ACCOUNT_STAGE]	VARCHAR(120) NULL
	,	[NOUPAIDMOS] INT NULL
	,	[N.NOUPAIDMOS (DAYS)] INT NULL
	,	[COLLECTION_REMARKS] VARCHAR(MAX) NULL
	,	[TOTALPASTDUES] DECIMAL(18, 5) NULL
	,	[TOTALARREARSPRIN] DECIMAL(18, 5) NULL
	,	[DUEDATE] INT NULL
END

DECLARE @SYSTEMS AS TABLE (
	[ID] INT IDENTITY(1,1) PRIMARY KEY
,	[SYSTEM] VARCHAR(80)
,	[SERVER] VARCHAR(80)
,	[DATABASE] VARCHAR(80)
)

-- COLLECT DATABASE SERVERS
INSERT INTO @SYSTEMS ([SYSTEM], [SERVER], [DATABASE])
SELECT
			[SYSTEM]
		,	[SERVER_NAME]
		,	[DATABASE_NAME]
FROM		[GLOBALS].[NOAH].[Company_Mapping]
WHERE		1=1
AND			[SYSTEM]		IN (SELECT DISTINCT [SYSTEM] FROM #TMP_Accounts)
AND			[IS_ACTIVE]		= 1
AND			[IS_LIVE]		= 1

DECLARE @CTR				INT			= 1
DECLARE @LIMIT				INT			= (SELECT Count(*) FROM @SYSTEMS)
DECLARE @SERVER_NAME		VARCHAR(80) = ''
DECLARE @DATABASE_NAME		VARCHAR(80) = ''
DECLARE @QUERY				NVARCHAR(MAX) = ''

WHILE @CTR <= @LIMIT
BEGIN
	SELECT
				@SERVER_NAME = [SERVER]
			,	@DATABASE_NAME = [DATABASE]
	FROM		@SYSTEMS
	WHERE		[ID] = @CTR

	BEGIN /*REMOVE CANCELLED ACCOUNT*/
		SET @QUERY = '
			UPDATE a
				SET
					a.[ACCOUNT_STAGE_CODE] = b.[AccountStage]
				,	a.[ACCOUNT_STAGE]	   = st.[ShortDescription]
			FROM	#TMP_Accounts a
			JOIN	' + @SERVER_NAME + '.' + @DATABASE_NAME + '.WF.CURRENTACCTSTAGESTATUSTABLE b
			ON		a.[UNIT_CODE] = b.[UnitCode]
			AND		a.[HLDRES_NO] = b.[ReservationNo]
			JOIN	' + @SERVER_NAME + '.' + @DATABASE_NAME + '.[WF].[ACCOUNTSTAGES] st
			ON		b.[AccountStage] = st.[Code]
		'
		PRINT @QUERY
		EXECUTE(@QUERY)

		-- ====================================
		-- DELETE CANCELLED ACCOUNTS
		-- ====================================
		DELETE #TMP_Accounts
		WHERE [ACCOUNT_STAGE_CODE] IN (
			'0003', -- TURNED OVER TO ARCHIVE - CANCELLED ACCOUNT
			'0021', --TURNED OVER TO ARCHIVE - CANCELLED ACCOUNT
			'0063' --AC - ACCOUNT CANCELLED
		)
	END

	BEGIN /*GET CURRENT UNPAID DOWNPAYMENT*/

		SET @QUERY = '
			UPDATE main
				SET
					[Period]		= due.[period]
				,	[TermSubType]	= due.[TermSubType]
				,	[Baseline]		= due.[Baseline]
				,	[Amount]		= due.[pmt]
				,	[DaysBeforeDue] = DATEDIFF(DAY, due.[Baseline], ''' + CAST(@CURRENT_DATE AS VARCHAR(80)) + ''')
				,	[Notice]		= ''2 WEEKS BEFORE DUE''
			FROM		#TMP_Accounts main
			OUTER APPLY (
							SELECT
								*
							FROM (
									SELECT
											[pCode]
										,	[UnitCode]
										,	[period]
										,	[TermSubType]
										,	[baseline]
										,	[pmt]
										,	[cleared]
										,	ROW_NUMBER() OVER (PARTITION BY [pCode], [UnitCode] ORDER BY [period], [baseline] asc) rn
									FROM	' + @SERVER_NAME + '.' + @DATABASE_NAME + '.[RE].ContracttoSellEntry_Amortization
									WHERE	[pCode]			= main.[CTSCRN_NO]
									AND		[UnitCode]		= main.[UNIT_CODE]
									AND		[TermSubType]   NOT IN (''Reservation'')
									AND		[cleared]		IS NULL
									AND (
											(
												main.[PAYMENT_SOURCE] IN (''Bank Financing'', ''HDMF Financing'')
												AND [TermSubType] = ''Downpayment''
											)
											OR
											(
												main.[PAYMENT_SOURCE] NOT IN (''Bank Financing'', ''HDMF Financing'')
												OR main.[PAYMENT_SOURCE] IS NULL
											)
									  )

								 ) x
							WHERE rn = 1
						) due
			WHERE		[SYSTEM] = ''' + @DATABASE_NAME + '''
			AND			DATEDIFF(DAY, due.[Baseline], ''' + CAST(@CURRENT_DATE AS VARCHAR(80)) + ''') BETWEEN -14 AND 3
		'
		PRINT @QUERY
		EXECUTE(@QUERY)

	END

	PRINT @DATABASE_NAME

	SET @CTR += 1;
END

BEGIN /*GROUP COMPANY IF PA/JV*/
	UPDATE	main
		SET
			main.[COMPANY_GROUP] = map.[SYSTEM_GROUP]
	FROM	#TMP_Accounts main
	JOIN	[GLOBALS].[NOAH].[COMPANY_MAPPING] map
	ON		main.[SYSTEM]	= map.[SYSTEM]
END

BEGIN /*PAST DUES*/
	UPDATE		a
		SET
				a.[TermSubType]			= x.[PAYCATEGORY]
			,	a.[Baseline]			= x.[Baseline]
			,	a.[AMOUNT]				= x.[TOTALPASTDUE]
			,	a.[NOUPAIDMOS]			= x.[NOUPAIDMOS]
			,	a.[N.NOUPAIDMOS (DAYS)]  = x.[NOUPAIDMOS_DAYS]
			,	a.[COLLECTION_REMARKS]  = x.[CollectionRemarks]
			,	a.[TOTALARREARSPRIN]	= x.[TOTALARREARSPRIN]
			,	a.[TOTALPASTDUES]		= x.[TOTALPASTDUE]
			,	a.[DUEDATE]				= x.[DUEDATE]
	FROM		#TMP_Accounts a
	OUTER APPLY (
					SELECT		TOP 1
								[SYSTEM],
								[NOUPAIDMOS],
								[CollectionRemarks],
								[NOUPAIDMOS_DAYS],
								[TOTALARREARSPRIN],
								[TOTALPASTDUE],
								[N_PROJECT],
								[BUYERACNO],
								[AGE OF PAST DUE_V2],
								[STARTDEFDATE] AS Baseline,
								[PAYCATEGORY],
								[DUEDATE]
					FROM 		DATAWHSE.CNC.ConsoAgingFinal_v10
					WHERE		[SYSTEM]		COLLATE DATABASE_DEFAULT = IIF(a.[COMPANY_GROUP] = 'PA', 'NOAH', a.[SYSTEM]) COLLATE DATABASE_DEFAULT
					AND			[BUYERACNO]		COLLATE DATABASE_DEFAULT = a.[ACCOUNT_NO]									 COLLATE DATABASE_DEFAULT
					ORDER BY	[ID] DESC
				) x
	WHERE		x.[SYSTEM] IS NOT NULL AND x.[NOUPAIDMOS] >= 1
	AND			x.[TOTALPASTDUE] <> 0

END

BEGIN /*DELETE NOT FOUND IN CONSO AGING*/
	DELETE #TMP_ACCOUNTS
	WHERE [TermSubType] IS NULL
	AND [NOUPAIDMOS] IS NULL
END

BEGIN /*COUNT NUMBER OF DAYS BEFORE DUE*/
	UPDATE #TMP_Accounts
		SET
			[DaysBeforeDue] = DATEDIFF(DAY, [Baseline], @CURRENT_DATE);
END

BEGIN /*APPLY WHAT NOTICE OF THE BUYER SHOULD RECEIVE*/
	UPDATE #TMP_Accounts
		SET
			[NOTICE] = (
							CASE
								WHEN [DaysBeforeDue] >= 120 THEN '120 DAYS PAST DUE'
								WHEN [DaysBeforeDue] BETWEEN 60 AND 119 THEN '60 - 119 DAYS PAST DUE'
								WHEN [DaysBeforeDue] BETWEEN 1 AND 59 THEN  '1 - 59 DAYS PAST DUE'
								WHEN [DaysBeforeDue] BETWEEN -14 AND 3 THEN '2 WEEKS BEFORE DUE'
							END
					   )
END

BEGIN /*Apply sorting*/
	UPDATE #TMP_Accounts
		SET
			[SORT] = (
						CASE [NOTICE]
							WHEN '120 DAYS PAST DUE'  THEN 1
							WHEN '60 - 119 DAYS PAST DUE' THEN 2
							WHEN '1 - 59 DAYS PAST DUE'   THEN 3
							ELSE 4
						END
					 )
END

-- ==================================================
-- 6. OUTPUT
-- ==================================================
INSERT INTO CNC.[ReminderDueAccounts] (
	   [SYSTEM]
      ,[CUSTOMER_CODE]
      ,[ACCOUNT_NO]
      ,[CIN]
      ,[BUYERS_NAME]
      ,[BUYERS_STATUS]
      ,[PAYMENT_SOURCE]
      ,[UNIT_CODE]
      ,[PHASE]
      ,[BLOCK]
      ,[LOT]
      ,[MODEL]
      ,[RESERVATION_DATE]
      ,[COLLECTION_STATUS]
      ,[CTSCRN_NO]
      ,[PERIOD]
      ,[TermSubType]
      ,[Baseline]
      ,[AMOUNT]
      ,[DaysBeforeDue]
      ,[NOTICE]
      ,[SORT]
	  ,[ACCOUNT_STAGE_CODE]
	  ,[ACCOUNT_STAGE]
	  ,[RESERVENO]
	  ,[NOUPAIDMOS]
	  ,[N.NOUPAIDMOS (DAYS)]
	  ,[COLLECTION_REMARKS]
	  ,[TOTALPASTDUES]
	  ,[TOTALARREARSPRIN]
)
SELECT
		  -- ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS RN
		   [SYSTEM]
		  ,[CUSTOMER_CODE]
		  ,[ACCOUNT_NO]
		  ,[CIN]
		  ,[BUYERS_NAME]
		  ,[BUYERS_STATUS]
		  ,[PAYMENT_SOURCE]
		  ,[UNIT_CODE]
		  ,[PHASE]
		  ,[BLOCK]
		  ,[LOT]
		  ,[MODEL]
		  ,[RESERVATION_DATE]
		  ,[COLLECTION_STATUS]
		  ,[CTSCRN_NO]
		  ,[PERIOD]
		  ,[TermSubType]
		  ,[Baseline]
		  ,[AMOUNT]
		  ,[DaysBeforeDue]
		  ,[NOTICE]
		  ,[SORT]
		  ,[ACCOUNT_STAGE_CODE]
		  ,[ACCOUNT_STAGE]
		  ,[HLDRES_NO]
		  ,ISNULL([NOUPAIDMOS], 0)
		  ,ISNULL([N.NOUPAIDMOS (DAYS)], 0)
		  ,ISNULL([COLLECTION_REMARKS], 0)
		  ,ISNULL([TOTALPASTDUES], 0)
		  ,ISNULL([TOTALPASTDUES], 0)
FROM        #TMP_Accounts
--WHERE		[NOTICE] IS NOT NULL
ORDER BY    [SORT] ASC

-- creat tables
DROP TABLE #TMP_Accounts
