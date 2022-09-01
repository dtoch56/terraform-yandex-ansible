output "folder_id" {
  value = yandex_resourcemanager_folder.folder.id
}

output "service_account_id" {
  value = yandex_iam_service_account.admin.id
}

output "folder_admin_access_key" {
  value = yandex_iam_service_account_static_access_key.folder_admin
}
