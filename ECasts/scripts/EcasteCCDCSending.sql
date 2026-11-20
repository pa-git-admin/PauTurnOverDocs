-- ===============================================================
-- CCDC - SEASONED - FOR COMPLETION OF DOCUMENTS
-- ===============================================================
DECLARE @EMAIL_TEMPLATE_SEASONED NVARCHAR(MAX) = N'<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Title Conversion – Status Update</title>
</head>
<body style="margin:0; padding:0; background-color:#eef0f2; font-family:Arial, Helvetica, sans-serif;">

<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background-color:#eef0f2; padding:24px 0;">
  <tr>
    <td align="center">
      <table role="presentation" width="600" cellpadding="0" cellspacing="0" style="background-color:#ffffff; border-radius:6px; overflow:hidden; border:1px solid #dde1e6;">

        <!-- Header / Letterhead -->
        <tr>
          <td style="background-color:#035658; padding:24px 32px;">
            <table role="presentation" width="100%" cellpadding="0" cellspacing="0">
              <tr>
                <td style="color:#ffffff; font-size:20px; font-weight:bold; font-family:Arial, Helvetica, sans-serif;">
                  P.A. Properties
                </td>
                <td align="right" style="color:#c9d6e3; font-size:12px; font-family:Arial, Helvetica, sans-serif;">
                  Central Customer Documentation Control
                </td>
              </tr>
            </table>
          </td>
        </tr>

        <!-- Body -->
        <tr>
          <td style="padding:32px; color:#26333f; font-size:14px; line-height:1.6;">

            <p style="margin:0 0 16px 0;">
              Good day!
            </p>

			<p style="margin:0 0 16px 0;">
              Greetings from <b>P.A. Properties / P.A. Properties Hankyu Hanshin. </b>
            </p>

            <p style="margin:0 0 16px 0;">
             We are currently updating your checklist of requirements for your
			 <b>Pag-IBIG or Bank Housing Loan Application.</b> In this regard, may we kindly request your <b>active Facebook Messenger</b> account and updated <b>email address</b>
			 so we can send you the complete checklist and further instructions.
            </p>

            <p style="margin:0 0 16px 0;">
              You may send your details through any of the following official Messenger accounts:
            </p>

			 <ul>
				<li>PA Hankyu CCDC Dept</li>
				<li>PA Properties CCDC Dept</li>
			 </ul>

            <p style="margin:0 0 24px 0;">
              For any questions or concerns, you may also contact us through:
            </p>

			<ul>
				<li>(02) 8553-3000 local 132 or 315 </li>
				<li>0908-866-7718 </li>
				<li>0998-583-5962</li>
				<li>0908-865-1832 </li>
				<li>0928-525-0474 </li>
			</ul>

			<p style="margin:0 0 16px 0;">
              We appreciate your prompt attention and cooperation.
            </p>

			<p style="margin:0 0 16px 0;">
              Thank you and we look forward to assisting you
            </p>

			<p style="margin:0 0 16px 0;">Central Customer Documentation Control </p>
			<p style="margin:0 0 16px 0;">P.A. Alvarez Group of Companies  </p>


          </td>
        </tr>

        <!-- Footer -->
        <tr>
          <td style="background-color:#f5f7f9; padding:16px 32px; font-size:11px; color:#8a94a0; text-align:center;">
            This is a system-generated notice from P.A. Properties &ndash; Central Customer Documentation Control Department. Please do not disregard this email.
          </td>
        </tr>

      </table>
    </td>
  </tr>
</table>

</body>
</html>
';

DECLARE @SMS_TEMPLATE_SEASONED NVARCHAR(MAX) = N'
Good day!
Greetings from P.A. Properties / P.A. Properties Hankyu Hanshin.
We are currently updating your checklist of requirements for your Pag-IBIG or Bank Housing Loan Application. In this regard, may we kindly request your active Facebook Messenger account and updated email address so we can send you the complete checklist and further instructions.

