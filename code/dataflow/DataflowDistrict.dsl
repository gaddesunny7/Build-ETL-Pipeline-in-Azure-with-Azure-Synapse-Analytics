parameters{
	filename as string
}
source(output(
		DistrictID as short,
		District as string,
		DM as string,
		DM_Pic_fl as string,
		DM_Pic as string,
		BusinessUnitID as short,
		DMImage as string
	),
	allowSchemaDrift: true,
	validateSchema: false,
	ignoreNoFilesFound: false) ~> ReadCsvFile
ReadCsvFile derive(load_date = currentTimestamp(),
		record_source = $filename) ~> TransformColumn
TransformColumn select(mapColumn(
		district_id = DistrictID,
		district = District,
		dm = DM,
		dm_pic_fl = DM_Pic_fl,
		dm_pic = DM_Pic,
		business_unit_id = BusinessUnitID,
		dm_image = DMImage,
		load_date,
		record_source
	),
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> SelectColumn
SelectColumn sink(allowSchemaDrift: true,
	validateSchema: false,
	input(
		district_id as integer,
		district as string,
		dm as string,
		dm_pic_fl as string,
		dm_pic as string,
		business_unit_id as integer,
		dm_image as string,
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
	preSQLs:['TRUNCATE TABLE [dbo].[district]'],
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true,
	errorHandlingOption: 'stopOnFirstError') ~> Sink