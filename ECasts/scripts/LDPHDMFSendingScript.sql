DECLARE @DATE DATE = GETDATE()
DECLARE @DATE_TEXT VARCHAR(20) = CONVERT(VARCHAR(20), @DATE, 107) -- e.g. Sep 22, 2026

-- =============================================
-- TEMPLATE 1: ACCOUNT_STAGE = 'NOLA Signing'
-- =============================================
DECLARE @DOC_NOLA_TEMPLATE_SMS NVARCHAR(MAX) = N'Hi Mr./Ms. {{Surname}}, this is P.A. Properties. You are required to sign your Pag-IBIG documents and Notice of Loan Approval (NOLA). If married or with co-borrower, they must sign too. Please bring your latest proof of income: 1-month payslip (same employer) or company ID, 1-month payslip, and original Certificate of Employment and Compensation (COEC) (if new employer).
Thank you.'

DECLARE @DOC_NOLA_TEMPLATE_EMAIL NVARCHAR(MAX) = N'<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>NOLA Signing</title>
</head>
<body style="margin:0; padding:0; background-color:#eef0f2; font-family:Arial, Helvetica, sans-serif;">
<div style="display:none; max-height:0; overflow:hidden; mso-hide:all;">You are required to sign your Pag-IBIG documents and Notice of Loan Approval (NOLA).</div>
<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background-color:#eef0f2; padding:24px 0;">
<tr>
<td align="center">
    <table role="presentation" width="600" cellpadding="0" cellspacing="0" style="background-color:#ffffff; border-radius:6px; overflow:hidden; border:1px solid #dde1e6;">
    <tr>
        <td style="background-color:#035658; padding:24px 32px;">
        <table role="presentation" width="100%" cellpadding="0" cellspacing="0">
            <tr>
            <td style="color:#ffffff; font-size:20px; font-weight:bold; font-family:Arial, Helvetica, sans-serif;">P.A. Properties</td>
            <td align="right" style="color:#c9d6e3; font-size:12px; font-family:Arial, Helvetica, sans-serif;">LPD</td>
            </tr>
        </table>
        </td>
    </tr>
    <tr>
        <td style="padding:32px; color:#26333f; font-size:14px; line-height:1.6;">
         <p style="margin:0 0 16px 0;">Hi Mr./Ms. {{Surname}},</p>
		<p style="margin:0 0 16px 0;">This is P.A. Properties.</p>
        <p style="margin:0 0 16px 0;">You are required to sign your Pag-IBIG documents and Notice of Loan Approval (NOLA). If married or with co-borrower, they must sign too.</p>
        <p style="margin:0 0 16px 0;">Please bring your latest proof of income: 1-month payslip (same employer) or company ID, 1-month payslip, and original Certificate of Employment and Compensation (COEC) (if new employer).</p>
        <p style="margin:0 0 2px 0;">Thank you.</p>
        </td>
    </tr>
    <tr>
        <td style="background-color:#f5f7f9; padding:16px 32px; font-size:11px; color:#8a94a0; text-align:center;">
        This is a system-generated notice from P.A. Properties &ndash; Conversion Department. Please do not disregard this email.
        </td>
    </tr>
    </table>
</td>
</tr>
</table>
</body>
</html>
';

-- =============================================
-- TEMPLATE 2: ACCOUNT_STAGE = 'HDMF Awaiting Take-out'
-- =============================================
DECLARE @DOC_HDMF_AWAITING_TEMPLATE_SMS NVARCHAR(MAX) = N'Hi Mr./Ms. {{Surname}}, this is P.A. Properties. Your housing loan has been submitted to Pag-IBIG Fund. They will conduct validation and a credit investigation with your employer. Kindly inform your HR or employer about this activity. Thank you.'

