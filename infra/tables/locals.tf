locals {
  datasetsArray    = jsondecode(file("${path.module}/../resource/datasets_with_tables.json"))
  datasetsMap      = {for idx, val in local.datasetsArray : idx => val}
  tables_flattened = flatten([
    for dataset in local.datasetsMap : [
      for table in dataset["tables"] : {
        datasetId              = dataset["datasetId"]
        tableId                = table["tableId"]
        tableSchemaPath        = table["tableSchemaPath"]
        partitionType          = try(table["partitionType"], null)
        partitionField         = try(table["partitionField"], null)
        expirationMs           = try(table["expirationMs"], null)
        requirePartitionFilter = try(table["requirePartitionFilter"], null)
        clustering             = try(table["clustering"], [])
      }
    ]
  ])
}