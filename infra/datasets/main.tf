resource "google_bigquery_dataset" "datasets" {
  for_each = local.datasetsMap

  project       = var.project_id
  dataset_id    = each.value["datasetId"]
  friendly_name = each.value["datasetFriendlyName"]
  description   = each.value["datasetDescription"]
  location      = each.value["datasetRegion"]
}