DECLARE @DOC_HDMF_AWAITING_TEMPLATE_EMAIL NVARCHAR(MAX) = N'<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HDMF Awaiting Take-out</title>
</head>
<body style="margin:0; padding:0; background-color:#eef0f2; font-family:Arial, Helvetica, sans-serif;">
<div style="display:none; max-height:0; overflow:hidden; mso-hide:all;">Your housing loan has been submitted to Pag-IBIG Fund for validation and credit investigation.</div>
<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background-color:#eef0f2; padding:24px 0;">
<tr>
<td align="center">
    <table role="presentation" width="600" cellpadding="0" cellspacing="0" style="background-color:#ffffff; border-radius:6px; overflow:hidden; border:1px solid #dde1e6;">
    <tr>
        <td style="background-color:#035658; padding:24px 32px;">
        <table role="presentation" width="100%" cellpadding="0" cellspacing="0">
            <tr>
            <td style="color:#ffffff; font-size:20px; font-weight:bold; font-family:Arial, Helvetica, sans-serif;">P.A. Properties</td>
            <td align="right" style="color:#c9d6e3; font-size:12px; font-family:Arial, Helvetica, sans-serif;">LPD</td>
            </tr>
        </table>
        </td>
    </tr>
    <tr>
        <td style="padding:32px; color:#26333f; font-size:14px; line-height:1.6;">
        <p style="margin:0 0 16px 0;">Hi Mr./Ms. {{Surname}},</p>
		<p style="margin:0 0 16px 0;">This is P.A. Properties.</p>
        <p style="margin:0 0 16px 0;">Your housing loan has been submitted to Pag-IBIG Fund. They will conduct validation and a credit investigation with your employer.</p>
        <p style="margin:0 0 16px 0;">Kindly inform your HR or employer about this activity.</p>
        <p style="margin:0 0 2px 0;">Thank you.</p>
        </td>
    </tr>
    <tr>
        <td style="background-color:#f5f7f9; padding:16px 32px; font-size:11px; color:#8a94a0; text-align:center;">
        This is a system-generated notice from P.A. Properties &ndash; Conversion Department. Please do not disregard this email.
        </td>
    </tr>
    </table>
</td>
</tr>
</table>
</body>
</html>
';

-- =============================================
-- TEMPLATE 3: ACCOUNT_STAGE = 'Returned Folder from HDMF'
-- =============================================
DECLARE @DOC_RETURNED_FOLDER_TEMPLATE_SMS NVARCHAR(MAX) = N'Hi Mr./Ms. {{Surname}}, this is P.A. Properties. Your Pag-IBIG housing loan is temporarily on hold due to a Notice of Deficiency: {{Findings}}. Please address this immediately so we can proceed. Thank you.'

DECLARE @DOC_RETURNED_FOLDER_TEMPLATE_EMAIL NVARCHAR(MAX) = N'<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Returned Folder from HDMF</title>
</head>
<body style="margin:0; padding:0; background-color:#eef0f2; font-family:Arial, Helvetica, sans-serif;">
<div style="display:none; max-height:0; overflow:hidden; mso-hide:all;">Your Pag-IBIG housing loan is temporarily on hold due to a Notice of Deficiency.</div>
<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background-color:#eef0f2; padding:24px 0;">
<tr>
<td align="center">
    <table role="presentation" width="600" cellpadding="0" cellspacing="0" style="background-color:#ffffff; border-radius:6px; overflow:hidden; border:1px solid #dde1e6;">
    <tr>
        <td style="background-color:#035658; padding:24px 32px;">
        <table role="presentation" width="100%" cellpadding="0" cellspacing="0">
            <tr>
            <td style="color:#ffffff; font-size:20px; font-weight:bold; font-family:Arial, Helvetica, sans-serif;">P.A. Properties</td>
            <td align="right" style="color:#c9d6e3; font-size:12px; font-family:Arial, Helvetica, sans-serif;">LPD</td>
            </tr>
        </table>
        </td>
    </tr>
    <tr>
        <td style="padding:32px; color:#26333f; font-size:14px; line-height:1.6;">
        <p style="margin:0 0 16px 0;">Hi Mr./Ms. {{Surname}},</p>
		<p style="margin:0 0 16px 0;">This is P.A. Properties.</p>
        <p style="margin:0 0 16px 0;">Your Pag-IBIG housing loan is temporarily on hold due to a Notice of Deficiency:</p>
        <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="margin:0 0 20px 0;">
            <tr>
            <td style="background-color:#f5f7f9; border-left:4px solid #0b2e4f; padding:14px 16px; font-size:14px; color:#26333f;">
                {{Findings}}
            </td>
            </tr>
        </table>
        <p style="margin:0 0 16px 0;">Please address this immediately so we can proceed.</p>
        <p style="margin:0 0 2px 0;">Thank you.</p>
        </td>
    </tr>
    <tr>
        <td style="background-color:#f5f7f9; padding:16px 32px; font-size:11px; color:#8a94a0; text-align:center;">
        This is a system-generated notice from P.A. Properties &ndash; Conversion Department. Please do not disregard this email.
        </td>
    </tr>
    </table>