You may send your details through any of the following official Messenger accounts:
-PA Hankyu CCDC Dept
-PA Properties Ccdc Dept


For any questions or concerns, you may also contact us through:
-(02) 8553-3000 local 307 or 315
-0908-866-7718
-0998-583-5962
-0908-865-1832
-0928-525-0474


We appreciate your prompt attention and cooperation.
Thank you and we look forward to assisting you.
'

-- ==================================================================
-- TURNED OVER TO LD - BANK
-- ==================================================================

DECLARE @EMAIL_TEMPLATE_TURNEDOVER_TO_LDP_BANK NVARCHAR(MAX) = N'<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Title Conversion – Status Update</title>
</head>
<body style="margin:0; padding:0; background-color:#eef0f2; font-family:Arial, Helvetica, sans-serif;">

<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background-color:#eef0f2; padding:24px 0;">
  <tr>
    <td align="center">
      <table role="presentation" width="600" cellpadding="0" cellspacing="0" style="background-color:#ffffff; border-radius:6px; overflow:hidden; border:1px solid #dde1e6;">

        <!-- Header / Letterhead -->
        <tr>
          <td style="background-color:#035658; padding:24px 32px;">
            <table role="presentation" width="100%" cellpadding="0" cellspacing="0">
              <tr>
                <td style="color:#ffffff; font-size:20px; font-weight:bold; font-family:Arial, Helvetica, sans-serif;">
                  P.A. Properties
                </td>
                <td align="right" style="color:#c9d6e3; font-size:12px; font-family:Arial, Helvetica, sans-serif;">
                  Central Customer Documentation Control
                </td>
              </tr>
            </table>
          </td>
        </tr>

        <!-- Body -->
        <tr>
          <td style="padding:32px; color:#26333f; font-size:14px; line-height:1.6;">

            <p style="margin:0 0 16px 0;">
              <b>Dear Mr./Ms. {{BUYERS_NAME}}</b>
            </p>

            <p style="margin:0 0 16px 0;">
             We’re pleased to inform you that we have completed the first step of your <b>Bank housing loan documentation.</b>
            </p>

			<p style="margin:0 0 16px 0;">
				Your folder has now been forwarded to our <b>Loan Processing Department</b> for the next phase of validation and processing.
			</p>

			<p style="margin:0 0 16px 0;">
              Thank you for your continued cooperation.
            </p>

			<p style="margin:0 0 16px 0;">Central Customer Documentation Control </p>
			<p style="margin:0 0 16px 0;">P.A. Alvarez Group of Companies  </p>


          </td>
        </tr>

        <!-- Footer -->
        <tr>
          <td style="background-color:#f5f7f9; padding:16px 32px; font-size:11px; color:#8a94a0; text-align:center;">
            This is a system-generated notice from P.A. Properties &ndash; Central Customer Documentation Control Department. Please do not disregard this email.
          </td>
        </tr>

      </table>
    </td>
  </tr>
</table>

</body>
</html>
';

DECLARE @SMS_TEMPLATE_TURNEDOVER_TO_LDP_BANK NVARCHAR(MAX) = N'
Dear Mr./Ms. {{BUYERS_NAME}},
We’re pleased to inform you that we have completed the first step of your Bank housing loan documentation.
Your folder has now been forwarded to our Loan Processing Department for the next phase of validation and processing.
Thank you for your cooperation.
Central Customer Documentation Control
P.A. Alvarez Group of Companies
'

-- ===========================================================
-- TURNED OVER TO LPD - HDMF
-- ===========================================================

DECLARE @EMAIL_TEMPLATE_TURNEDOVER_TO_LDP_HDMF NVARCHAR(MAX) = N'<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Title Conversion – Status Update</title>
</head>
<body style="margin:0; padding:0; background-color:#eef0f2; font-family:Arial, Helvetica, sans-serif;">

