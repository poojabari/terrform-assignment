#Defining the variables required in main.tf file

variable "kms_key_alias" {
    default = "myenck"
}
variable "kms_key_description" {
    default = "myenck"
}
variable "kms_deletion_days" {
    default = 7
}

variable "no_of_days_standard_IA" {}

variable "no_of_days_glacier" {}

variable "name_s3_bucket" {}

variable "region_name" {}