</td>
</tr>
</table>
</body>
</html>
';

-- =============================================
-- TEMPLATE 4: ACCOUNT_STAGE = 'HDMF take-out'
-- =============================================
DECLARE @DOC_HDMF_TAKEOUT_TEMPLATE_SMS NVARCHAR(MAX) = N'Hi Mr./Ms. {{Surname}}, this is P.A. Properties. Congratulations! Your Pag-Ibig Housing loan was released on {{ReleaseDate}}. Your monthly payment starts on {{StartDate}}. Please fund your account on or before the due date. Thank you for choosing P.A. Properties!'

DECLARE @DOC_HDMF_TAKEOUT_TEMPLATE_EMAIL NVARCHAR(MAX) = N'<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HDMF Take-out</title>
</head>
<body style="margin:0; padding:0; background-color:#eef0f2; font-family:Arial, Helvetica, sans-serif;">
<div style="display:none; max-height:0; overflow:hidden; mso-hide:all;">Congratulations! Your Pag-IBIG Housing loan was released.</div>
<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background-color:#eef0f2; padding:24px 0;">
<tr>
<td align="center">
    <table role="presentation" width="600" cellpadding="0" cellspacing="0" style="background-color:#ffffff; border-radius:6px; overflow:hidden; border:1px solid #dde1e6;">
    <tr>
        <td style="background-color:#035658; padding:24px 32px;">
        <table role="presentation" width="100%" cellpadding="0" cellspacing="0">
            <tr>
            <td style="color:#ffffff; font-size:20px; font-weight:bold; font-family:Arial, Helvetica, sans-serif;">P.A. Properties</td>
            <td align="right" style="color:#c9d6e3; font-size:12px; font-family:Arial, Helvetica, sans-serif;">LPD</td>
            </tr>
        </table>
        </td>
    </tr>
    <tr>
        <td style="padding:32px; color:#26333f; font-size:14px; line-height:1.6;">
        <p style="margin:0 0 16px 0;">Hi Mr./Ms. {{Surname}},</p>
		<p style="margin:0 0 16px 0;">This is P.A. Properties.</p>
        <p style="margin:0 0 16px 0;">Congratulations! Your Pag-Ibig Housing loan was released on <strong>{{ReleaseDate}}</strong>. Your 1st monthly payment starts on <strong>{{ReleaseDate}} </strong>.</p>
        <p style="margin:0 0 16px 0;">Please fund your account on or before the due date.</p>
        <p style="margin:0 0 2px 0;">Thank you for choosing P.A. Properties!</p>
        </td>
    </tr>
    <tr>
        <td style="background-color:#f5f7f9; padding:16px 32px; font-size:11px; color:#8a94a0; text-align:center;">
        This is a system-generated notice from P.A. Properties &ndash; Conversion Department. Please do not disregard this email.
        </td>
    </tr>
    </table>