<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background-color:#eef0f2; padding:24px 0;">
  <tr>
    <td align="center">
      <table role="presentation" width="600" cellpadding="0" cellspacing="0" style="background-color:#ffffff; border-radius:6px; overflow:hidden; border:1px solid #dde1e6;">

        <!-- Header / Letterhead -->
        <tr>
          <td style="background-color:#035658; padding:24px 32px;">
            <table role="presentation" width="100%" cellpadding="0" cellspacing="0">
              <tr>
                <td style="color:#ffffff; font-size:20px; font-weight:bold; font-family:Arial, Helvetica, sans-serif;">
                  P.A. Properties
                </td>
                <td align="right" style="color:#c9d6e3; font-size:12px; font-family:Arial, Helvetica, sans-serif;">
                  Central Customer Documentation Control
                </td>
              </tr>
            </table>
          </td>
        </tr>

        <!-- Body -->
        <tr>
          <td style="padding:32px; color:#26333f; font-size:14px; line-height:1.6;">

            <p style="margin:0 0 16px 0;">
              <b>Dear Mr./Ms. {{BUYERS_NAME}}</b>
            </p>

            <p style="margin:0 0 16px 0;">
             We’re pleased to inform you that we have completed the first step of your <b>Pag-IBIG housing loan documentation</b>.
            </p>

			<p style="margin:0 0 16px 0;">
              Your folder has now been forwarded to our <b>Loan Processing Department</b> for the next phase of validation and processing.
            </p>

			<p style="margin:0 0 16px 0;">
              Thank you for your continued cooperation.
            </p>

			<p style="margin:0 0 16px 0;">Central Customer Documentation Control </p>
			<p style="margin:0 0 16px 0;">P.A. Alvarez Group of Companies  </p>


          </td>
        </tr>

        <!-- Footer -->
        <tr>
          <td style="background-color:#f5f7f9; padding:16px 32px; font-size:11px; color:#8a94a0; text-align:center;">
            This is a system-generated notice from P.A. Properties &ndash; Central Customer Documentation Control Department. Please do not disregard this email.
          </td>
        </tr>

      </table>
    </td>
  </tr>
</table>

</body>
</html>
';

DECLARE @SMS_TEMPLATE_TURNEDOVER_TO_LDP_HDMF NVARCHAR(MAX) = N'
Dear Mr./Ms. {{BUYERS_NAME}},
We''re pleased to inform you that we have completed the first step of your Pag-IBIG housing loan documentation.
Your folder has now been forwarded to our Loan Processing Department for the next phase of validation and processing.
Thank you for your continued cooperation.
Central Customer Documentation Control
P.A. Alvarez Group of Companies
'


-- =====================================================================
-- Turned over to LPD from CCDC - with request to process to PAG-IBIG
-- =====================================================================

DECLARE @EMAIL_TEMPLATE_TURNEDOVER_TO_LDP_FROM_CCDC_PROCESS_PAGIBIG NVARCHAR(MAX) = N'<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Title Conversion – Status Update</title>
</head>
<body style="margin:0; padding:0; background-color:#eef0f2; font-family:Arial, Helvetica, sans-serif;">

