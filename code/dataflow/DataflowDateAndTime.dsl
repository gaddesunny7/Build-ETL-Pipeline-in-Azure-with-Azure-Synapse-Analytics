parameters{
	filename as string
}
source(output(
		ReportingPeriodID as integer,
		Period as integer,
		FiscalYear as integer,
		FiscalMonth as string,
		Date as string
	),
	allowSchemaDrift: true,
	validateSchema: false,
	ignoreNoFilesFound: false) ~> ReadCsvFile
ReadCsvFile derive(load_date = currentTimestamp(),
		record_source = $filename,
		mod_date = toDate(Date,'MM/dd/yyyy')) ~> TransformColumn
TransformColumn select(mapColumn(
		reporting_period_id = ReportingPeriodID,
		period = Period,
		fiscal_year = FiscalYear,
		fiscal_month = FiscalMonth,
		date = mod_date,
		load_date,
		record_source
	),
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> SelectColumn
SelectColumn sink(allowSchemaDrift: true,
	validateSchema: false,
	input(
		reporting_period_id as integer,
		period as integer,
		fiscal_year as integer,
		fiscal_month as string,
		date as date,
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
	preSQLs:['TRUNCATE TABLE [dbo].[date_time]'],
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true,
	errorHandlingOption: 'stopOnFirstError') ~> Sink