</td>
</tr>
</table>
</body>
</html>
';

IF OBJECT_ID('tempdb..#TEMP_INITIATIVE_SENDING') IS NOT NULL
DROP TABLE #TEMP_INITIATIVE_SENDING

SELECT
	[ID]
,	[SYSTEM]
,	[CUSTOMER_CODE]
,	[ACCOUNT_NO]
,	[CIN]
,	[RESERVENO]
,	[BUYERS_NAME]
,	[UNIT_CODE]
,	[PHASE]
,	[MOBILE_NO]
,	[EMAIL_ADDRESS]
,	[ACCOUNT_STAGE]
,	[REMARKS]
,	[CREATED_DATE]
,	[TRANSACTION_DATE]
INTO #TEMP_INITIATIVE_SENDING
FROM [ECast].[dbo].[Ecast_Recipient_Initiative]

ALTER TABLE #TEMP_INITIATIVE_SENDING
ADD EMAIL_TEMPLATE NVARCHAR(MAX), SMS_TEMPLATE NVARCHAR(MAX), DOC_TEMPLATE_TYPE VARCHAR(30)

-- =============================================
-- Classify each row by ACCOUNT_STAGE.
-- LTRIM/RTRIM + UPPER guards against stray whitespace/casing in the source data.
-- Rows with any other ACCOUNT_STAGE are left NULL (no template assigned) --
-- tell me if those should map to one of these four templates too.
-- =============================================
UPDATE #TEMP_INITIATIVE_SENDING
SET DOC_TEMPLATE_TYPE =
	CASE
		WHEN UPPER(LTRIM(RTRIM(ISNULL(ACCOUNT_STAGE, '')))) LIKE '%' + 'For NOLA SIGNING' + '%' THEN 'NOLA_SIGNING'
		WHEN UPPER(LTRIM(RTRIM(ISNULL(ACCOUNT_STAGE, '')))) LIKE '%' + 'AWAITING TAKE-OUT' + '%' THEN 'HDMF_AWAITING_TAKEOUT'
		WHEN UPPER(LTRIM(RTRIM(ISNULL(ACCOUNT_STAGE, '')))) LIKE '%' + 'RETURNED FOLDERS FROM HDMF' + '%' THEN 'RETURNED_FOLDER_HDMF'
		WHEN UPPER(LTRIM(RTRIM(ISNULL(ACCOUNT_STAGE, ''))))  LIKE '%' + 'TAKEN OUT - HDMF' + '%' THEN 'HDMF_TAKEOUT'
		ELSE NULL
	END

-- debuging
;WITH TEMPO_SENDING AS (
	SELECT
		*
	FROM (
		SELECT
			*
		,	ROW_NUMBER() OVER(PARTITION BY [DOC_TEMPLATE_TYPE] ORDER BY TRANSACTION_DATE DESC) rn
		FROM #TEMP_INITIATIVE_SENDING
	) X
	WHERE RN = 1
)

DELETE #TEMP_INITIATIVE_SENDING
WHERE ID NOT IN (SELECT [ID] FROM TEMPO_SENDING)

UPDATE #TEMP_INITIATIVE_SENDING
	SET
		[BUYERS_NAME] = 'DELA CRUZ, JOSE PAULO'
	,	[MOBILE_NO] = '09923150118'
	,	[EMAIL_ADDRESS] = 'jmdelacruz@paproperties.com.ph'

-- =============================================
-- Merge each row's data into whichever template it was classified as.
-- {{Surname}}        -> BUYERS_NAME (full name reused; no separate surname column)
-- {{Findings}}        -> REMARKS (Returned Folder from HDMF only)
-- {{ReleaseDate}} / {{StartDate}} -> '' for now (source table has no dedicated release/
--                                      first-payment-due columns; wire these up once available)
-- ISNULL(..., '') guards against a single NULL column blanking the whole template.
-- =============================================

