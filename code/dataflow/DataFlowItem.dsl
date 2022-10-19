parameters{
	filename as string
}
source(output(
		ItemID as string,
		Segment as string,
		Category as string,
		Buyer as string,
		FamilyNane as string
	),
	allowSchemaDrift: true,
	validateSchema: false,
	ignoreNoFilesFound: false) ~> ReadCsvFile
ReadCsvFile derive(first_name = substringIndex(Buyer,',',1),
		last_name = substringIndex(Buyer,',',-1),
		load_date = currentTimestamp(),
		record_source = $filename) ~> TransformColumn
TransformColumn select(mapColumn(
		item_id = ItemID,
		segment = Segment,
		category = Category,
		family_nane = FamilyNane,
		first_name,
		last_name,
		load_date,
		record_source
	),
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> SelectColumn
SelectColumn sink(allowSchemaDrift: true,
	validateSchema: false,
	input(
		item_id as integer,
		segment as integer,
		category as string,
		first_name as string,
		last_name as string,
		family_nane as integer,
		load_date as timestamp,
		record_source as string
	),
	deletable:false,
	insertable:true,
	updateable:false,
	upsertable:false,
	format: 'table',
	staged: true,
	allowCopyCommand: true,
	preSQLs:['TRUNCATE TABLE [dbo].[item]'],
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true,
	saveOrder: 1,
	errorHandlingOption: 'stopOnFirstError') ~> Sink