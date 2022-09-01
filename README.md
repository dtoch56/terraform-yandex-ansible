# Yandex.Cloud folder module

Creates a folder in Yandex.Cloud and folder admin user.

## Basic example

To create a folder named `my-folder` in Yandex.Cloud with id `xxx000xxx000xxx000xx`:

```hcl
module "folder" {
  source  = "dtoch56/folder/yandex"

  cloud_id    = "xxx000xxx000xxx000xx"
  folder_name = "my-folder"
}
```

## Requirements

| Name                                            | Version  |
|-------------------------------------------------|----------|
| [terraform](https://www.terraform.io/downloads) | >= 1.1.9 |

## Providers

| Name                                                                                    | Version |
|-----------------------------------------------------------------------------------------|---------|
| [yandex-cloud](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs) | >= 0.75 |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                    | Type     |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [yandex_resourcemanager_folder](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/resourcemanager_folder)                               | resource |
| [yandex_iam_service_account](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/iam_service_account)                                     | resource |
| [yandex_resourcemanager_folder_iam_member](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/resourcemanager_folder_iam_member)         | resource |
| [yandex_iam_service_account_static_access_key](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/iam_service_account_static_access_key) | resource |

## Inputs

| Name               | Description                                            | Type           | Required | Default                  |
|--------------------|--------------------------------------------------------|----------------|:--------:|--------------------------|
| cloud_id           | Cloud that the Folder belongs to                       | `string`       |   yes    |                          |
| folder_name        | The name of the Folder                                 | `string`       |   yes    |                          |
| folder_description | A description of the Folder                            | `string`       |    no    |                          |
| folder_labels      | A set of key/value label pairs to assign to the Folder | `map(string)`  |    no    | managed-by = "terraform" |
| admin_roles        | Admin user roles in the Folder                         | `list(string)` |    no    | admin, storage.admin     |

## Outputs

| Name                    | Description                       |
|-------------------------|-----------------------------------|
| folder_id               | ID of created folder              |
| service_account_id      | ID of service account             |
| folder_admin_access_key | Service account static access key |