-- NOLA Signing
UPDATE #TEMP_INITIATIVE_SENDING
SET EMAIL_TEMPLATE = REPLACE(@DOC_NOLA_TEMPLATE_EMAIL, N'{{Surname}}', ISNULL(BUYERS_NAME, ''))
,	SMS_TEMPLATE   = REPLACE(@DOC_NOLA_TEMPLATE_SMS,   N'{{Surname}}', ISNULL(BUYERS_NAME, ''))
WHERE DOC_TEMPLATE_TYPE = 'NOLA_SIGNING'

-- HDMF Awaiting Take-out
UPDATE #TEMP_INITIATIVE_SENDING
SET EMAIL_TEMPLATE = REPLACE(@DOC_HDMF_AWAITING_TEMPLATE_EMAIL, N'{{Surname}}', ISNULL(BUYERS_NAME, ''))
,	SMS_TEMPLATE   = REPLACE(@DOC_HDMF_AWAITING_TEMPLATE_SMS,   N'{{Surname}}', ISNULL(BUYERS_NAME, ''))
WHERE DOC_TEMPLATE_TYPE = 'HDMF_AWAITING_TAKEOUT'

-- Returned Folder from HDMF
UPDATE #TEMP_INITIATIVE_SENDING
SET EMAIL_TEMPLATE =
	REPLACE(
	REPLACE(
		@DOC_RETURNED_FOLDER_TEMPLATE_EMAIL,
		N'{{Surname}}',  ISNULL(BUYERS_NAME, '')),
		N'{{Findings}}', ISNULL(REMARKS, ''))
,	SMS_TEMPLATE =
	REPLACE(
	REPLACE(
		@DOC_RETURNED_FOLDER_TEMPLATE_SMS,
		N'{{Surname}}',  ISNULL(BUYERS_NAME, '')),
		N'{{Findings}}', ISNULL(REMARKS, ''))
WHERE DOC_TEMPLATE_TYPE = 'RETURNED_FOLDER_HDMF'

-- HDMF Take-out
UPDATE #TEMP_INITIATIVE_SENDING
SET EMAIL_TEMPLATE =
	REPLACE(
	REPLACE(
	REPLACE(
		@DOC_HDMF_TAKEOUT_TEMPLATE_EMAIL,
		N'{{Surname}}',     ISNULL(BUYERS_NAME, '')),
		N'{{ReleaseDate}}', [REMARKS]),
		N'{{StartDate}}',   [REMARKS])
,	SMS_TEMPLATE =
	REPLACE(
	REPLACE(
	REPLACE(
		@DOC_HDMF_TAKEOUT_TEMPLATE_SMS,
		N'{{Surname}}',     ISNULL(BUYERS_NAME, '')),
		N'{{ReleaseDate}}', [REMARKS]),
		N'{{StartDate}}',   [REMARKS])
WHERE DOC_TEMPLATE_TYPE = 'HDMF_TAKEOUT'

DECLARE @JOBS_ID INT = 44;

--INSERT INTO [ECast].[Email_Queue] (JOBS_ID, MESSAGE, EMAIL_ADDRESS, PROFILE_NAME) /*Uncomment line to trigger sending*/
SELECT
	@JOBS_ID
,	[EMAIL_TEMPLATE]
,	[EMAIL_ADDRESS]
,	'P.A. Properties'
FROM #TEMP_INITIATIVE_SENDING

--INSERT INTO [ECast].[SMS_Queue]
--	(JOBS_ID, MESSAGE, MOBILE_NO, MASK_NAME) /*Uncomment line to trigger SMS sending*/
SELECT
	@JOBS_ID
,	[SMS_TEMPLATE]
,	[MOBILE_NO]
,	'PA Properties'
FROM #TEMP_INITIATIVE_SENDING


SELECT
	*
FROM #TEMP_INITIATIVE_SENDING
