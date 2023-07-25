# datasets-tables-bq-multi-module-terraform

This project how to create BigQuery Datasets and tables with Terraform and elegant Json configuration.
This example use two Terraform modules to create datasets and tables.
The deployment of IAC part is done with Cloud Build.

![datasets_with_tables_multi_module_terraform.png](images%2Fdatasets_with_tables_multi_module_terraform.png)

The article on this topic :

https://medium.com/google-cloud/create-bigquery-datasets-and-tables-with-terraform-in-an-elegant-and-scalable-way-84eab21c1b96

The video in English :

https://youtu.be/a2ULELCzdxM

The video in French :

https://youtu.be/OSU8tX_4-qk

## Build from local machine

### Set env vars in your Shell

```shell
export PROJECT_ID={{your_project_id}}
export LOCATION={{your_location}}
export TF_STATE_BUCKET={{your_tf_state_bucket}}
export TF_STATE_PREFIX={{your_tf_state_prefix}}
export GOOGLE_PROVIDER_VERSION="= 4.47.0"
```

### Plan

```shell
gcloud builds submit \
    --project=$PROJECT_ID \
    --region=$LOCATION \
    --config terraform-plan-modules.yaml \
    --substitutions _ENV=dev,_TF_STATE_BUCKET=$TF_STATE_BUCKET,_TF_STATE_PREFIX=$TF_STATE_PREFIX,_GOOGLE_PROVIDER_VERSION=$GOOGLE_PROVIDER_VERSION \
    --verbosity="debug" .
```


### Apply

```shell
gcloud builds submit \
    --project=$PROJECT_ID \
    --region=$LOCATION \
    --config terraform-apply-modules.yaml \
    --substitutions _ENV=dev,_TF_STATE_BUCKET=$TF_STATE_BUCKET,_TF_STATE_PREFIX=$TF_STATE_PREFIX,_GOOGLE_PROVIDER_VERSION=$GOOGLE_PROVIDER_VERSION \
    --verbosity="debug" .
```

### Destroy

```shell
gcloud builds submit \
    --project=$PROJECT_ID \
    --region=$LOCATION \
    --config terraform-destroy-modules.yaml \
    --substitutions _ENV=dev,_TF_STATE_BUCKET=$TF_STATE_BUCKET,_TF_STATE_PREFIX=$TF_STATE_PREFIX,_GOOGLE_PROVIDER_VERSION=$GOOGLE_PROVIDER_VERSION \
    --verbosity="debug" .
```

## Build from the project hosted in a GITHUB repository

### Plan

```shell
gcloud beta builds triggers create manual \
  --project=$PROJECT_ID \
  --region=$LOCATION \
  --name="datasets_tables_multi_module_terraform-plan" \
  --repo="https://github.com/tosun-si/sa-custom-roles-gcp-terraform" \
  --repo-type="GITHUB" \
  --branch="main" \
  --build-config="terraform-plan-modules.yaml" \
  --substitutions _ENV=dev,_TF_STATE_BUCKET=$TF_STATE_BUCKET,_TF_STATE_PREFIX=$TF_STATE_PREFIX,_GOOGLE_PROVIDER_VERSION=$GOOGLE_PROVIDER_VERSION \
  --verbosity="debug"
```

### Apply

```shell
gcloud beta builds triggers create manual \
  --project=$PROJECT_ID \
  --region=$LOCATION \
  --name="datasets_tables_one_module_terraform-apply" \
  --repo="https://github.com/tosun-si/sa-custom-roles-gcp-terraform" \
  --repo-type="GITHUB" \
  --branch="main" \
  --build-config="terraform-apply-modules.yaml" \
  --substitutions _ENV=dev,_TF_STATE_BUCKET=$TF_STATE_BUCKET,_TF_STATE_PREFIX=$TF_STATE_PREFIX,_GOOGLE_PROVIDER_VERSION=$GOOGLE_PROVIDER_VERSION \
  --verbosity="debug"
```

### Destroy

```shell
gcloud beta builds triggers create manual \
  --project=$PROJECT_ID \
  --region=$LOCATION \
  --name="datasets_tables_one_module_terraform-destroy" \
  --repo="https://github.com/tosun-si/sa-custom-roles-gcp-terraform" \
  --repo-type="GITHUB" \
  --branch="main" \
  --build-config="terraform-destroy-modules.yaml" \
  --substitutions _ENV=dev,_TF_STATE_BUCKET=$TF_STATE_BUCKET,_TF_STATE_PREFIX=$TF_STATE_PREFIX,_GOOGLE_PROVIDER_VERSION=$GOOGLE_PROVIDER_VERSION \
  --verbosity="debug"
```