<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background-color:#eef0f2; padding:24px 0;">
  <tr>
    <td align="center">
      <table role="presentation" width="600" cellpadding="0" cellspacing="0" style="background-color:#ffffff; border-radius:6px; overflow:hidden; border:1px solid #dde1e6;">

        <!-- Header / Letterhead -->
        <tr>
          <td style="background-color:#035658; padding:24px 32px;">
            <table role="presentation" width="100%" cellpadding="0" cellspacing="0">
              <tr>
                <td style="color:#ffffff; font-size:20px; font-weight:bold; font-family:Arial, Helvetica, sans-serif;">
                  P.A. Properties
                </td>
                <td align="right" style="color:#c9d6e3; font-size:12px; font-family:Arial, Helvetica, sans-serif;">
                  Central Customer Documentation Control
                </td>
              </tr>
            </table>
          </td>
        </tr>

        <!-- Body -->
        <tr>
          <td style="padding:32px; color:#26333f; font-size:14px; line-height:1.6;">

			<p style="margin:0 0 16px 0;">
              FAO: {{BUYERS_NAME}}<br>
			  PROJECT BLK & LOT: {{PROJECT}} {{BLK}} {{LOT}}<br>
			  HOUSE MODEL: {{MODEL}}<br>
            </p>

			<p style="margin:0 0 16px 0;">Good Day!</p>

            <p style="margin:0 0 16px 0;">
            We are glad to inform you, that we are done in our first step of completion of documents in relation to your HDMF housing loan.
			We are now forwarding your folder to Loan Processing Department for the second part of processing and validation of your account.
            </p>

			<p style="margin:0 0 16px 0;">
              However, if there are findings on the requirements, I’ll be informing you immediately for compliance.
            </p>

			<p style="margin:0 0 16px 0;">
              Succeeding requirements are to be informed by our LPD-HDMF team, like renewal of documents,
			  validations and signing of required Loan documents that our Loans Processing Department may require.
			  To avoid delay in your HDMF Loan availment your cooperation and understanding are needed.
            </p>

			<p style="margin:0 0 16px 0;">
				Here are some of the process once TURN OVER YOUR ACCOUNT TO LPD:
			</p>

			<ul>
				<li>C.I (CREDIT INVESTIGATION) OR EMPLOYMENT VERIFICATION</li>
				<li>NOLA SIGNING</li>
				<li>DOA APPROVAL</li>
				<li>ANNOTATION W/ REIGISTRY</li>
				<li>ONE ON ONE VALIDATION</li>
				<li>APPROVAL FROM PAG-IBIG (IF THERE’S, FINDINGS DOCUMENTS WILL RETURN BACK AND FOR COMPLIANCE)</li>
			</ul>

			<p style="margin:0 0 16px 0;">
				Hoping for your cooperation and coordination until Loan Take Out from PAG-IBIG.
			</p>

			<p style="margin:0 0 16px 0;">
				This is to remind you that as per policy of accounts under IN-HOUSE Financing should be continuous in paying IN-HOUSE monthly amortization until your account taken out by HDMF
			</p>

			<p style="margin:0 0 16px 0;">
				For any other inquiries you may contact our Customer Care Service at:
				<br>
				San Pedro, Laguna – Main Office
				<br>
				Telephone Numbers: (02) 8-553 3113/3117/3000 loc. 153, 154 and 145
				<br>
				FB Messenger: PAproperties CustCare Laguna
				<br>
				Email Address: custcareadvisory@paproperties.com.ph
				<br>
				Thank you and Stay Safe.
			</p>

			<p style="margin:0 0 16px 0;">Central Customer Documentation Control </p>
			<p style="margin:0 0 16px 0;">P.A. Alvarez Group of Companies  </p>


          </td>
        </tr>

        <!-- Footer -->
        <tr>
          <td style="background-color:#f5f7f9; padding:16px 32px; font-size:11px; color:#8a94a0; text-align:center;">
            This is a system-generated notice from P.A. Properties &ndash; Central Customer Documentation Control Department. Please do not disregard this email.
          </td>
        </tr>

      </table>
    </td>
  </tr>
</table>

</body>
</html>
';

