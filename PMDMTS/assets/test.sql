SELECT
            DECLARE
				@ID								INT = <INPUT UNIT LIST ID>,
				@Recuser						VARCHAR(80) = '999999',
				@IS_QUALIFIED					BIT = 0,
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