DECLARE @SMS_TEMPLATE_TURNEDOVER_TO_LDP_FROM_CCDC_PROCESS_PAGIBIG NVARCHAR(MAX) = N'
FAO: {{BUYERS_NAME}}
PROJECT BLK & LOT:{{PROJECT}} {{BLK}} {{LOT}}
HOUSE MODEL: {{MODEL}}
Good day!
We are glad to inform you, that we are done in our first step of completion of documents in relation to your HDMF housing loan. We are now forwarding your folder to Loan Processing Department for the second part of processing and validation of your account.
However, if there are findings on the requirements, I''ll be informing you immediately for
compliance.
Succeeding requirements are to be informed by our LPD-HDMF team, like renewal of documents, validations and signing of required Loan documents that our Loans Processing Department may require. To avoid delay in your HDMF Loan availment your cooperation and understanding are needed.
Here are some of the process once TURN OVER YOUR ACCOUNT TO LPD:
-C.I (CREDIT INVESTIGATION) OR EMPLOYMENT VERIFICATION
-NOLA SIGNING
-DOA APPROVAL
-ANNOTATION W/ REIGISTRY
-ONE ON ONE VALIDATION
-APPROVAL FROM PAG-IBIG (IF THERE''S, FINDINGS DOCUMENTS WILL RETURN
           BACK AND FOR COMPLIANCE)
Hoping for your cooperation and coordination until Loan Take Out from PAG-IBIG.
This is to remind you that as per policy of accounts under IN-HOUSE Financing should be continuous in paying IN-HOUSE monthly amortization until your account taken out by HDMF
For any other inquiries you may contact our Customer Care Service at:
San Pedro, Laguna - Main Office
Telephone Numbers: (02) 8-553 3113/3117/3000 loc. 153, 154 and 145
FB Messenger: PAproperties CustCare Laguna
Email Address: custcareadvisory@paproperties.com.ph
Thank you and Stay Safe.
'

-- =================================================================
-- Turned over to LPD from CCDC - with request to process to BANK
-- =================================================================
DECLARE @EMAIL_TEMPLATE_TURNEDOVER_TO_LDP_FROM_CCDC_PROCESS_BANK NVARCHAR(MAX) = N'<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Title Conversion – Status Update</title>
</head>
<body style="margin:0; padding:0; background-color:#eef0f2; font-family:Arial, Helvetica, sans-serif;">

<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background-color:#eef0f2; padding:24px 0;">
  <tr>
    <td align="center">
      <table role="presentation" width="600" cellpadding="0" cellspacing="0" style="background-color:#ffffff; border-radius:6px; overflow:hidden; border:1px solid #dde1e6;">

        <!-- Header / Letterhead -->
        <tr>
          <td style="background-color:#035658; padding:24px 32px;">
            <table role="presentation" width="100%" cellpadding="0" cellspacing="0">
              <tr>
                <td style="color:#ffffff; font-size:20px; font-weight:bold; font-family:Arial, Helvetica, sans-serif;">
                  P.A. Properties
                </td>
                <td align="right" style="color:#c9d6e3; font-size:12px; font-family:Arial, Helvetica, sans-serif;">
                  Central Customer Documentation Control
                </td>
              </tr>
            </table>
          </td>
        </tr>

        <!-- Body -->
        <tr>
          <td style="padding:32px; color:#26333f; font-size:14px; line-height:1.6;">

			<p style="margin:0 0 16px 0;">
              FAO: {{BUYERS_NAME}}<br>
			  PROJECT BLK & LOT: {{PROJECT}} {{BLK}} {{LOT}}<br>
			  HOUSE MODEL: {{MODEL}}<br>
            </p>

			<p style="margin:0 0 16px 0;">Good Day!</p>

            <p style="margin:0 0 16px 0;">
				We are glad to inform you, that we are done in our first step of completion of documents in relation to your BANK housing loan.
				We are now forwarding your folder to Loan Processing Department for the second part of processing and validation of your account.
            </p>

			<p style="margin:0 0 16px 0;">
             However, if there are findings on the requirements, I’ll be informing you immediately for compliance.
            </p>

			<p style="margin:0 0 16px 0;">
              Succeeding requirements are to be informed by our LPD-BANK team, like renewal of documents,
			  validations and signing of required Loan documents that our Loans Processing Department may require.
            </p>

			<p style="margin:0 0 16px 0;">
				Hoping for your cooperation and coordination until Loan Take Out from BANK.
			</p>
			<p style="margin:0 0 16px 0;">
				This is to remind you that as per policy of accounts under IN-HOUSE Financing should be continuous in paying IN-HOUSE monthly amortization until your account taken out by BANK
			</p>


			<p style="margin:0 0 16px 0;">
				For any other inquiries you may contact our Customer Care Service at:
				<br>
				San Pedro, Laguna – Main Office
				<br>
				Telephone Numbers: (02) 8-553 3113/3117/3000 loc. 153, 154 and 145
				<br>
				FB Messenger: PAproperties CustCare Laguna
				<br>
				Email Address: custcareadvisory@paproperties.com.ph
				<br>
				Thank you and Stay Safe.
			</p>

			<p style="margin:0 0 16px 0;">Central Customer Documentation Control </p>
			<p style="margin:0 0 16px 0;">P.A. Alvarez Group of Companies  </p>


          </td>
        </tr>

        <!-- Footer -->
        <tr>
          <td style="background-color:#f5f7f9; padding:16px 32px; font-size:11px; color:#8a94a0; text-align:center;">
            This is a system-generated notice from P.A. Properties &ndash; Central Customer Documentation Control Department. Please do not disregard this email.
          </td>
        </tr>

      </table>
    </td>
  </tr>
</table>

</body>
</html>
';

DECLARE @SMS_TEMPLATE_TURNEDOVER_TO_LDP_FROM_CCDC_PROCESS_BANK NVARCHAR(MAX) = N'FAO: {{BUYERS_NAME}}
PROJECT BLK & LOT: {{PROJECT}} {{BLK}} {{LOT}}
HOUSE MODEL: {{MODEL}}
Good Day!
We are glad to inform you, that we are done in our first step of completion of documents in relation to your BANK housing loan. We are now forwarding your folder to Loan Processing Department for the second part of processing and validation of your account.
However, if there are findings on the requirements, I''ll be informing you immediately for compliance.
Succeeding requirements are to be informed by our LPD-BANK team, like renewal of documents, validations and signing of required Loan documents that our Loans Processing Department may require.
Hoping for your cooperation and coordination until Loan Take Out from BANK.
This is to remind you that as per policy of accounts under IN-HOUSE Financing should be continuous in paying IN-HOUSE monthly amortization until your account taken out by BANK
For any other inquiries you may contact our Customer Care Service at:
San Pedro, Laguna - Main Office
Telephone Numbers: (02) 8-553 3113/3117/3000 loc. 153, 154 and 145
FB Messenger: PAproperties CustCare Laguna
Email Address: custcareadvisory@paproperties.com.ph
Thank you and Stay Safe.
Central Customer Documentation Control
P.A. Alvarez Group of Companies';

BEGIN /*TEMPORARY ACCOUNTS*/
	IF OBJECT_ID('tempdb..#TMP_ACCOUNTS') IS NOT NULL
	DROP TABLE #TMP_ACCOUNTS

	SELECT
			[SYSTEM]
		,	[BUYERS_NAME]
		,	[UNIT_CODE]
		,	[PHASE]
		,	[Blk]
		,	[Lot]
		,	[MOBILE_NO]
		,	[EMAIL_ADDRESS]
		,	[ACCOUNT_STAGE]
		,	[ACCOUNT_STAGE_STATUS]
	INTO	#TMP_ACCOUNTS
	FROM	[ECast].[Account_Stage_Status]
END

BEGIN /*ALTER TABLE COLUMNS*/
	ALTER TABLE #TMP_ACCOUNTS
	ADD
		[MODEL] VARCHAR(20) NULL
	,	[TYPE] VARCHAR(80) NULL
	,	[EMAIL_TEMPLATE] NVARCHAR(MAX) NULL
	,	[SMS_TEMPLATE] NVARCHAR(MAX) NULL
END

BEGIN /*UPDATE MODEL*/
	UPDATE		main
	SET
				main.[MODEL]	= x.[ModeDesc]
	FROM		#TMP_ACCOUNTS main
	OUTER APPLY (
					SELECT		TOP 1
								[ModeDesc]
					FROM		[NOAH DATAWHSE].dbo.[UnitInventory]
					WHERE		[CODE]		= main.[UNIT_CODE]
					AND			[SYSTEM]	= main.[SYSTEM]
					AND			[STATUS]	IN (2,3)
					ORDER BY	[DATEUPDATETIME] DESC
				) x
END

BEGIN /*UPDATE TYPE*/
	UPDATE		#TMP_ACCOUNTS
	SET
				[TYPE] = (
							CASE
								WHEN [ACCOUNT_STAGE] = 'CCDC - SEASONED - FOR COMPLETION OF DOCUMENTS'
									THEN  'SEASONED'
								WHEN [ACCOUNT_STAGE] = 'TURNED OVER TO LD - BANK'
									THEN 'LD_BANK'
								WHEN [ACCOUNT_STAGE] = 'TURNED OVER TO LPD - HDMF'
									THEN 'LDP_HDMF'
								WHEN [ACCOUNT_STAGE] = 'Turned over to LPD from CCDC' AND [ACCOUNT_STAGE_STATUS] = 'With request to be processed in HDMF'
									THEN 'CCDC_HDMF'
								WHEN [ACCOUNT_STAGE] = 'Turned over to LPD from CCDC' AND [ACCOUNT_STAGE_STATUS] = 'With request to be processed in Bank'
									THEN 'CCDC_BANK'
							END
						 )
END

BEGIN /*UPDATE EMAIL TEMPLATE ACCORDING TO THE ACCOUNT STAGE & ACCOUNT STAGE STATUS*/
	UPDATE		#TMP_ACCOUNTS
	SET
				[EMAIL_TEMPLATE] = (
										CASE
											WHEN [TYPE] = 'SEASONED'
												THEN  @EMAIL_TEMPLATE_SEASONED
											WHEN [TYPE] = 'LD_BANK'
												THEN @EMAIL_TEMPLATE_TURNEDOVER_TO_LDP_BANK
											WHEN [TYPE] = 'LDP_HDMF'
												THEN @EMAIL_TEMPLATE_TURNEDOVER_TO_LDP_HDMF
											WHEN [TYPE] = 'CCDC_HDMF'
												THEN @EMAIL_TEMPLATE_TURNEDOVER_TO_LDP_FROM_CCDC_PROCESS_PAGIBIG
											WHEN [TYPE] = 'CCDC_BANK'
												THEN @EMAIL_TEMPLATE_TURNEDOVER_TO_LDP_FROM_CCDC_PROCESS_BANK
										END
								   )
			,	[SMS_TEMPLATE]	= (
										CASE
											WHEN [TYPE] = 'SEASONED'
												THEN @SMS_TEMPLATE_SEASONED
											WHEN [TYPE] = 'LD_BANK'
												THEN @SMS_TEMPLATE_TURNEDOVER_TO_LDP_BANK
											WHEN [TYPE] = 'LDP_HDMF'
												THEN @SMS_TEMPLATE_TURNEDOVER_TO_LDP_HDMF
											WHEN [TYPE] = 'CCDC_HDMF'
												THEN @SMS_TEMPLATE_TURNEDOVER_TO_LDP_FROM_CCDC_PROCESS_PAGIBIG
											WHEN [TYPE] = 'CCDC_BANK'
												THEN @SMS_TEMPLATE_TURNEDOVER_TO_LDP_FROM_CCDC_PROCESS_BANK
										END
								  )
END

BEGIN /*LD_BANK ACCOUNTS REPLACE VALUES*/
	UPDATE	#TMP_ACCOUNTS
	SET
			[EMAIL_TEMPLATE] = REPLACE([EMAIL_TEMPLATE], '{{BUYERS_NAME}}', [BUYERS_NAME])
		,	[SMS_TEMPLATE]	 = REPLACE([SMS_TEMPLATE], '{{BUYERS_NAME}}', [BUYERS_NAME])
	WHERE	[TYPE] = 'LD_BANK'
END

BEGIN /*LDP_HDMF ACCOUNTS REPLACE VALUES*/
	UPDATE	#TMP_ACCOUNTS
	SET
			[EMAIL_TEMPLATE] = REPLACE([EMAIL_TEMPLATE], '{{BUYERS_NAME}}', [BUYERS_NAME])
		,	[SMS_TEMPLATE]	 = REPLACE([SMS_TEMPLATE], '{{BUYERS_NAME}}', [BUYERS_NAME])
	WHERE	[TYPE] = 'LDP_HDMF'
END

BEGIN /*CCDC_HDMF*/
	UPDATE	#TMP_ACCOUNTS
	SET
			[EMAIL_TEMPLATE] = REPLACE(
							   REPLACE(
							   REPLACE(
							   REPLACE(
							   REPLACE(
									[EMAIL_TEMPLATE],
									N'{{BUYERS_NAME}}', [BUYERS_NAME]),
									N'{{PROJECT}}', [PHASE]),
									N'{{BLK}}', [Blk]),
									N'{{LOT}}', [LOT]),
									N'{{MODEL}}', [MODEL])
		,	[SMS_TEMPLATE] =   REPLACE(
							   REPLACE(
							   REPLACE(
							   REPLACE(
							   REPLACE(
									[SMS_TEMPLATE],
									N'{{BUYERS_NAME}}', [BUYERS_NAME]),
									N'{{PROJECT}}', [PHASE]),
									N'{{BLK}}', [Blk]),
									N'{{LOT}}', [LOT]),
									N'{{MODEL}}', [MODEL])

	WHERE	[TYPE] = 'CCDC_HDMF'
END

BEGIN /*CCDC_BANK*/
	UPDATE	#TMP_ACCOUNTS
	SET
			[EMAIL_TEMPLATE] = REPLACE(
							   REPLACE(
							   REPLACE(
							   REPLACE(
							   REPLACE(
									[EMAIL_TEMPLATE],
									N'{{BUYERS_NAME}}', [BUYERS_NAME]),
									N'{{PROJECT}}', [PHASE]),
									N'{{BLK}}', [Blk]),
									N'{{LOT}}', [LOT]),
									N'{{MODEL}}', [MODEL])
		,	[SMS_TEMPLATE] =   REPLACE(
							   REPLACE(
							   REPLACE(
							   REPLACE(
							   REPLACE(
									[SMS_TEMPLATE],
									N'{{BUYERS_NAME}}', [BUYERS_NAME]),
									N'{{PROJECT}}', [PHASE]),
									N'{{BLK}}', [Blk]),
									N'{{LOT}}', [LOT]),
									N'{{MODEL}}', [MODEL])

	WHERE	[TYPE] = 'CCDC_BANK'
END

BEGIN /*SENDING OF ECAST*/
	DECLARE @JOBS_ID INT = 46

	--INSERT INTO [ECast].[Email_Queue] (JOBS_ID, MESSAGE, EMAIL_ADDRESS, PROFILE_NAME)
	SELECT
			@JOBS_ID
		,	[EMAIL_TEMPLATE]
		,	[EMAIL_ADDRESS]
		,	'P.A. Properties'
	FROM	#TMP_ACCOUNTS

	--INSERT INTO [ECast].[SMS_Queue](JOBS_ID, MESSAGE, MOBILE_NO, MASK_NAME)
	SELECT
			@JOBS_ID
		,	[SMS_TEMPLATE]
		,	[MOBILE_NO]
		,	'P.A. Properties'
	FROM	#TMP_ACCOUNTS
END

DROP TABLE #TMP_ACCOUNTS
